module MioMiep
  module Message
    class ProgramChange
      attr_accessor :program_number

      def initialize(program_number)
        @program_number = program_number
      end

      def to_s
        "ProgramChange;"
      end
    end
  end
end