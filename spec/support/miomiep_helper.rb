module MioMiepHelper
  class << self
    def create_meta_event_data(status, substatus, *params)
      encode_data([status, substatus, params.length] + params, 'c*')
    end

    def create_voice_event_data(status, channel, param1, param2)
      encode_data([(status << 4) | channel, param1, param2], 'ccc')
    end

    def encode_data(bytes, encoding)
      reader = MioMiep::ByteReader.new(StringIO.new(bytes.pack(encoding)))    
    end

    def write_to_temp(content)
      path = File.join(File.dirname(__FILE__), "..", "temp")
      File.write(path, content)
    end
  end
  
end
