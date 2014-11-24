module MioMiep
  module Message
    class SequencerSpecific
      attr_accessor :data
      def initialize(data)
        @data = data
      end

      def to_s
        "SequencerSpecific; data: %d" % [data]
      end
    end
  end
end