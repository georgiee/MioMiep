require 'spec_helper'

describe "io" do
  describe 'read midi' do
    before do
      @midi = MioMiep.read(File.join(File.dirname(__FILE__), '..','fixtures', 'Mwyoshi.mid'))
    end
    
    it "it has some tracks" do
      puts @midi.tracks.count
    end

    it "a track has some events" do
      puts @midi.tracks[2].events
    end

    it "a track has a name" do
      track = @midi.tracks.last
      puts track.name
    end

    it "get instruments" do
      track = @midi.tracks.last
      puts track.instruments
    end
  end
end
