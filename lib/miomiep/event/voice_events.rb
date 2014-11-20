module MioMiep
  module Event
    NOTE_OFF = 0x8
    NOTE_ON = 0x9
    NOTE_AFTERTOUCH = 0xA #Polyphonic Key Pressure 
    CONTROLLER = 0xB
    PROGRAM_CHANGE = 0xC
    CHANNEL_AFTERTOUCH = 0xD
    PITCH_BEND = 0xE

    class ChannelEvent < Event
      attr_accessor :channel

      def initialize(channel, delta_time)
        super(delta_time)
        @channel = channel
      end

      def to_s
        ("channel: %3s" % @channel)
      end
    end

    class NoteEvent < ChannelEvent
      attr_accessor :note, :velocity
      
      def initialize(channel, delta_time, note, velocity)
        super(channel, delta_time)
        @note = note
        @velocity = velocity
      end

      PITCHES = %w(C C# D D# E F F# G G# A A# B)

      def to_s
        super + (", note: #{note}, velocity: #{velocity}")
      end
    end

    class NoteOffEvent < NoteEvent;
      def to_s
        "Event: %-20s| " % 'note-off' + super
      end
    end
    class NoteOnEvent < NoteEvent;
      def to_s
        "Event: %-20s| " % 'note-on' + super
      end
    end

    class NoteAfterTouchEvent < ChannelEvent
      attr_accessor :note, :value
      def initialize(channel, delta_time, note, value)
        super(channel, delta_time)
        @note = note
        @value = value
      end
    end

    class ControllerEvent < ChannelEvent
      attr_accessor :controller, :value
      def initialize(channel, delta_time, controller, value)
        super(channel, delta_time)
        @controller = controller
        @value = value
      end
      
      def to_s
        "Event: %-20s| " % 'controller' + super + (", type: #{@controller} value: #{@value}") 
      end
    end

    class ProgramChangeEvent < ChannelEvent
      # the program number of the new instrument/patch.
      attr_accessor :number
      
      def initialize(channel, delta_time, number)
        super(channel, delta_time)
        @number = number
      end
      
      def to_s
        ("Event: %-20s| " + super + ", number: #{number}") % 'program-change'
      end
    end

    class ChannelAfterTouchEvent < ChannelEvent
      attr_accessor :value
      
      def initialize(channel, delta_time, value)
        super(channel, delta_time)
        @value = value
      end
    end

    class PitchBendEvent < ChannelEvent
      attr_accessor :value
      def initialize(channel, delta_time, value)
        super(channel, delta_time)
        @value = value
      end
    end
    
  end
end