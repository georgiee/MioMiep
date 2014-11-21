module MioMiep
  class Track
    include Enumerable
    attr_accessor :events, :aggregated_delta_time, :total_duration

    def initialize(options = {})
      @events = []
      @total_duration = 0
      @aggregated_delta_time = 0

      time_division = options.fetch(:time_division, TimeDivision.new)
      @heartbeat = MioMiep::Heartbeat.new
      @heartbeat.ppq = time_division.count
    end

    def name
      event = @events.detect { |e| e.kind_of?(Event::TrackName)}
      event.text || 'unknown'
    end

    def add_event(event)
      events << event
      @aggregated_delta_time += event.delta_time
      event.total_delta_time = aggregated_delta_time
      event.time = @heartbeat.ticks_to_duration(aggregated_delta_time)

      @total_duration = event.time
    end

    def instruments
      @events.select { |e| e.kind_of?(Event::InstrumentName)}
    end

    def each
      @events.each { |event| yield event }
    end

    def to_s
      header = "\n----- Track\n" 
      header += "Duration: %0.02fs\n" % @total_duration
      header += "Name: #{self.name}\n"
      header += "PPQ: %s" % @heartbeat.ppq
      header += "\n"
      header += "-----"
      header += "\n"
      content = @events.map(&:to_s).join("\n")
      header + content
    end
  end
end