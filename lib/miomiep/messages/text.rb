module MioMiep
  module Message
    
    class Text
      attr_accessor :text, :type
      
      def initialize(type, text)
        @type = type
        @text = text  
      end

      def to_s
        "TextMessage; status: %s, text: %s" % [Message.type_to_string(type), text]
      end
    end
  end
end