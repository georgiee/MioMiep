module MioMiep
  module Message
    class SystemExclusive
      attr_accessor :data, :incomplete

      def initialize
        @data = []
        @incomplete = true
      end
      
      def incomplete?
        @incomplete == true
      end
      
      def complete!
        @incomplete = false
      end   
      
      def << (data)
        raise 'cannot add, system message already completed' unless incomplete?
        @data << data
      end

      def to_s
        "SystemExclusive;"
      end
    end
  end
end