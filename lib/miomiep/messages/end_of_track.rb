require 'singleton'

module MioMiep
  module Message
    class EndOfTrack
      include Singleton

      def to_s
        "EndOfTrack"
      end
    end
  end
end