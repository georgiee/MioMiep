module MioMiep
  class MidiFile
    attr_accessor :tracks
    def initialize(options = {})
      @tracks = options.fetch(:tracks, [])
    end
  end
end