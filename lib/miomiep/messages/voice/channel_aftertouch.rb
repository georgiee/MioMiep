module MioMiep
  module Message
    class ChannelAftertouch < ChannelMessage
      attr_accessor :amount

      def initialize(status, channel, amount)
        super(status, channel)
        @amount = amount
      end
    end
  end
end