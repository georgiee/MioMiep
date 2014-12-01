module MioMiep
  module Message
    
    class SetTempo < MetaMessage
      attr_accessor :microseconds
      
      def initialize(microseconds)
        super(Message::SET_TEMPO)
        @microseconds = microseconds
      end


      def to_s
        super  + " -- microseconds: %d" % @microseconds
      end
    end
  end
end