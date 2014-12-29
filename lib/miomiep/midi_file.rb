module MioMiep
  class MidiFile
    attr_accessor :tracks, :format, :ticks_per_beat
    include Enumerable

    def initialize(options = {})
      @filename = options.fetch(:filename, 'untitled.mid')
      @tracks = options.fetch(:tracks, [])
      @format = options.fetch(:format, 0)
      @ticks_per_beat = options.fetch(:ticks_per_beat, 480)
    end
    
    def to_merged_events
      events = @tracks.map(&:events).flatten.select(&:is_voice?)
      #events.each_with_index.sort_by {|event, index| [event[:int], index] }.map(&:first)
      
      n = 0
      events.sort_by {|event| n+= 1; [event, n]}
      events
    end

    def duration
      max_by{ |track| track.duration}.duration
    end
    
    def each
      @tracks.each { |track| yield track }
    end

    def summary
      description = "MIDI file '#{@filename}'"
      description << "\n\t%-20s %i" % ['Format: ', @format]
      description << "\n\t%-20s %i" % ['Tracks: ', tracks.count]
      description << "\n\t%-20s %i" % ['Ticks per beat: ', @ticks_per_beat]
      description << "\n\t%-20s %.02fs" % ['Total duration: ', self.duration]
    end
    
    def describe
      description = summary
      
      description << tracks.map(&:describe).join
      description
    end
  end
end