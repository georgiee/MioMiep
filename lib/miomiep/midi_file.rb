module MioMiep
  
  class MidiFile
    attr_accessor :tracks
    
    def initialize(file)
      @reader = ByteReader.new(file)
    end

    def read
      header = MidiHeader.parse(@reader.read_chunk)
      header.track_count.times{
        read_track(@reader.read_chunk)
      }
    end
    
    def read_track(track_chunk)
      puts "\n#################### read track"
      puts "#{@reader.io.pos - track_chunk.length - 4 - 4}"

      if (track_chunk.id != 'MTrk')
        raise "Unexpected chunk - expected MTrk, got "+ track_chunk.id;
      end
      
      track_data = track_chunk.data
      
      while (!track_data.eof)
        EventParser.parse(track_data)
      end
    end

    def self.parse(file)
      midi = new(file)
      midi.read

      midi
    end
  end

  class MidiHeader
    def self.parse(chunk)
      if (chunk.id != 'MThd' || chunk.length != 6)
        raise "Bad .mid file - header not found";
      end

      header = new
      data = chunk.data
      
      header.format = data.read_int16
      header.track_count = data.read_int16
      header.time_division = data.read_int16

      if header.time_division & 0x8000
        #raise 'Expressing time division in SMTPE frames is not supported yet'
      end

      header
    end

    attr_accessor :format, :track_count, :time_division
  end


  class EventParser
    def self.parse(data)
      puts "\n##### read event"

      delta_time = data.read_varint
      event_type = data.read_int8
      
      puts "delta time: #{delta_time}"      
      puts "event_type: %0X" % event_type 
      #puts "event_type: #{ByteReader.debug(event_type, 8)}" 
      
      if((event_type & 0xf0) == 0xf0) #front four bits are 1 (11110000)
        #System Common Category messages
        case event_type
          when 0xff then
            event_sub_type = data.read_int8
            length = data.read_varint
            puts "event_sub_type #{ '0x%0X' % event_sub_type}"
            case event_sub_type
              when Event::SEQUENCE_NUMBER
                raise "length must be 2" unless length == 2
                msb = data.read_int8
                lsb = data.read_int8
                return Event::SequenceNumber.new(delta_time, msb << 7 | lsb)
              
              when Event::TEXT
                text  = data.read(length)
                return Event::Text.new(delta_time, text)

              when Event::COPYRIGHT_NOTICE
                text  = data.read(length)
                return Event::Copyright.new(delta_time, text)

              when Event::TRACK_NAME
                text  = data.read(length)
                return Event::TrackName.new(delta_time, text)
              
              when Event::INSTRUMENT_NAME
                text  = data.read(length)
                return Event::InstrumentName.new(delta_time, text)
              
              when Event::LYRICS
                text  = data.read(length)
                return Event::Lyrics.new(delta_time, text)

              when Event::MARKER
                text  = data.read(length)
                return Event::Marker.new(delta_time, text)

              when Event::CUE_POINT
                text  = data.read(length)
                return Event::CuePoint.new(delta_time, text)

              when Event::CHANNEL_PREFIX
                channel  = data.read_int8
                return Event::ChannelPrefix.new(delta_time, channel)
              
              when Event::END_OF_TRACK
                return Event::EndOfTrack.new(delta_time)

              when Event::SET_TEMPO
                raise "length must be 3" unless length == 3
                
                microseconds = data.read_int24
                return Event::SetTempo.new(delta_time, microseconds)
              
              when Event::SMPTE_OFFSET
                raise "length must be 5" unless length == 5
                
                hours, minutes, seconds, frames, subframes = 5.times.map{ data.read_int8 }
                return Event::SMPTEOffset.new(delta_time, hours, minutes, seconds, frames, subframes)
              
              when Event::TIME_SIGNATURE
                raise "length must be 4" unless length == 4
                numer, denom, metro, qnotes = 4.times.map{ data.read_int8 }
                return Event::TimeSignature.new(delta_time, numer, denom, metro, qnotes)

              when Event::KEY_SIGNATURE
                raise "length must be 2" unless length == 2
                key = data.read_int8
                scale = data.read_int8(true)
                return Event::KeySignature.new(delta_time, key, scale)

              when Event::SEQUENCER_SPECIFIC
                data  = data.read(length)
                return Event::SequencerSpecific.new(delta_time, data)
            end
                    
          when Event::SYS_EX, Event::AUTHORIZATION_OR_DIVIDED_SYS_EX
            eof_sys = 0x7F
            data  = data.read(length)
            puts "@divided_sys_active #{@divided_sys_active}"
            case event_type
              when Event::SYS_EX
                puts '#SYS_EX'
                @divided_sys_active = data.bytes.last != eof_sys
                if @divided_sys_active
                  puts 'start ing divided sys ex'
                  return Event::DividedSysEx.new(delta_time, data)
                else
                  return Event::SysEx.new(delta_time, data)
                end
              
              when Event::AUTHORIZATION_OR_DIVIDED_SYS_EX
                if @divided_sys_active
                  
                  if @divided_sys_active = data.bytes.last != eof_sys
                    puts 'continue sys ex message'
                  else
                    puts 'finish sys ex message'
                    @divided_sys_active = false
                  end
                  
                  return Event::DividedSysEx.new(delta_time, data)
                  
                else
                  return Event::AuthorizationSysEx.new(delta_time, data)
                end
            end            
        end
      else
        #well. this must be a channel event
        # our front four bits are between 1000 and 1110 (0x80  - 0xE0)
        # including the channel values between 0 - 15
        # A Voice Category is between (0x80 and 0xEF) (0x8 with channel 0 and 0xE with channel 15)
        # 
        # So if the most significant bit is 0, we have a running status (as it's no System Common Category or Voice category)
        # this is because param1 & param2 are restricte to values of 0 - 127 (0x7F)
        # so we can assume any incoming event type with the first bit missing must be a parameter
        # and therefore be part of a running status.
        
        puts 'found midi channel event'

        event_type_byte = event_type
        
        #Running status is only implemented for Voice Category messages (ie, Status is 0x80 to 0xEF).
        #so check f  
        
        if (event_type_byte & 0x80).zero?
          #running status
          param1 = event_type_byte
          param2 = data.read_int8
          event_type_byte = @last_event_type_byte
        else
          param1 = data.read_int8
          param2 = data.read_int8

          @last_event_type_byte = event_type_byte
        end
        
        event_type = event_type_byte >> 4
        channel = event_type_byte&0x0f #0 - 15
        
        case event_type 
          
          when Event::NOTE_OFF
            return Event::NoteOffEvent.new(channel, delta_time, param1, param2)

          when Event::NOTE_ON
            return Event::NoteOnEvent.new(channel, delta_time, param1, param2)

          when Event::NOTE_AFTERTOUCH
            return Event::NoteAfterTouchEvent.new(channel, delta_time, param1, param2)

          when Event::CONTROLLER
            return Event::ControllerEvent.new(channel, delta_time, param1, param2)
          
          when Event::PROGRAM_CHANGE
            return Event::ProgramChangeEvent.new(channel, delta_time, param1)
          
          when Event::CHANNEL_AFTERTOUCH
            return Event::ChannelAfterTouchEvent.new(channel, delta_time, param1)
          
          when Event::PITCH_BEND
            return Event::PitchBendEvent.new(channel, delta_time, param2 << 7 | param1) #p1=lsb, p2=msb
          
          else
            raise 'no matching event found'
        end
      end
    end
  end
end