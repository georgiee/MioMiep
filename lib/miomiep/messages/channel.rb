module MioMiep
  module Message
    class Channel
      attr_accessor :type, :channel

      def initialize(type, channel)
        @type = type
        @channel = channel
      end

      def to_s
        "ChannelMessage; "
      end
    end
  end
end