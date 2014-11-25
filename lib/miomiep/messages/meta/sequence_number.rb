module MioMiep
  module Message
    class SequenceNumber < MetaMessage
      attr_accessor :value
      def initialize(value)
        super(Message::SEQUENCE_NUMBER)
        @value = value
      end
    end
  end
end