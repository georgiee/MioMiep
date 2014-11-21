require 'spec_helper'

describe "note" do
  def output_all_combinations
    128.times do |value|
      f = MioMiep::Note.note_to_freq(value)
      key = MioMiep::Note.note_to_key(value)
      puts "#{value}: #{key} -- %d" % f
    end
  end

  it "converts from midi note to key" do
    key = MioMiep::Note.note_to_key(69)
    expect(key).to eq 'A4'
  end
  
  it 'converts from key to midi note' do
    note = MioMiep::Note.key_to_note('F#7')
    expect(note).to be 90
  end

end
