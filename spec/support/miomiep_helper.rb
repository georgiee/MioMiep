module MioMiepHelper
  def self.create_event_data(delta, status, channel, param1, param2)
    encode_data([delta, (status << 4) | channel, param1, param2], 'cccc')
  end

  def self.encode_data(bytes, encoding)
    reader = MioMiep::ByteReader.new(StringIO.new(bytes.pack(encoding)))
    
  end
end
