module MioMiep
  module Event    
    class Event
      attr_accessor :delta_time

      def initialize(delta_time)
        @delta_time = delta_time
      end
      def to_s
        "delta: %-7d -- " % @delta_time
      end
    end
    
  end
end

require 'miomiep/event/voice_events'
require 'miomiep/event/system_events'