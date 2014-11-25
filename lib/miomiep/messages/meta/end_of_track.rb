require 'singleton'

module MioMiep
  module Message
    class EndOfTrack < MetaMessage
      include Singleton
      def initialize
        super(Message::END_OF_TRACK)
      end
    end
  end
end