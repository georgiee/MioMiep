module MioMiep
  class MidiEvent
    attr_accessor :message, :time, :time_seconds
    include Comparable    
    def initialize(message, time = 0, time_seconds = 0)
      @message = message
      @time = time
      @time_seconds = time_seconds
    end
    
    def is? (message_type)
      @message.status == message_type
    end
    
    def is_voice?
      status = message.status
      is_channel = (status & 0xF0) != 0xF0
      is_voice = [Message::NOTE_ON, Message::NOTE_OFF, Message::NOTE_AFTERTOUCH].include? (status >> 4)
      
      is_channel && is_voice
    end

    def to_s
      base_description = "MidiEvent (%.02fs, %dp) " % [time_seconds, time]
      "%-20s| %s" % [base_description, message.to_s]
    end


    def <=> (other)
      self.time <=> other.time
    end
  end
end