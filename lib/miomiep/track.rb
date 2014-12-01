module MioMiep
  class Track
    include Enumerable
    
    attr_accessor :events, :name, :duration
    
    def initialize(events = [])
      @events = events
      @name = 'untitled'
      @duration = 0

      scan_events if @events.count > 0
    end
    
    def scan_events
      #find a track name
      if message = find_meta_message(Message::TRACK_NAME)
        @name = message.text
      end

      #total duration
      @duration = events.last.time_seconds
    end

    def each
      @events.each { |event| yield event }
    end
    
    def find_meta_message(meta_type)
      meta_event = detect{ |event| event.is?(Message::META_EVENT) && event.message.meta_type == meta_type }
      if meta_event.nil?
        return nil
      else
        meta_event.message
      end
    end

    def describe
      output = "\n----- Track\n" 
      output += "Name: #{name}\n"
      output += "\nEvents:"
      output += "\n"
      output += @events.map(&:to_s).join("\n")
    end
  end
end
