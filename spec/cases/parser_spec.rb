require 'spec_helper'

describe "parser" do
  it "finds note off" do
    data = MioMiepHelper.create_event_data(33, MioMiep::Event::NOTE_OFF, 15, 13,17)
    event = MioMiep::EventParser.parse(data)

    expect(event).to be_kind_of(MioMiep::Event::NoteOffEvent)
  end

  it "finds note on" do
    data = MioMiepHelper.create_event_data(33, MioMiep::Event::NOTE_ON, 15, 13,17)
    event = MioMiep::EventParser.parse(data)

    expect(event).to be_kind_of(MioMiep::Event::NoteOnEvent)
  end

  it "finds note aftertouch" do
    data = MioMiepHelper.create_event_data(33, MioMiep::Event::NOTE_AFTERTOUCH, 15, 13, 1)
    event = MioMiep::EventParser.parse(data)

    expect(event).to be_kind_of(MioMiep::Event::NoteAfterTouchEvent)
  end

  it "finds controller" do
    data = MioMiepHelper.create_event_data(33, MioMiep::Event::CONTROLLER, 15, 13, 1)
    event = MioMiep::EventParser.parse(data)

    expect(event).to be_kind_of(MioMiep::Event::ControllerEvent)
  end
  
  it "finds program change" do
    data = MioMiepHelper.create_event_data(33, MioMiep::Event::PROGRAM_CHANGE, 15, 13, 1)
    event = MioMiep::EventParser.parse(data)

    expect(event).to be_kind_of(MioMiep::Event::ProgramChangeEvent)
  end

  it "finds channel aftertouch" do
    data = MioMiepHelper.create_event_data(33, MioMiep::Event::CHANNEL_AFTERTOUCH, 15, 13, 1)
    event = MioMiep::EventParser.parse(data)

    expect(event).to be_kind_of(MioMiep::Event::ChannelAfterTouchEvent)
  end

  it "finds pitch bend" do
    data = MioMiepHelper.create_event_data(33, MioMiep::Event::PITCH_BEND, 15, 13, 1)
    event = MioMiep::EventParser.parse(data)

    expect(event).to be_kind_of(MioMiep::Event::PitchBendEvent)
  end
  
  it 'raises an exception for a unknown event' # can't test. running status will be detected.
end
