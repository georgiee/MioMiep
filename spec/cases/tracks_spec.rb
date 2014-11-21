require 'spec_helper'
require 'midilib'

describe "tracks" do
  before do
    #@path = File.join(File.dirname(__FILE__), '..','fixtures','sounds','Mwyoshi.mid')
    #@path = File.join(File.dirname(__FILE__), '..','fixtures','sounds','SMWYoshi.mid')
    #problems time
    #@path = File.join(File.dirname(__FILE__), '..','fixtures','sounds','YI_Maps.mid')
    
    #problems nil event
    #@path = File.join(File.dirname(__FILE__), '..','fixtures','sounds','YITitle.mid')

    #problems nil event
    @path = File.join(File.dirname(__FILE__), '..','fixtures','sounds','YISLE20S.mid')
    
    #problems nil event
    #@path = File.join(File.dirname(__FILE__), '..','fixtures','sounds','yi-stg1.mid')
    
    #problems here:! (nil event)
    #@path = File.join(File.dirname(__FILE__), '..','fixtures','sounds','smw2-2.mid')
    
    #@path = File.join(File.dirname(__FILE__), '..','fixtures','sounds', 'SMW-Yoshi_Island.mid')
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

  it 'total duration (with set tempo' do
    puts @midi.tracks

    puts 'format %s' % @midi.format
    puts "total_duration-- #{@midi.total_duration}"
    #seq = open_midi_with_midilib
    #seq.tracks[1].events.each {|t| puts t.time_from_start}

    puts @midi.heartbeat.inspect
    puts @midi.heartbeat.bpm
  end

  it 'has events' do
    track = MioMiep::Track.new
    expect(track).to respond_to(:events)
  end

  it 'agregate events delta times' do
    puts @track.to_s
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
