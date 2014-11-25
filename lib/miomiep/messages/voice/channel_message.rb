module MioMiep
  module Message
    class ChannelMessage < MidiMessage
      attr_accessor :channel

      def initialize(type, channel)
        super(type)
        @channel = channel
      end

      def event_type
        status >> 4
      end
      
      def event_name 
        case event_type
          when Message::NOTE_ON then 'NOTE ON'
          when Message::NOTE_OFF then 'NOTE OFF'
          when Message::NOTE_AFTERTOUCH then 'NOTE AFTERTOUCH'
          when Message::CONTROLLER then 'CONTROLLER'
          when Message::PROGRAM_CHANGE then 'PROGRAM_CHANGE'
          when Message::CHANNEL_AFTERTOUCH then 'CHANNEL_AFTERTOUCH'
          when Message::PITCH_BEND then 'PITCH_BEND'
          else '<unknown voice message name>'
        end
      end
      
      def to_s
        "#{event_name}"
      end
    end
  end
end