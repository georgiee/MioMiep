require 'spec_helper'

describe "io" do
  describe 'read midi' do
    before do
      @midi = MioMiep.read(File.join(File.dirname(__FILE__), '..','fixtures','test.mid'))
      #@midi = MioMiep.read(File.join(File.dirname(__FILE__), '..','fixtures','sounds', 'SMW-Yoshi_Island.mid'))
    end
    
    it "it has some tracks" do
      puts @midi.tracks.count
    end

    it "a track has some events" do
      puts @midi.tracks[1].events
    end
    
    it "a track has some events" do
      puts "file has #{@midi.tracks.count} tracks"
      @midi.tracks.each_with_index do |track, index|
        puts "\nTrack ##{index}"
        puts track.events
      end
    end
    
    it 'has a format' do
      puts "@midi.format #{@midi.format}"
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
