module MioMiep
  module Message
    
    class SMPTEOffset < MetaMessage
      attr_accessor :hours, :minutes, :seconds, :frames, :subframes

      def initialize(hours, minutes, seconds, frames, subframes)
        super(Message::SMPTE_OFFSET)
        @hours = hours
        @minutes = minutes
        @seconds = seconds
        @frames = frames
        @subframes = subframes
      end
    end
  end
end