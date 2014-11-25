module MioMiep
  module Message
    class ChannelPrefix < MetaMessage
      attr_accessor :channel_type
      
      def initialize(channel_type)
        super(Message::CHANNEL_PREFIX)
        @channel_type = channel_type
      end
    end
  end
end