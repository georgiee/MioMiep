module MioMiep
  class Heartbeat
    DEFAULT_BPM  = 120
    DEFAULT_PPQ  = 96
    MICROSECONDS_PER_MINUTE = 60_000_000
    
    #pulses Per Quarter, microseconds per quaternote
    attr_accessor :ppq, :mpq

    def initialize
      @ppq = DEFAULT_PPQ
      self.bpm = DEFAULT_BPM
    end
    
    def bpm=(value)
      @mpq = MICROSECONDS_PER_MINUTE / value
    end
    def bpm
      MICROSECONDS_PER_MINUTE / @mpq
    end

    #seconds per quaternote
    def qls
      @mpq/1_000_000.0
    end
    
    #seconds per tick
    def tdps
      qls/@ppq.to_f
    end
    
    def ticks_to_duration(ticks)
      ticks * tdps #same as: (ticks/heartbeat.ppq/heartbeat.bpm) * 60.0
    end
  end
end