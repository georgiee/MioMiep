require 'spec_helper'
require 'midilib'

describe "io" do
  describe 'read midi' do
    before do
      #@midi = MioMiep.read(File.join(File.dirname(__FILE__), '..','fixtures','test.mid'))
      @file_path = File.join(File.dirname(__FILE__), '..','fixtures','sounds', 'SMW-Yoshi_Island.mid')
      @midi = MioMiep.read(@file_path)
    end
    
    it "it has a time division" do
      puts @midi.time_division
    end

    it "it has some tracks" do
      puts @midi.tracks.count
    end

    it "a track has some events" do
      puts @midi.time_division
      puts @midi.tracks[0].events
      puts @midi.tracks[1].events
    end

    it 'heartbeat' do
      heartbeat = MioMiep::Heartbeat.new
      heartbeat.ppq = 96 #fixe for midi file
      heartbeat.bpm = 130

      d = heartbeat.ticks_to_duration(144)

      puts "heartbeat.bpm #{heartbeat.bpm}"
      puts "heartbeat.ppq #{heartbeat.ppq}"
      puts "heartbeat.mpq #{heartbeat.mpq}"
      puts "heartbeat.qls #{heartbeat.qls}"
      puts "heartbeat.tdps #{heartbeat.tdps}"

      puts "duration #{d}"

      


      #@midi.tracks[1].events.inject{|sum,x| sum + x }
    end
    
    it "has absolute tiem values" do
      seq = MIDI::Sequence.new()

      File.open(@file_path) do |file|
        seq.read(file)
        seq.tracks[1].events.each do |event|
          puts "delta_time #{event.delta_time}, time_from_start: #{event.time_from_start}"
          #puts event.inspect
        end
      end

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
