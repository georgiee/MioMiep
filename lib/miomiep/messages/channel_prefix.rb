module MioMiep
  module Message
    class ChannelPrefix
      attr_accessor :type
      def initialize(type)
        @type = type
      end

      def to_s
        "ChannelPrefix; type: %d" % [type]
      end
    end
  end
end