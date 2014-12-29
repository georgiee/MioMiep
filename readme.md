# Miomiep MIDI Reader
A midi file decoder in ruby. This is just for my own practice in ruby and to understand the midi file format. 

## Main resources

+ MIDI Specs
http://www.sonicspot.com/guide/midifiles.html

+ MIDI in JS
https://github.com/gasman/jasmid

+ MIDI files
I found some classical and SNES MIDI files on the web during my research. Source unknown.

## Usage
Run the tests. There is no CLI avaialble.

Sample output:

    MidiEvent (0.00s, 0p) | INSTRUMENT_NAME -- text: Acoustic Grand Piano
    MidiEvent (0.00s, 0p) | TRACK_NAME -- text: My New Track
    MidiEvent (0.00s, 0p) | CONTROLLER
    MidiEvent (0.00s, 0p) | PROGRAM_CHANGE -- program number: 1
    MidiEvent (0.00s, 0p) | NOTE ON -- note: 64 (E3), velocity: 127
    MidiEvent (0.50s, 480p) | NOTE OFF -- note: 64 (E3), velocity: 127
    MidiEvent (0.50s, 480p) | NOTE ON -- note: 66 (F#3), velocity: 127
    MidiEvent (1.00s, 960p) | NOTE OFF -- note: 66 (F#3), velocity: 127
    MidiEvent (1.00s, 960p) | NOTE ON -- note: 68 (G#3), velocity: 127
    MidiEvent (1.50s, 1440p) | NOTE OFF -- note: 68 (G#3), velocity: 127
    MidiEvent (1.50s, 1440p) | NOTE ON -- note: 69 (A3), velocity: 127
    MidiEvent (2.00s, 1920p) | NOTE OFF -- note: 69 (A3), velocity: 127
    MidiEvent (2.00s, 1920p) | NOTE ON -- note: 71 (B3), velocity: 127
    MidiEvent (2.50s, 2400p) | NOTE OFF -- note: 71 (B3), velocity: 127
    MidiEvent (2.50s, 2400p) | NOTE ON -- note: 73 (C#4), velocity: 127
    MidiEvent (3.00s, 2880p) | NOTE OFF -- note: 73 (C#4), velocity: 127
    MidiEvent (3.00s, 2880p) | NOTE ON -- note: 75 (D#4), velocity: 127
    MidiEvent (3.50s, 3360p) | NOTE OFF -- note: 75 (D#4), velocity: 127
    MidiEvent (3.50s, 3360p) | NOTE ON -- note: 76 (E4), velocity: 127
    MidiEvent (4.00s, 3840p) | NOTE OFF -- note: 76 (E4), velocity: 127
    MidiEvent (4.00s, 3840p) | END_OF_TRACK