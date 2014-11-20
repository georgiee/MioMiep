module MioMiep
  module Event
    
    META_EVENT = 0xFF
    SYS_EX = 0xF0
    AUTHORIZATION_OR_DIVIDED_SYS_EX = 0xF7

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
    class TrackName < Text;end
    class InstrumentName < Text;end
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

    class EndOfTrack < Event; end


    class KeySignature < Event
      attr_accessor :key, :scale

      def initialize(delta_time, key, scale)
        super(delta_time)
        @key = key
        @scale = scale
      end
    end

    class SetTempo < Event
      attr_accessor :microseconds

      def initialize(delta_time, microseconds)
        super(delta_time)
        @microseconds = microseconds
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
    end

    class SequencerSpecific < Event
      attr_accessor :data

      def initialize(delta_time, data)
        super(delta_time)
        @data = data
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