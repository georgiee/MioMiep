module MioMiep
  #standard midi mapping
  #http://www.electronics.dit.ie/staff/tscarff/Music_technology/midi/midi_note_numbers_for_octaves.htm
  # +---------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
  # | Octave  |  C  | C#  |  D  | D#  |  E  |  F  | F#  |  G  | G#  |  A  | A#  |  B  |
  # +---------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
  # |       0 |   0 |   1 |   2 |   3 |   4 |   5 |   6 |   7 |   8 |   9 |  10 |  11 |
  # |       1 |  12 |  13 |  14 |  15 |  16 |  17 |  18 |  19 |  20 |  21 |  22 |  23 |
  # |       2 |  24 |  25 |  26 |  27 |  28 |  29 |  30 |  31 |  32 |  33 |  34 |  35 |
  # |       3 |  36 |  37 |  38 |  39 |  40 |  41 |  42 |  43 |  44 |  45 |  46 |  47 |
  # |       4 |  48 |  49 |  50 |  51 |  52 |  53 |  54 |  55 |  56 |  57 |  58 |  59 |
  # |       5 |  60 |  61 |  62 |  63 |  64 |  65 |  66 |  67 |  68 |  69 |  70 |  71 |
  # |       6 |  72 |  73 |  74 |  75 |  76 |  77 |  78 |  79 |  80 |  81 |  82 |  83 |
  # |       7 |  84 |  85 |  86 |  87 |  88 |  89 |  90 |  91 |  92 |  93 |  94 |  95 |
  # |       8 |  96 |  97 |  98 |  99 | 100 | 101 | 102 | 103 | 104 | 105 | 106 | 107 |
  # |       9 | 108 | 109 | 110 | 111 | 112 | 113 | 114 | 115 | 116 | 117 | 118 | 119 |
  # |      10 | 120 | 121 | 122 | 123 | 124 | 125 | 126 | 127 |     |     |     |     |
  # +---------+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
  
  class Note
    attr_accessor :note, :velocity
    KEYS = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']

    def initialize(note, velocity)
      @note = note
      @velocity = velocity
    end
    
    def self.octave_shift
      MioMiep.config.middle_c - 5
    end

    def self.note_to_key(note)
      octave = note / 12 + octave_shift;
      name = KEYS[note % 12] + ("%d" % octave;)
    end

    def self.key_to_note(name)
      name = name.to_s
      octave = name.scan(/-?\d{1,2}\z/).first
      octave = octave.to_i
      note = name.split(/-?\d{1,2}\z/).first
      
      index = KEYS.index(note)

      note_nr = ((octave) * 12 ) + index
      note_nr
    end

    #note to freq in Hz
    def self.note_to_freq(note) 
      center_freq = 440 #by convention
      center_tone = 69 #A4 by convention

      center_freq * 2** ((note - center_tone)/12.0);
    end

    def self.freq_to_note
      center_freq = 440 #by convention
      center_tone = 69 #A4 by convention
      #result:=round(12*log2(f/base_a4))+57;
    end
  end
end