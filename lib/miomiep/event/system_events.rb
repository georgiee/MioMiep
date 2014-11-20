module MioMiep
  module Event
    #NOTE_OFF = 0x8
    
    class SystemEvent < Event
      attr_accessor :channel

      def initialize(channel, delta_time)
        super(delta_time)
        @channel = channel
      end
    end
    
  end
end