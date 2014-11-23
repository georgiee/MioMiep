require 'spec_helper'

describe 'decoder' do
  before do
    @file_path = File.join(File.dirname(__FILE__), '..','fixtures','sounds', 'SMW-Yoshi_Island.mid')

  end
  
  it 'decodes a file' do
    File.open(@file_path) do |file|
      decoder = MioMiep::Decoder.new
      decoder.read(file)
    end
  end
end