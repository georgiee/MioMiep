module MioMiep
  class MidiEvent
    attr_accessor :message, :time
    
    def initialize(message, time = 0)
      @message = message
      @time = time
    end
    
    def is? (message_type)
      @message.status == message_type
    end

    def to_s
      "%-20s| %s" % ["MidiEvent (#{time}p) ", message.to_s]
    end
  end
end