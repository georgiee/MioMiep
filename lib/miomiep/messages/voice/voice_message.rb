module MioMiep
  module Message
    class VoiceMessage < ChannelMessage
      attr_accessor :channel, :note, :velocity

      def initialize(type, channel, note, velocity)
        super(type, channel)
        @note = note
        @velocity = velocity
        #@note2 = Note.new(@note, @velocity)
      end

      def to_s
        output = "%s -- note: %d (%s), velocity: %d" % [event_name, note, Note.note_to_key(note), velocity]
      end
    end
  end
end