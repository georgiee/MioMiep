module MioMiep
  class Decoder
    def initialize
      @parser = Parser.new
    end
    
    def read(file)
      @byte_reader = ByteReader.new(file)

      header = read_header
      
      tracks = []
      
      header.track_count.times{
        track = read_track
        tracks << track unless track.nil?
      }
    end

    private
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
          message = @parser.find_event(track_data)

          total_time += delta_time

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
    
    def read_event(track_data)
      @parser.find_event(track_data)
    end
  end
end