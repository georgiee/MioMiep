require 'miomiep/messages/midi_message'

require 'miomiep/messages/meta/meta_message'
require 'miomiep/messages/meta/text'
require 'miomiep/messages/meta/set_tempo'
require 'miomiep/messages/meta/sequence_number'
require 'miomiep/messages/meta/channel_prefix'
require 'miomiep/messages/meta/end_of_track'
require 'miomiep/messages/meta/smpte_offset'
require 'miomiep/messages/meta/time_signature'
require 'miomiep/messages/meta/key_signature'
require 'miomiep/messages/meta/sequencer_specific'

require 'miomiep/messages/voice/channel_message'
require 'miomiep/messages/voice/voice_message'
require 'miomiep/messages/voice/controller'
require 'miomiep/messages/voice/program_change'
require 'miomiep/messages/voice/channel_aftertouch'
require 'miomiep/messages/voice/pitch_bend'

require 'miomiep/messages/system/system_exclusive'
require 'miomiep/messages/system/authorization_sys_ex'


module MioMiep
  module Message
    META_EVENT = 0xFF
    SYS_EX = 0xF0
    #acts as as end of byte marker and is used to detect Authorization SysEx Events
    END_OF_SYS_EX = 0xF7 

    SEQUENCE_NUMBER = 0x00
    
    TEXT = 0x01
    COPYRIGHT_NOTICE = 0x02
    TRACK_NAME = 0x03
    INSTRUMENT_NAME = 0x04
    LYRICS = 0x05
    MARKER = 0x06
    CUE_POINT = 0x07
    #this seems to be not part of the original standard
    # http://www.midi.org/techspecs/rp19.php
    PROGRAM_NAME = 0x08
    DEVICE_NAME = 0x09

    CHANNEL_PREFIX = 0x20
    END_OF_TRACK = 0x2F

    SET_TEMPO = 0x51
    SMPTE_OFFSET = 0x54
    TIME_SIGNATURE = 0x58
    KEY_SIGNATURE = 0x59
    SEQUENCER_SPECIFIC = 0x7F

    #voice messages
    NOTE_OFF = 0x8
    NOTE_ON = 0x9
    NOTE_AFTERTOUCH = 0xA #Polyphonic Key Pressure 
    CONTROLLER = 0xB
    PROGRAM_CHANGE = 0xC
    CHANNEL_AFTERTOUCH = 0xD
    PITCH_BEND = 0xE
    
    def self.type_to_string( value )
      constants.find{ |name| const_get(name) == value }
    end

    def self.voice_status_name(status)
      case status
        when NOTE_OFF; 'NOTE_OFF'
        when NOTE_ON; 'NOTE_ON'
        when NOTE_AFTERTOUCH; 'NOTE_AFTERTOUCH'
        when CONTROLLER; 'CONTROLLER'
        when PROGRAM_CHANGE; 'PROGRAM_CHANGE'
        when CHANNEL_AFTERTOUCH; 'CHANNEL_AFTERTOUCH'
        when PITCH_BEND; 'PITCH_BEND'
      end
    end
    
    def is? (message_type)
      @status == message_type
    end
  end
end

