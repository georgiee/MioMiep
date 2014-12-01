module MioMiep
  class MidiEvent
    attr_accessor :message, :time, :time_seconds
    
    def initialize(message, time = 0, time_seconds = 0)
      @message = message
      @time = time
      @time_seconds = time_seconds
    end
    
    def is? (message_type)
      @message.status == message_type
    end

    def to_s
      base_description = "MidiEvent (%.02fs, %dp) " % [time_seconds, time]
      "%-20s| %s" % [base_description, message.to_s]
    end
  end
end