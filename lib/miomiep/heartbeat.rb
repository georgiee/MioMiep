require 'ostruct'

module MioMiep
  class Heartbeat
    DEFAULT_BPM  = 120
    DEFAULT_PPQ  = 96
    MICROSECONDS_PER_MINUTE = 60_000_000
    
    #pulses Per Quarter, microseconds per quaternote
    attr_accessor :ppq, :mpq, :time_signature

    def initialize
      @ppq = DEFAULT_PPQ
      @time_signature = OpenStruct.new(numer:4, denom: 2, metro: 24, notes: 8)
      self.bpm = DEFAULT_BPM
    end
    
    def bpm=(value)
      @mpq = MICROSECONDS_PER_MINUTE / value
    end
    def bpm
      MICROSECONDS_PER_MINUTE / @mpq
    end

    def tempo=(value)
      puts "Heartbeat: new tempo: #{value}"
      @mpq = value
    end

    #seconds per quaternote
    def qls
      @mpq/1_000_000.0
    end
    #Pulse Length = 60/(BPM * PPQN)
    
    #seconds per tick
    def tdps
      #http://www.deluge.co/?q=midi-tempo-bpm
      
      metro = 24.0/@time_signature.metro.to_f
      
      t = @time_signature.numer.to_f / (2**@time_signature.denom.to_f)
      value = qls/@ppq.to_f * metro
      #problem #1, total duration of Mwyoshi.mid is exactly 1/4 too small
      #correct result wood be acheived with value * 4/3. What's the reason? Metronome ? 
      
      #YI_Maps is 5times to long. Where is the factor 1/5 from?
      value
    end
    
    def ticks_to_duration(ticks)
      ticks * tdps #same as: (ticks/heartbeat.ppq/heartbeat.bpm) * 60.0
    end
  end
end