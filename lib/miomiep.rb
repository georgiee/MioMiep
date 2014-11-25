require 'ostruct'

require 'miomiep/version'
require 'miomiep/byte_reader'
require 'miomiep/midi_file'
require 'miomiep/midi_event'
require 'miomiep/parser'
require 'miomiep/track'
require 'miomiep/event'
require 'miomiep/note'
require 'miomiep/heartbeat'
require 'miomiep/decoder'
require 'miomiep/message'

require 'miomiep/midi_file_old'
require 'miomiep/track_old'

module MioMiep
  DEFAULT_MIDDLE_C = 69 #General MIDI Standard, A440 is note 69
  
  class << self
    def read(filepath)
      File.open(filepath, 'r') do |file|
        MidiFileOld.parse(file)
      end
    end


    def configure
      yield config
    end

    def config
      @config ||= OpenStruct.new(middle_c: DEFAULT_MIDDLE_C)
    end
  end
end