module MioMiep
  module Message
    class Controller < ChannelMessage
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


      attr_accessor :controller_type, :value

      def initialize(status, channel, controller_type, value)
        super(status, channel)
        @controller_type = controller_type
        @value = value
      end
    end
  end
end