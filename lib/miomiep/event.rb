module MioMiep
  module Event    
    class Event
      attr_accessor :delta_time
      attr_accessor :total_delta_time

      def initialize(delta_time)
        @delta_time = delta_time
        @total_delta_time = 0
      end
      def to_s
        "time: %d, (%d) -- " % [@total_delta_time, @delta_time]
      end
    end
    
  end
end

require 'miomiep/event/voice_events'
require 'miomiep/event/system_events'