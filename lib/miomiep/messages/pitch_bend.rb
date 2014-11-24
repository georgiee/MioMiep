module MioMiep
  module Message
    class PitchBend
      attr_accessor :value

      def initialize(value)
        @value = value
      end

      def to_s
        "PitchBend;"
      end
    end
  end
end