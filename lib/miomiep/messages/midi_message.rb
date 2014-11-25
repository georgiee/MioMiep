module MioMiep
  module Message
    class MidiMessage
      attr_accessor :status
      
      def initialize(status)
        @status = status
      end
    end
  end
end