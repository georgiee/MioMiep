module MioMiep
  module Message
    class Voice
      attr_accessor :type, :note, :velocity

      def initialize(type, note, velocity)
        @type = type
        @note = note
        @velocity = velocity
      end

      def to_s
        "VoiceMessage; status: %s, note: %d, velocity: %d" % [Message::voice_status_name(type), note, velocity]
      end
    end
  end
end