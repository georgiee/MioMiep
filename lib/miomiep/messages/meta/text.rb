module MioMiep
  module Message
    
    class Text < MetaMessage
      attr_accessor :text
      
      def initialize(type, text)
        super(type)
        @text = text  
      end

      def to_s
        "%s -- text: %s" % [meta_name, text]
      end
    end
  end
end