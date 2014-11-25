module MioMiep
  module Message
    class MetaMessage < MidiMessage
      attr_accessor :meta_type
      
      def initialize(meta_type)
        super(Message::META_EVENT)
        @meta_type = meta_type
      end

      def meta_name
        case meta_type
          when Message::TEXT then "TEXT"
          when Message::COPYRIGHT_NOTICE then "COPYRIGHT_NOTICE"
          when Message::TRACK_NAME then "TRACK_NAME"
          when Message::INSTRUMENT_NAME then "INSTRUMENT_NAME"
          when Message::LYRICS then "LYRICS"
          when Message::MARKER then "MARKER"
          when Message::CUE_POINT then "CUE_POINT"
          when Message::PROGRAM_NAME then "PROGRAM_NAME"
          when Message::DEVICE_NAME then "DEVICE_NAME"
          when Message::CHANNEL_PREFIX then "CHANNEL_PREFIX"
          when Message::END_OF_TRACK then "END_OF_TRACK"
          when Message::SET_TEMPO then "SET_TEMPO"
          when Message::SMPTE_OFFSET then "SMPTE_OFFSET"
          when Message::TIME_SIGNATURE then "TIME_SIGNATURE"
          when Message::KEY_SIGNATURE then "KEY_SIGNATURE"
          when Message::SEQUENCER_SPECIFIC then "SEQUENCER_SPECIFIC"
          else '<unknown meta message name>'
        end
      end

      def to_s
        "#{meta_name}"
      end
    end
  end
end