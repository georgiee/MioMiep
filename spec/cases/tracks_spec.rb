require 'spec_helper'
require 'midilib'

describe "tracks" do
  before do
    #@path = File.join(File.dirname(__FILE__), '..','fixtures','test.mid')
    @path = File.join(File.dirname(__FILE__), '..','fixtures','sounds', 'SMW-Yoshi_Island.mid')

    @midi = MioMiep.read(@path)
    @track  = @midi.tracks[1]
  end

  def open_midi_with_midilib
    seq = MIDI::Sequence.new()

    File.open(@path) do |file|
      seq.read(file)
    end

    seq
  end

  it 'has events' do
    track = MioMiep::Track.new
    expect(track).to respond_to(:events)
  end

  it 'agregate events delta times' do
    puts @track.to_s

    #seq = open_midi_with_midilib
    #seq.tracks[1].events.each do |event|
    #  puts "delta_time #{event.inspect}"
    #end
  end

  it 'ticks in seconds' do
    heartbeat = MioMiep::Heartbeat.new
    heartbeat.ppq = 480 #fixe for midi file
    heartbeat.bpm = 120

    d = heartbeat.ticks_to_duration(480/2)

    puts "heartbeat.bpm #{heartbeat.bpm}"
    puts "heartbeat.ppq #{heartbeat.ppq}"
    puts "heartbeat.mpq #{heartbeat.mpq}"
    puts "heartbeat.qls #{heartbeat.qls}"
    puts "heartbeat.tdps #{heartbeat.tdps}"

    puts "duration #{d}"
    #@midi.tracks[1].events.inject{|sum,x| sum + x }
  end
end
