require 'spec_helper'

describe 'MidiTrack' do
  before do
    @track = MioMiep::Track.new
  end
  
  it 'has a default name' do
    expect(@track.name).to match(/untitled/)
  end
  
  it 'scans events and finds event' do
    message = MioMiep::Message::Text.new(MioMiep::Message::TRACK_NAME, 'lovely track')
    event = MioMiep::MidiEvent.new(message)
    track = MioMiep::Track.new([event])

    expect(track.name).to match(/lovely track/)
  end
end