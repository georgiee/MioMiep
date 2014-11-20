require 'spec_helper'

describe "parser" do
  before do
    @parser = MioMiep::Parser.new
  end
  
  describe 'voice events' do
    it "finds note off" do
      data = MioMiepHelper.create_voice_event_data(33, MioMiep::Event::NOTE_OFF, 15, 13,17)
      event = @parser.find_event(data)

      expect(event).to be_kind_of(MioMiep::Event::NoteOffEvent)
    end

    it "finds note on" do
      data = MioMiepHelper.create_voice_event_data(33, MioMiep::Event::NOTE_ON, 15, 13,17)
      event = @parser.find_event(data)

      expect(event).to be_kind_of(MioMiep::Event::NoteOnEvent)
    end

    it "finds note aftertouch" do
      data = MioMiepHelper.create_voice_event_data(33, MioMiep::Event::NOTE_AFTERTOUCH, 15, 13, 1)
      event = @parser.find_event(data)

      expect(event).to be_kind_of(MioMiep::Event::NoteAfterTouchEvent)
    end

    it "finds controller" do
      data = MioMiepHelper.create_voice_event_data(33, MioMiep::Event::CONTROLLER, 15, 13, 1)
      event = @parser.find_event(data)

      expect(event).to be_kind_of(MioMiep::Event::ControllerEvent)
    end
    
    it "finds program change" do
      data = MioMiepHelper.create_voice_event_data(33, MioMiep::Event::PROGRAM_CHANGE, 15, 13, 1)
      event = @parser.find_event(data)

      expect(event).to be_kind_of(MioMiep::Event::ProgramChangeEvent)
    end

    it "finds channel aftertouch" do
      data = MioMiepHelper.create_voice_event_data(33, MioMiep::Event::CHANNEL_AFTERTOUCH, 15, 13, 1)
      event = @parser.find_event(data)

      expect(event).to be_kind_of(MioMiep::Event::ChannelAfterTouchEvent)
    end

    it "finds pitch bend" do
      data = MioMiepHelper.create_voice_event_data(33, MioMiep::Event::PITCH_BEND, 15, 13, 1)
      event = @parser.find_event(data)

      expect(event).to be_kind_of(MioMiep::Event::PitchBendEvent)
    end
    
    it 'raises an exception for a unknown event' # can't test. running status will be detected.
  end

  describe 'meta events' do
    it 'finds sequence number' do
      data = MioMiepHelper.create_meta_event_data(0, MioMiep::Event::META_EVENT, MioMiep::Event::SEQUENCE_NUMBER, 13, 1)
      event = @parser.find_event(data)
      expect(event).to be_kind_of(MioMiep::Event::SequenceNumber)
    end

    it 'finds text event' do
      text = 'hello'.bytes
      data = MioMiepHelper.encode_data([0, MioMiep::Event::META_EVENT, MioMiep::Event::TEXT, text.length] + text, 'c*' )

      event = @parser.find_event(data)
      expect(event).to be_kind_of(MioMiep::Event::Text)
    end
    
    it 'finds copyright notice' do
      text = 'Copyright @ me'.bytes
      data = MioMiepHelper.encode_data([0, MioMiep::Event::META_EVENT, MioMiep::Event::COPYRIGHT_NOTICE, text.length] + text, 'c*' )      

      event = @parser.find_event(data)
      expect(event).to be_kind_of(MioMiep::Event::Copyright)
    end
    
    it 'finds track name' do
      text = 'Some Track Name'.bytes
      data = MioMiepHelper.encode_data([0, MioMiep::Event::META_EVENT, MioMiep::Event::TRACK_NAME, text.length] + text, 'c*' )      

      event = @parser.find_event(data)
      expect(event).to be_kind_of(MioMiep::Event::TrackName)
    end
    
    it 'finds instrument name' do
      text = 'Some Instrument Name'.bytes
      data = MioMiepHelper.encode_data([0, MioMiep::Event::META_EVENT, MioMiep::Event::INSTRUMENT_NAME, text.length] + text, 'c*' )      

      event = @parser.find_event(data)
      expect(event).to be_kind_of(MioMiep::Event::InstrumentName)
    end
    
    it 'finds lyrics' do
      text = 'Lorelei, Lorelei, luda mei'.bytes
      data = MioMiepHelper.encode_data([0, MioMiep::Event::META_EVENT, MioMiep::Event::LYRICS, text.length] + text, 'c*' )      

      event = @parser.find_event(data)
      expect(event).to be_kind_of(MioMiep::Event::Lyrics)
    end

    it 'finds marker' do
      text = 'Lorelei, Lorelei, luda mei'.bytes
      data = MioMiepHelper.encode_data([0, MioMiep::Event::META_EVENT, MioMiep::Event::MARKER, text.length] + text, 'c*' )      

      event = @parser.find_event(data)
      expect(event).to be_kind_of(MioMiep::Event::Marker)
    end

    it 'finds cue point' do
      text = '#xxo -- start engines'.bytes
      data = MioMiepHelper.encode_data([0, MioMiep::Event::META_EVENT, MioMiep::Event::CUE_POINT, text.length] + text, 'c*' )      

      event = @parser.find_event(data)
      expect(event).to be_kind_of(MioMiep::Event::CuePoint)
    end
    
    it 'finds midi channel prefix' do
      data = MioMiepHelper.create_meta_event_data(0, MioMiep::Event::META_EVENT, MioMiep::Event::CHANNEL_PREFIX, 7)
      event = @parser.find_event(data)
      expect(event).to be_kind_of(MioMiep::Event::ChannelPrefix)
    end
    
    it 'finds end of track' do
      data = MioMiepHelper.create_meta_event_data(0, MioMiep::Event::META_EVENT, MioMiep::Event::END_OF_TRACK)
      event = @parser.find_event(data)
      expect(event).to be_kind_of(MioMiep::Event::EndOfTrack)
    end

    it 'finds set tempo' do
      tempo = 8355710
      bytes = MioMiep::ByteReader.int24_to_bytes(tempo)
      data = MioMiepHelper.create_meta_event_data(0, MioMiep::Event::META_EVENT, MioMiep::Event::SET_TEMPO,*bytes)
      
      event = @parser.find_event(data)
      expect(event).to be_kind_of(MioMiep::Event::SetTempo)
    end

    it 'finds SMPTE Offset' do
      data = MioMiepHelper.create_meta_event_data(0, MioMiep::Event::META_EVENT, MioMiep::Event::SMPTE_OFFSET,*[12,59,59,0,99])
      
      event = @parser.find_event(data)
      expect(event).to be_kind_of(MioMiep::Event::SMPTEOffset)
    end

    it 'finds time signature' do
      data = MioMiepHelper.create_meta_event_data(0, MioMiep::Event::META_EVENT, MioMiep::Event::TIME_SIGNATURE,*[0,255,0,255])
      
      event = @parser.find_event(data)
      puts event.inspect
      expect(event).to be_kind_of(MioMiep::Event::TimeSignature)
    end

    it 'finds key signature' do
      data = MioMiepHelper.create_meta_event_data(0, MioMiep::Event::META_EVENT, MioMiep::Event::KEY_SIGNATURE, 13, 1)
      event = @parser.find_event(data)
      expect(event).to be_kind_of(MioMiep::Event::KeySignature)
    end

    it 'finds sequencer specific' do
      specific_content = 'lorem ipsum'.bytes
      data = MioMiepHelper.encode_data([0, MioMiep::Event::META_EVENT, MioMiep::Event::SEQUENCER_SPECIFIC, specific_content.length] + specific_content, 'c*' )
      event = @parser.find_event(data)
      expect(event).to be_kind_of(MioMiep::Event::SequencerSpecific)
    end
  end

  describe 'system exclusive events' do
    it 'finds normal SysEx' do
      content = 'some content'.bytes + [MioMiep::Event::END_OF_SYS_EX]
      data = MioMiepHelper.encode_data([0, MioMiep::Event::SYS_EX, content.length] + content, 'c*' )

      event = @parser.find_event(data)
      expect(event).to be_kind_of(MioMiep::Event::SysEx)
    end

    it 'finds normal AuthorizationSysEx' do
      content = 'some content'.bytes
      data = MioMiepHelper.encode_data([0, MioMiep::Event::END_OF_SYS_EX, content.length] + content, 'c*' )

      event = @parser.find_event(data)
      expect(event).to be_kind_of(MioMiep::Event::AuthorizationSysEx)
    end

    it 'handles divided SysEx' do
      #first message with no eof flag
      content_1 = 'some content'.bytes
      data_1 = MioMiepHelper.encode_data([0, MioMiep::Event::SYS_EX, content_1.length] + content_1, 'c*' )
      event = @parser.find_event(data_1)
      expect(event).to be_kind_of(MioMiep::Event::DividedSysEx)
      
      #continue
      content_2 = 'more content'.bytes
      data_2 = MioMiepHelper.encode_data([0, MioMiep::Event::END_OF_SYS_EX, content_2.length] + content_2, 'c*' )
      event = @parser.find_event(data_2)
      expect(event).to be_kind_of(MioMiep::Event::DividedSysEx)

      #complete
      content_3 = 'end content'.bytes + [MioMiep::Event::END_OF_SYS_EX]
      data_3 = MioMiepHelper.encode_data([0, MioMiep::Event::END_OF_SYS_EX, content_3.length] + content_3, 'c*' )
      event = @parser.find_event(data_3)
      expect(event).to be_kind_of(MioMiep::Event::DividedSysEx)
    end
  end
end
