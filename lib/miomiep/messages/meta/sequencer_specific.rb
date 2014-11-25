module MioMiep
  module Message
    class SequencerSpecific < MetaMessage
      attr_accessor :data
      
      def initialize(data)
        super(Message::SEQUENCER_SPECIFIC)
        @data = data
      end
    end
  end
end