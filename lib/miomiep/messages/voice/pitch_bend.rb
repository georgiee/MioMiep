module MioMiep
  module Message
    class PitchBend < ChannelMessage
      attr_accessor :value

      def initialize(status, channel, value)
        super(status, channel)
        @value = value
      end
    end
  end
end