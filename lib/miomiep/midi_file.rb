module MioMiep
  
  class MidiFile
    SINGLE_TRACK = 0
    MULTI_SYNCHRONOUS = 1
    MULTI_ASYNCHRONOUS = 2

    attr_accessor :tracks, :format, :time_division
    
    def initialize(file)
      
      @reader = ByteReader.new(file)
      @parser = Parser.new

      @tracks = []
      @format = SINGLE_TRACK
    end

    def read
      header = MidiHeader.parse(@reader.read_chunk)
      @time_division = header.time_division

      raise "oh, smpte is not supported yet!" if @time_division.is_smpte?

      header.track_count.times{
        track = read_track(@reader.read_chunk)
        @tracks << track
      }

      @format = header.format
    end
    
    def read_track(track_chunk)
      track = Track.new(time_division: @time_division)

      if (track_chunk.id != 'MTrk')
        raise "Unexpected chunk - expected MTrk, got "+ track_chunk.id;
      end
      
      track_data = track_chunk.data
      
      while (!track_data.eof)
        event = @parser.find_event(track_data)
        track.add_event(event)
      end

      track
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
      
      
      time_division_data = data.read_int16
      #time_division_data = 0x9978
      time_division = TimeDivision.new

      if (time_division_data & 0x8000).nonzero?
        time_division.smpte = true

        #time division in SMPTE frames and ticker per frame
        time_division_data = time_division_data&0x7FFF
        time_division.fps = time_division_data >> 8
        time_division.count = time_division_data  & 0x00FF
      else
        #ticks per beat, common from 48 to 960, 
        time_division.smpte = false
        time_division.count = time_division_data  & 0x00FF
      end

      header.time_division = time_division
      
      header
    end

    attr_accessor :format, :track_count, :time_division
  end

  class TimeDivision
    attr_accessor :fps, :smpte, :count
    def initialize
      @count = Heartbeat::DEFAULT_PPQ

      @smpte = false
      @fps = -1
    end
    
    def is_smpte?
      @smpte == true
    end
    
    def to_s
      if is_smpte?
        "Time Division: #{@count} ticks per frame; #{fps}fps"
      else
        "Time Division: #{@count} ticks per beat"
      end
    end
  end
  
end