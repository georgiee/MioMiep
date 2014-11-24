module MioMiep
  module Message
    
    class SMPTEOffset
      attr_accessor :hours, :minutes, :seconds, :frames, :subframes

      def initialize(hours, minutes, seconds, frames, subframes)
        @hours = hours
        @minutes = minutes
        @seconds = seconds
        @frames = frames
        @subframes = subframes
      end

      def to_s
        "SMPTEOffset;"
      end
    end
  end
end