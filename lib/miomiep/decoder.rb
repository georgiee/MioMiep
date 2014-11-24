module MioMiep
  class Decoder
    def initialize
      @parser = Parser.new
    end
    
    def read(file)
      @byte_reader = ByteReader.new(file)

      header = read_header
      
      tracks = []
      
      #header.track_count.times{
      1.times{
        track = read_track
        tracks << track unless track.nil?
      }
    end

    #private
    def read_header
      header_chunk = @byte_reader.read_chunk
      data = header_chunk.data
        
      header = OpenStruct.new
      header.format = data.read_int16
      header.track_count = data.read_int16
      header.time_division = data.read_int16

      header
    end
    
    def read_track
      track_chunk = @byte_reader.read_chunk
      
      if (track_chunk.id != 'MTrk')
        raise "Unexpected chunk - expected MTrk, got "+ track_chunk.id;
      end

      track_data = track_chunk.data
      events = []

      total_time = 0;
      
      while (!track_data.eof)
        begin
          delta_time = track_data.read_varint
          total_time += delta_time

          message = read_message(track_data)

          unless message.nil?
            event = MidiEvent.new(message, total_time)
            events << event
          end

        rescue Exception => exception
          puts 'some error during event parsinge', exception
          break;
        end
      end
      
      Track.new(events)
    end
    
    def read_message(data)
      @status_byte = data.read_int8
      puts "status_byte %08b" % @status_byte
      
      if (@status_byte & 0xF0) != 0xF0
        find_voice_message(data)
      elsif @status_byte == 0xFF
        find_meta_message(data)
      else
        find_system_message(data)
      end
    end
    
    def find_voice_message(data)
      puts "find voice message"

      status = @status_byte >> 4
      channel = @status_byte & 0x0f #0 - 15
      
      param1 = data.read_int8
      puts "status %04b" % status, status
      
      case status
        when Message::NOTE_ON, Message::NOTE_OFF, Message::NOTE_AFTERTOUCH
          note = param1
          velocity = data.read_int8
          Message::Voice.new(status, note, velocity)
      end      
    end

    def find_system_message(data)
      puts "find_system_message"
    end

    def find_meta_message(data)
      meta_type = data.read_int8
      length = data.read_varint

      text_messages = [
        Message::TEXT, Message::COPYRIGHT_NOTICE, Message::COPYRIGHT_NOTICE,
        Message::TRACK_NAME, Message::INSTRUMENT_NAME,
        Message::LYRICS, Message::MARKER, Message::CUE_POINT,
        Message::PROGRAM_NAME, Message::DEVICE_NAME
      ]
      
      case meta_type
        when Message::SEQUENCE_NUMBER
          msb = data.read_int8
          lsb = data.read_int8
          Message::SequenceNumber.new(msb << 7 | lsb)

        when *text_messages then
          text  = data.read(length)
          Message::Text.new(meta_type, text)
        
        when Message::CHANNEL_PREFIX
          type = data.read_int8
          Message::ChannelPrefix.new(type)
        
        when Message::END_OF_TRACK
          Message::EndOfTrack.instance
        
        when Message::SET_TEMPO then
          microseconds = data.read_int24
          Message::SetTempo.new(microseconds)
        
        when Message::SMPTE_OFFSET
          hours, minutes, seconds, frames, subframes = 5.times.map{ data.read_int8 }
          Message::SMPTEOffset.new(hours, minutes, seconds, frames, subframes)

        when Message::TIME_SIGNATURE
          numer, denom, metro, qnotes = 4.times.map{ data.read_int8 }
          Message::TimeSignature.new(numer, denom, metro, qnotes)

        when Message::KEY_SIGNATURE
          key = data.read_int8
          scale = data.read_int8(true)
          Message::KeySignature.new(key, scale)
        
        when Message::SEQUENCER_SPECIFIC
          data  = data.read(length)
          Message::SequencerSpecific.new(data)
      end
    end
  end
end