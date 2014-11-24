module MioMiep
  module Message
    class SequenceNumber
      attr_accessor :value
      def initialize(value)
        @value = value
      end

      def to_s
        "SequenceNumber; value: %d" % [value]
      end
    end
  end
end