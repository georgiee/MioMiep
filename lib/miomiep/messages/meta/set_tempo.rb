module MioMiep
  module Message
    
    class SetTempo < MetaMessage
      attr_accessor :microseconds
      
      def initialize(microseconds)
        super(Message::SET_TEMPO)
        @microseconds = microseconds
      end
    end
  end
end