module MioMiep
  class Track
    include Enumerable
    attr_accessor :events, :aggregated_delta_time

    def initialize
      @events = []
      @aggregated_delta_time = 0
    end

    def name
      event = @events.detect { |e| e.kind_of?(Event::TrackName)}
      event.text || 'unknown'
    end

    def add_event(event)
      events << event
      @aggregated_delta_time += event.delta_time
      event.total_delta_time = aggregated_delta_time
      
    end

    def instruments
      @events.select { |e| e.kind_of?(Event::InstrumentName)}
    end

    def each
      @events.each { |event| yield event }
    end
  end
end