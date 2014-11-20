require 'ostruct'

require 'miomiep/version'
require 'miomiep/byte_reader'
require 'miomiep/midi_file'
require 'miomiep/track'
require 'miomiep/event'

module MioMiep
  class << self
    def read(filepath)
      File.open(filepath, 'r') do |file|
        MidiFile.parse(file)
      end
    end
  end
end