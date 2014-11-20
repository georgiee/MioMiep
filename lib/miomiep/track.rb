module MioMiep
  class Track
    include Enumerable
    attr_accessor :events

    def initialize
      @events = []
    end

    def name
      event = @events.detect { |e| e.kind_of?(Event::TrackName)}
      event.text || 'unknown'
    end

    def instruments
      @events.select { |e| e.kind_of?(Event::InstrumentName)}
    end

    def each
      @events.each { |event| yield event }
    end
  end
end