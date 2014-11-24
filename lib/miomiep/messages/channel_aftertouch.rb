module MioMiep
  module Message
    class ChannelAftertouch
      attr_accessor :amount

      def initialize(amount)
        @amount = amount
      end

      def to_s
        "ChannelAftertouch;"
      end
    end
  end
end