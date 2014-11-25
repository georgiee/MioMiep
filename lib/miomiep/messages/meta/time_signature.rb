module MioMiep
  module Message
    
    class TimeSignature < MetaMessage
      attr_accessor :numer, :denom, :metro, :qnotes

      def initialize(numer, denom, metro, qnotes)
        super(Message::TIME_SIGNATURE)

        @numer = numer.to_i
        @denom = denom.to_i
        @metro = metro.to_i
        @qnotes = qnotes.to_i
      end
    end
  end
end