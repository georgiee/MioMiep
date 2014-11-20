module MioMiep
  
  class MidiFile
    attr_accessor :tracks
    
    def initialize(file)
      @reader = ByteReader.new(file)
      @parser = Parser.new

      @tracks = []
    end

    def read
      header = MidiHeader.parse(@reader.read_chunk)
      header.track_count.times{
        read_track(@reader.read_chunk)
      }
    end
    
    def read_track(track_chunk)
      track = Track.new

      if (track_chunk.id != 'MTrk')
        raise "Unexpected chunk - expected MTrk, got "+ track_chunk.id;
      end
      
      track_data = track_chunk.data
      
      while (!track_data.eof)
        track.events << @parser.find_event(track_data)
      end

      @tracks << track
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


  
end