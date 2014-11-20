module MioMiep
  module Event
      
    META_EVENT = 0xFF
    SYS_EX = 0xF0
    
    #acts as as end of byte marker and is used to detect Authorization SysEx Events
    END_OF_SYS_EX = 0xF7 

    SEQUENCE_NUMBER = 0x00
    TEXT = 0x01
    COPYRIGHT_NOTICE = 0x02
    TRACK_NAME = 0x03
    INSTRUMENT_NAME = 0x04
    LYRICS = 0x05
    MARKER = 0x06
    CUE_POINT = 0x07
    CHANNEL_PREFIX = 0x20
    END_OF_TRACK = 0x2F

    SET_TEMPO = 0x51
    SMPTE_OFFSET = 0x54
    TIME_SIGNATURE = 0x58
    KEY_SIGNATURE = 0x59
    SEQUENCER_SPECIFIC = 0x7F


    class SequenceNumber < Event
      attr_accessor :value

      def initialize(delta_time, value)
        super(delta_time)
        @value = value
      end
    end

    class Text < Event
      attr_accessor :text

      def initialize(delta_time, text)
        super(delta_time)
        @text = text
      end
    end
    class Copyright < Text;end

    #This meta event should always have a delta time of 0 and come before all MIDI Channel Events and non-zero delta time events.
    class TrackName < Text;
      def to_s
        "Event: %-20s| #{@text}" % 'track-name'
      end
    end
    class InstrumentName < Text;
      def to_s
        "Event: %-20s| #{@text}" % 'instrument-name'
      end
      
    end
    class Lyrics < Text;end
    class Marker < Text;end
    class CuePoint < Text;end
    
    class ChannelPrefix < Event
      attr_accessor :channel

      def initialize(delta_time, channel)
        super(delta_time)
        @channel = channel
      end
    end

    class EndOfTrack < Event;
      def to_s
        "Event: end-of-track"
      end
    end


    class KeySignature < Event
      attr_accessor :key, :scale

      def initialize(delta_time, key, scale)
        super(delta_time)
        @key = key
        @scale = scale
      end

      def to_s
        "Event: %-20s| key=#{key}, scale=#{scale} " % ['key-signature']
      end
    end

    class SetTempo < Event
      attr_accessor :microseconds

      def initialize(delta_time, microseconds)
        super(delta_time)
        @microseconds = microseconds
      end

      def to_s
        "Event: %-20s| microseconds: #{@microseconds}" % 'set-tempo'
      end
    end

    class SMPTEOffset < Event
      attr_accessor :hours, :minutes, :seconds, :frames, :subframes

      def initialize(delta_time, hours, minutes, seconds, frames, subframes)
        super(delta_time)

        @hours = hours
        @minutes = minutes
        @seconds = seconds
        @frames = frames
        @subframes = subframes
      end
    end
    
    class TimeSignature < Event
      attr_accessor :numer, :denom, :metro, :qnotes

      def initialize(delta_time, numer, denom, metro, qnotes)
        super(delta_time)

        @numer = numer
        @denom = denom
        @metro = metro
        @qnotes = qnotes
      end
      
      def to_s
        "Event: %-20s| numer: #{@numer}, denom: #{@denom}, metro: #{@metro}, qnotes: #{@qnotes}" % 'time-signature'
      end
    end

    class SequencerSpecific < Event
      attr_accessor :data

      def initialize(delta_time, data)
        super(delta_time)
        @data = data
      end
      def to_s
        "Event: %-20s|" % ['sequencer-specific'] + "#{data.inspect}"
      end
    end

    class SysEx < Event
      attr_accessor :data
      def initialize(delta_time, data)
        @data = data
      end
    end

    class DividedSysEx < SysEx;end
    class AuthorizationSysEx < SysEx;end
  end
end