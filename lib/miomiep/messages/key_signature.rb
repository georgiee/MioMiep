module MioMiep
  module Message
    
    class KeySignature
      attr_accessor :key, :scale

      def initialize(key, scale)
        @key = key
        @scale = scale
      end

      def to_s
        "KeySignature: key=#{key}, scale=#{scale} "
      end
    end
  end
end