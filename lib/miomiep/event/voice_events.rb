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
        super + ("channel: %3s" % @channel)
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
    
    class ControllerEvent < ChannelEvent
      MOD_WHEEL = 0x01
      BREATH_CONTROLLER = 0x02
      FOOT_CONTROLLER = 0x4
      PORTAMENTO_TIME = 0x5
      DATA_ENTRY_MSB = 0x6
      VOLUME = 0x7
      BALANCE = 0x8
      PAN = 0xA
      EXPRESSION_CONTROLLER = 0xB
      GEN_PURPOSE_1 = 0x10
      GEN_PURPOSE_2 = 0x11
      GEN_PURPOSE_3 = 0x12
      GEN_PURPOSE_4 = 0x19
      
      DATA_ENTRY_LSB = 38
      
      SUSTAIN = 0x40
      PORTAMENTO = 0x41
      SUSTENUTO = 0x42
      SOFT_PEDAL = 0x43
      HOLD_2 = 0x45
      
      SOUND_CONTROL_1 = 0x46 #default: Timber Variation
      SOUND_CONTROL_2 = 0x47 #default: Timber/Harmonic Content
      SOUND_CONTROL_3 = 0x48 #default: Release Time
      SOUND_CONTROL_4 = 0x49 #default: Attack Time
      
      SOUND_CONTROL_6 = 0x4A
      SOUND_CONTROL_7 = 0x4B
      SOUND_CONTROL_8 = 0x4C
      SOUND_CONTROL_9 = 0x4D
      SOUND_CONTROL_10 = 0x4E
      
      GENERAL_CONTROL_1  = 0x50
      GENERAL_CONTROL_2 = 0x51
      GENERAL_CONTROL_3 = 0x52
      GENERAL_CONTROL_4 = 0x53

      PORTAMENTO_CONTROL = 0x54
      
      EFFECTS_1 = 0x5B #formerly External Effects Depth
      EFFECTS_2 = 0x5C #formerly Tremolo Depth
      EFFECTS_3 = 0x5D #formerly Chorus Depth
      EFFECTS_4 = 0x5E #formerly Celeste Detune
      EFFECTS_5 = 0x5F #formerly Phaser Depth

      DATA_INCREMENT = 0x60
      DATA_DECREMENT = 0x61
      NREG_PARAM_LSB = 0x62
      NREG_PARAM_MSB = 0x63
      REG_PARAM_LSB = 0x64
      REG_PARAM_MSB = 0x65

      MODE_MESSAGES = 0x79..0x7F

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
  end
end