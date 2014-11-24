module MioMiep
  module Message
    
    class TimeSignature
      attr_accessor :numer, :denom, :metro, :qnotes

      def initialize(numer, denom, metro, qnotes)
        @numer = numer.to_i
        @denom = denom.to_i
        @metro = metro.to_i
        @qnotes = qnotes.to_i
      end
      
      def to_s
        "TimeSignature: numer: #{@numer}, denom: #{@denom}, metro: #{@metro}, qnotes: #{@qnotes}"
      end
    end
  end
end