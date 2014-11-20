require 'spec_helper'

describe "tracks" do
  before do
  end

  it 'has events' do
    track = MioMiep::Track.new
    expect(track).to respond_to(:events)
  end
  
end
