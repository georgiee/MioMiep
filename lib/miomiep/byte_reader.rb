module MioMiep
  class ByteReader
    attr_accessor :io
    
    def initialize(io)
      @io = io
    end

    def get_bytes(n)
      buffer = n.times.map{ readbyte()  }
    end

    def readbyte
      @io.readbyte
    end
    
    def read_chunk
      result = OpenStruct.new
      result.id = read(4)
      result.length = read_int32
      result.data = ByteReader.new(StringIO.new(read(result.length)))
      result
    end

    def read(length)
      @io.read(length)
    end

    def read_int8(signed = false)
      if signed
        value = @io.read(1).unpack('c').first
      else
        value = @io.read(1).unpack('C').first
      end
      value
    end
    
    def read_int16
      @io.read(2).unpack('n').first
    end

    def read_int24
      (read_int8 << 16) | (read_int8 << 8) | read_int8
    end

    def read_int32
      @io.read(4).unpack('N').first
    end

    def read_varint
      result = 0
      
      while true
        value = read_int8
        #puts "variable byte:  #{ByteReader.debug(value, 8)} (%0X)" % value

        unless (value & 0x80).zero?
          #front bit is 1, merge with previous byte
          result += (value & 0x7f);
          result <<= 7;
        else
          if result > 0
            puts 'merging variable bytes'
            puts "current variable:  #{ByteReader.debug(result, 16)}"
            puts "last variable byte:  #{ByteReader.debug(value, 8)}"
            puts "new variable:  #{ByteReader.debug(result + value, 16)}"
          end
          result = result + value

          break
        end
      end

      return result
    end
    
    def eof
      @io.eof
    end

    def self.debug(value, length_in_bits)
      format = "%0#{length_in_bits}b"
      "#{(format % value).scan(/.{1,8}/m)}"
    end
    
    def self.int24_to_bytes(value)
      bytes = []
      bytes << ((value >> 16) & 0xFF)
      bytes << ((value >> 8) & 0xFF)
      bytes << ((value) & 0xFF)

      #bytes.pack('c*')
    end
  end
end