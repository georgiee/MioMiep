module MioMiep
  module Event    
    class Event
      attr_accessor :time
      attr_accessor :delta_time
      attr_accessor :total_delta_time

      def initialize(delta_time)
        @delta_time = delta_time
        @total_delta_time = 0
        @time = 0
      end
      def to_s
        value = "time: %0.02fs (delta: %d, total: %d)" % [@time, @delta_time, @total_delta_time]
        value = "%-0s -- " % value
        value + self.class.to_s
      end
    end
    
  end
end

require 'miomiep/event/voice_events'
require 'miomiep/event/system_events'