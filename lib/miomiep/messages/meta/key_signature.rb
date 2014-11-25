module MioMiep
  module Message
    
    class KeySignature < MetaMessage
      attr_accessor :key, :scale

      def initialize(key, scale)
        super(Message::KEY_SIGNATURE)
        @key = key
        @scale = scale
      end
    end
  end
end