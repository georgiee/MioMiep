module MioMiepHelper
  class << self
    def create_meta_event_data(delta, status, substatus, *params)
      encode_data([delta, status, substatus, params.length] + params, 'c*')
    end

    def create_voice_event_data(delta, status, channel, param1, param2)
      encode_data([delta, (status << 4) | channel, param1, param2], 'cccc')
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
