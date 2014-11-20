module MioMiep
  
  class MidiFile
    attr_accessor :tracks
    
    def initialize(file)
      @reader = ByteReader.new(file)
    end

    def read
      header = MidiHeader.parse(@reader.read_chunk)
      header.track_count.times{
        read_track(@reader.read_chunk)
      }
    end
    
    def read_track(track_chunk)
      puts "\n#################### read track"
      puts "#{@reader.io.pos - track_chunk.length - 4 - 4}"

      if (track_chunk.id != 'MTrk')
        raise "Unexpected chunk - expected MTrk, got "+ track_chunk.id;
      end
      
      track_data = track_chunk.data
      
      while (!track_data.eof)
        EventParser.parse(track_data)
      end
    end

    def self.parse(file)
      midi = new(file)
      midi.read

      midi
    end
  end

  class MidiHeader
    def self.parse(chunk)
      if (chunk.id != 'MThd' || chunk.length != 6)
        raise "Bad .mid file - header not found";
      end

      header = new
      data = chunk.data
      
      header.format = data.read_int16
      header.track_count = data.read_int16
      header.time_division = data.read_int16

      if header.time_division & 0x8000
        #raise 'Expressing time division in SMTPE frames is not supported yet'
      end

      header
    end

    attr_accessor :format, :track_count, :time_division
  end


  class EventParser
    def self.parse(data)
      puts "\n##### read event"

      delta_time = data.read_varint
      event_type = data.read_int8
      
      puts "delta time: #{delta_time}"      
      puts "event_type: %0X" % event_type 
      #puts "event_type: #{ByteReader.debug(event_type, 8)}" 
      
      if((event_type & 0xf0) == 0xf0) #front four bits are 1 (11110000)
        #System Common Category messages
        case event_type
          when 0xff then
            event_sub_type = data.read_int8
            length = data.read_varint
            puts "event_sub_type #{ '0x%0X' % event_sub_type}"
            case event_sub_type
              when 0x59 then #key signature
                raise "length must be 2" unless length == 2
                key = data.read_int8
                scale = data.read_int8(true)
              
              when 0x58 then #'time signature'
                raise "length must be 4" unless length == 4
                #Numer  Denom Metro 32nds
                data.read_int8
                data.read_int8
                data.read_int8
                data.read_int8
              when 0x7F #'Sequencer Specific'
                data = data.read(length)
                puts data.inspect
              when 0x51 #'Sequencer Specific'
                raise "length must be 3" unless length == 3
                
                microsecondsPerBeat = data.read_int24
                #puts "microsecondsPerBeat #{microsecondsPerBeat}"
              when 0x2F #End Of Track
                raise "length must be 3" unless length == 0
                puts 'End Of Track'
                
            end
          when 0xf0 then # 'sysex ------event'
          when 0xf7 then # 'divided sysex ------event'
        end
      else
        #well. this must be a channel event
        # our front four bits are between 1000 and 1110 (0x80  - 0xE0)
        # including the channel values between 0 - 15
        # A Voice Category is between (0x80 and 0xEF) (0x8 with channel 0 and 0xE with channel 15)
        # 
        # So if the most significant bit is 0, we have a running status (as it's no System Common Category or Voice category)
        # this is because param1 & param2 are restricte to values of 0 - 127 (0x7F)
        # so we can assume any incoming event type with the first bit missing must be a parameter
        # and therefore be part of a running status.
        
        puts 'found midi channel event'

        event_type_byte = event_type
        
        #Running status is only implemented for Voice Category messages (ie, Status is 0x80 to 0xEF).
        #so check f  
        
        if (event_type_byte & 0x80).zero?
          #running status
          param1 = event_type_byte
          param2 = data.read_int8
          event_type_byte = @last_event_type_byte
        else
          param1 = data.read_int8
          param2 = data.read_int8

          @last_event_type_byte = event_type_byte
        end
        
        event_type = event_type_byte >> 4
        channel = event_type_byte&0x0f #0 - 15
        
        case event_type 
          
          when Event::NOTE_OFF
            return Event::NoteOffEvent.new(channel, delta_time, param1, param2)

          when Event::NOTE_ON
            return Event::NoteOnEvent.new(channel, delta_time, param1, param2)

          when Event::NOTE_AFTERTOUCH
            return Event::NoteAfterTouchEvent.new(channel, delta_time, param1, param2)

          when Event::CONTROLLER
            return Event::ControllerEvent.new(channel, delta_time, param1, param2)
          
          when Event::PROGRAM_CHANGE
            return Event::ProgramChangeEvent.new(channel, delta_time, param1)
          
          when Event::CHANNEL_AFTERTOUCH
            return Event::ChannelAfterTouchEvent.new(channel, delta_time, param1)
          
          when Event::PITCH_BEND
            return Event::PitchBendEvent.new(channel, delta_time, param2 << 7 | param1) #p1=lsb, p2=msb
          
          else
            raise 'no matching event found'
        end
      end
    end
  end
end