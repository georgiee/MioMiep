module MioMiep
  module Message
    class VoiceMessage < ChannelMessage
      attr_accessor :channel, :note, :velocity

      def initialize(type, channel, note, velocity)
        super(type, channel)
        @note = note
        @velocity = velocity
      end

      def to_s
        "%s -- note: %d, velocity: %d" % [event_name, note, velocity]
      end
    end
  end
end