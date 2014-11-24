require 'spec_helper'

describe 'decoder' do
  before do
    @decoder = MioMiep::Decoder.new
  end

  it 'decodes a file' do
    @file_path = File.join(File.dirname(__FILE__), '..','fixtures', 'test.mid')
    @midi = MioMiep.read(@file_path)
    puts @midi.tracks[1]

    puts "----end\n\n"
    File.open(@file_path) do |file|
      decoder = MioMiep::Decoder.new
      decoder.read(file)
    end
  end

  describe 'voice messages' do
    it "finds note off" do
      data = MioMiepHelper.create_voice_event_data(MioMiep::Message::NOTE_OFF, 15, 13,17)
      
      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::Voice)
    end

    it "finds note on" do
      data = MioMiepHelper.create_voice_event_data(MioMiep::Message::NOTE_ON, 15, 13,17)
      
      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::Voice)
    end

    it "finds note aftertouch" do
      data = MioMiepHelper.create_voice_event_data(MioMiep::Message::NOTE_AFTERTOUCH, 15, 13, 1)
      
      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::Voice)
    end

    it "finds controller" do
      data = MioMiepHelper.create_voice_event_data(MioMiep::Message::CONTROLLER, 15, 13, 1)
      
      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::Controller)
    end
    
    it "finds program change" do
      data = MioMiepHelper.create_voice_event_data( MioMiep::Message::PROGRAM_CHANGE, 15, 13, 1)
      
      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::ProgramChange)
    end

    it "finds channel aftertouch" do
      data = MioMiepHelper.create_voice_event_data( MioMiep::Message::CHANNEL_AFTERTOUCH, 15, 13, 1)
      
      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::ChannelAftertouch)
    end

    it "finds pitch bend" do
      data = MioMiepHelper.create_voice_event_data( MioMiep::Message::PITCH_BEND, 15, 13, 1)
      
      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::PitchBend)
    end
  end

  describe 'meta messages' do
    it 'finds a sequence number' do
      data = MioMiepHelper.create_meta_event_data(MioMiep::Message::META_EVENT, MioMiep::Message::SEQUENCE_NUMBER, 13, 1)
      
      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::SequenceNumber)
    end

    it 'finds a text event' do
      text = 'hello'.bytes
      data = MioMiepHelper.encode_data([MioMiep::Message::META_EVENT, MioMiep::Message::TEXT, text.length] + text, 'c*' )
      
      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::Text)
    end

    it 'finds a copyright notice' do
      text = 'Copyright @ me'.bytes
      data = MioMiepHelper.encode_data([MioMiep::Message::META_EVENT, MioMiep::Message::COPYRIGHT_NOTICE, text.length] + text, 'c*' )      

      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::Text)
    end
    
    it 'finds a track name' do
      text = 'Some Track Name'.bytes
      data = MioMiepHelper.encode_data([MioMiep::Message::META_EVENT, MioMiep::Message::TRACK_NAME, text.length] + text, 'c*' )      

      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::Text)
    end
    
    it 'finds a instrument name' do
      text = 'Some Instrument Name'.bytes
      data = MioMiepHelper.encode_data([MioMiep::Message::META_EVENT, MioMiep::Message::INSTRUMENT_NAME, text.length] + text, 'c*' )      

      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::Text)
    end
    
    it 'finds lyrics' do
      text = 'Lorelei, Lorelei, luda mei'.bytes
      data = MioMiepHelper.encode_data([MioMiep::Message::META_EVENT, MioMiep::Message::LYRICS, text.length] + text, 'c*' )      
      
      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::Text)
    end

    it 'finds a marker' do
      text = 'Lorelei, Lorelei, luda mei'.bytes
      data = MioMiepHelper.encode_data([MioMiep::Event::META_EVENT, MioMiep::Message::MARKER, text.length] + text, 'c*' )      

      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::Text)
    end

    it 'finds a cue point' do
      text = '#xxo -- start engines'.bytes
      data = MioMiepHelper.encode_data([MioMiep::Event::META_EVENT, MioMiep::Message::CUE_POINT, text.length] + text, 'c*' )      

      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::Text)
    end

    it 'finds a program name' do
      text = 'some program name'.bytes
      data = MioMiepHelper.encode_data([MioMiep::Event::META_EVENT, MioMiep::Message::PROGRAM_NAME, text.length] + text, 'c*' )      

      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::Text)
    end

    it 'finds a device name' do
      text = 'some device name'.bytes
      data = MioMiepHelper.encode_data([MioMiep::Event::META_EVENT, MioMiep::Message::DEVICE_NAME, text.length] + text, 'c*' )      

      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::Text)
    end

    it 'finds midi channel prefix' do
      data = MioMiepHelper.create_meta_event_data(MioMiep::Message::META_EVENT, MioMiep::Message::CHANNEL_PREFIX, 7)
      
      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::ChannelPrefix)
    end
    
    it 'finds end of track' do
      data = MioMiepHelper.create_meta_event_data(MioMiep::Message::META_EVENT, MioMiep::Message::END_OF_TRACK)

      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::EndOfTrack)
    end

    it 'finds set tempo' do
      tempo = 8355710
      bytes = MioMiep::ByteReader.int24_to_bytes(tempo)
      data = MioMiepHelper.create_meta_event_data(MioMiep::Message::META_EVENT, MioMiep::Message::SET_TEMPO,*bytes)
      
      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::SetTempo)
    end

    it 'finds SMPTE Offset' do
      data = MioMiepHelper.create_meta_event_data(MioMiep::Message::META_EVENT, MioMiep::Message::SMPTE_OFFSET,*[12,59,59,0,99])
      
      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::SMPTEOffset)
    end

    it 'finds a time signature' do
      data = MioMiepHelper.create_meta_event_data(MioMiep::Message::META_EVENT, MioMiep::Message::TIME_SIGNATURE,*[0,255,0,255])
      
      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::TimeSignature)
    end

    it 'finds a key signature' do
      data = MioMiepHelper.create_meta_event_data(MioMiep::Message::META_EVENT, MioMiep::Message::KEY_SIGNATURE, 13, 1)
      
      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::KeySignature)
    end

    it 'finds a sequencer specific message' do
      specific_content = 'lorem ipsum'.bytes
      data = MioMiepHelper.encode_data([MioMiep::Message::META_EVENT, MioMiep::Message::SEQUENCER_SPECIFIC, specific_content.length] + specific_content, 'c*' )
      
      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::SequencerSpecific)
    end
  end

  describe 'system exclusive events' do
    it 'find normal SysEx' do
      content = 'some content'.bytes + [MioMiep::Message::END_OF_SYS_EX]
      data = MioMiepHelper.encode_data([MioMiep::Message::SYS_EX, content.length] + content, 'c*' )

      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::SystemExclusive)
    end

    it 'finds normal AuthorizationSysEx' do
      content = 'some content'.bytes
      data = MioMiepHelper.encode_data([MioMiep::Message::END_OF_SYS_EX, content.length] + content, 'c*' )

      message = @decoder.read_message(data)
      expect(message).to be_kind_of(MioMiep::Message::AuthorizationSysEx)
    end

    it 'handles divided SysEx' do
      #first message with no eof flag
      content = 'some content'.bytes
      data = MioMiepHelper.encode_data([MioMiep::Event::SYS_EX, content.length] + content, 'c*' )
      
      message = @decoder.read_message(data)
      puts message.incomplete?
      expect(message.incomplete?).to be(true)

      #continue
      content = 'more content'.bytes
      data = MioMiepHelper.encode_data([MioMiep::Event::END_OF_SYS_EX, content.length] + content, 'c*' )
      message = @decoder.read_message(data)
      expect(message.incomplete?).to be(true)

      #complete
      content = 'end content'.bytes + [MioMiep::Event::END_OF_SYS_EX]
      data = MioMiepHelper.encode_data([MioMiep::Event::END_OF_SYS_EX, content.length] + content, 'c*' )
      message = @decoder.read_message(data)
      
      expect(message.incomplete?).to be(false)
    end
  end
end