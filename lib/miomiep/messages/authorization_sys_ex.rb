module MioMiep
  module Message
    class AuthorizationSysEx
      attr_accessor :data

      def initialize(data)
        @data = data
      end
      
      def to_s
        "AuthorizationSysEx;"
      end
    end
  end
end