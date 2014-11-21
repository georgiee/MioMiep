module MioMiep
  class Track
    include Enumerable
    
    attr_accessor :events, :aggregated_delta_time, :total_duration

    def initialize(options = {})
      @events = []
      @total_duration = 0
      @aggregated_delta_time = 0

      @heartbeat = options.fetch(:heartbeat, Heartbeat.new)
      @channel_map = []
    end

    def name
      event = @events.detect { |e| e.kind_of?(Event::TrackName)}
      (event && event.text) || 'unknown'
    end

    def add_event(event)

      events << event

      if(event.kind_of? (Event::ChannelEvent))
        
        channel = event.channel
        #create 
        #map = @channel_map[channel] || OpenStruct.new(aggregated_delta_time: 0)
        #@channel_map[channel] = map

        #map.aggregated_delta_time += event.delta_time
        
        #event.total_delta_time = map.aggregated_delta_time
        #event.time = @heartbeat.ticks_to_duration(map.aggregated_delta_time)

      end

      @aggregated_delta_time += event.delta_time
      event.total_delta_time = @aggregated_delta_time
      event.time = @heartbeat.ticks_to_duration(@aggregated_delta_time)  

      #TODO: is set-tempo global or per track ? Now global as we share a global heartebat instance.
      if(event.kind_of? (Event::SetTempo))
        @heartbeat.tempo = event.microseconds
      end  
      
      if(event.kind_of? (Event::TimeSignature))
        @heartbeat.time_signature = event.params
      end
      
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

    def <=> (other) #1 if self>other; 0 if self==other; -1 if self<other
      self.total_duration <=> other.total_duration
    end
  end
end