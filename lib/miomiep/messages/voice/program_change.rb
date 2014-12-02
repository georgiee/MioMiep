module MioMiep
  module Message
    class ProgramChange < ChannelMessage
      attr_accessor :program_number

      def initialize(status, channel, program_number)
        super(status, channel)
        @program_number = program_number
      end
      
      def to_s
        super << " -- program number: #{@program_number}" 
      end
    end
  end
end