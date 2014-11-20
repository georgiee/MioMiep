require 'spec_helper'

describe "helloworld" do
  it "is true" do
    puts MioMiep::Events::Channel
    expect(true).to be_truthy
  end
  
  it "reads a file" do
    path = File.join(File.dirname(__FILE__), "..", "fixtures", "Mwyoshi.mid")
    midi_file = MioMiep.read(path)
    puts midi_file
  end
  it "has events" do
    puts MioMiep::Events::NOTE_ON
  end
end
