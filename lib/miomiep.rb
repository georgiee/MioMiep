require 'ostruct'

require 'miomiep/version'
require 'miomiep/byte_reader'
require 'miomiep/midi_file'
require 'miomiep/midi_event'
require 'miomiep/parser'
require 'miomiep/track'
require 'miomiep/note'
require 'miomiep/decoder'
require 'miomiep/message'

module MioMiep
  DEFAULT_MIDDLE_C = 5 #General MIDI Standard, A440 is note 69
  
  class << self
    def configure
      yield config
    end

    def config
      #middle c in which octave ?
      @config ||= OpenStruct.new(middle_c: DEFAULT_MIDDLE_C)
    end
  end
end