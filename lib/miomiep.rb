require 'ostruct'

require 'miomiep/version'
require 'miomiep/byte_reader'
require 'miomiep/midi_file'
require 'miomiep/parser'
require 'miomiep/track'
require 'miomiep/event'
require 'miomiep/note'
require 'miomiep/heartbeat'

module MioMiep
  DEFAULT_MIDDLE_C = 69 #General MIDI Standard, A440 is note 69
  
  class << self
    def read(filepath)
      File.open(filepath, 'r') do |file|
        MidiFile.parse(file)
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