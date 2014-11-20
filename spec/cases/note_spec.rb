require 'spec_helper'

describe "note" do
  it "converts from midi note to key" do
    #note = MioMiep::Note.new(21, 4)
    #note.to_s
    
    128.times do |value|
      f = MioMiep::Note.piano_note_to_freq(value)
      key = MioMiep::Note.note_to_key(value)
      puts "#{value}: #{key} -- %d" % f
    end
    key = MioMiep::Note.note_to_key(127)
    expect(key).to be 'Bd'
  end
end
