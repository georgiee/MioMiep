module MioMiep
  module Message
    
    class SetTempo
      attr_accessor :microseconds
      
      def initialize(microseconds)
        @microseconds = microseconds
      end

      def to_s
        "SetTempoMessage; microseconds: %d" % @microseconds
      end
    end
  end
end