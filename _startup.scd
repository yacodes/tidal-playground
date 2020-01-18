// ServerOptions.outDevices.do {|d| d.postln}
// ServerOptions.inDevices.do {|d| d.postln}

Server.default.record;
s.stopRecording;

Server.default.record(numChannels: 4);

thisProcess.platform.recordingsDir


"./synths/drums/hh/soshats.scd".load;

"./synths/drums/snare/sossnare.scd".load;


s.meter
(
  s.options.inDevice = "Scarlett 2i4 USB";
  s.options.outDevice = "Scarlett 2i4 USB";
  // s.options.inDevice = "Built-in Microph";
  // s.options.outDevice = "Built-in Output";
  s.options.sampleRate = 44100;
  s.options.blockSize = 512;
  s.options.hardwareBufferSize = 512;
  s.options.numBuffers = 1024 * 512;
  s.options.memSize = 8192 * 16;
  s.options.maxNodes = 1024 * 32;
  s.options.numOutputBusChannels = 8;
  s.options.numInputBusChannels = 2;
  // s.options.numInputBusChannels = 4;

  s.waitForBoot {
    // Samples
    ~dirt = SuperDirt(2, s);
    ~dirt.loadSoundFiles(PathName.new("./samples").fullPath ++ "/*");

    // Drums
    "./synths/drums/kick/ek.scd".load;
    "./synths/drums/kick/gabberkick.scd".load;
    // "./synths/drums/kick/soskick.scd".load;
    "./synths/drums/hh/soshats.scd".load;
    // "./synths/drums/snare/sossnare.scd".load;
    "./synths/drums/cymbal/cymbal808.scd".load;
    "./synths/drums/bells/sosbell.scd".load;
    "./synths/drums/perc/kalimba.scd".load;
    "./synths/drums/kick/k1.scd".load;
    "./synths/drums/kick/k2.scd".load;
    "./synths/drums/kick/k3.scd".load;
    "./synths/drums/kick/kick808.scd".load;
    "./synths/drums/kick/kickOto309.scd".load;
    "./synths/drums/kick/soskick.scd".load;

    // Bass
    "./synths/bass/moogbass.scd".load;
    "./synths/bass/pluckbass.scd".load;
    "./synths/bass/ikedaBass.scd".load;
    "./synths/bass/bassWarsaw.scd".load;
    "./synths/bass/acidOto3091.scd".load;
    "./synths/bass/acidOto3092.scd".load;

    // Leads
    "./synths/leads/cs80.scd".load;
    "./synths/leads/fm7.scd".load;

    // MIDI Initializations
    // MIDIClient.init;
    // ~iacMIDI = MIDIOut.newByName("IAC Driver", "Tidal Cycles");
    // ~dirt.sounkLibrary.addMIDI(\podolski, ~iacMIDI);
    // ~iacMIDI.latency = 0.45;

    // ~microfreakMIDIOut = MIDIOut.newByName("Arturia MicroFreak", "");
    // ~dirt.soundLibrary.addMIDI(\microfreak, ~microfreakMIDIOut);
    // ~microfreakMIDIOut.latency = 0.45;

    s.sync;
    ~dirt.start(57121, 3.collect({|i| i})); // 4 hardware channels
    ~dirt.start(57121, [0, 0, 1, 1, 2, 2, 3, 3]); // 4 hardware channels
    // ~dirt.start(57121, ); // 4 hardware channels
    ~dirt.start(57121, 3.collect{|i| 4.collect{|j| i}}.flatten);

    // ~dirt.start(57120, 12.collect({|i| 2 * i})); // 12 hardware channels
    // ~dirt.start(57120, 12.collect({0})); // 12 virtual channels
  };

  s.latency = 0.3;
);

3.collect{|i| 4.collect{|j| (i*4)+j}}

32.collect{|i| (i * 2) + 1}

4
4.collect{|i| 16.collect{|j| i}}.flatten

// (
//   SynthDef.new(\basssynth9, {|out, pan, sustain = 2, n = 30|
//     var env = EnvGen.kr(Env.perc(0.1, sustain, 1, -8), doneAction: Done.freeSelf);
//     var saw = Klang.ar(`[7.collect {|index|
//       ((2 * index - 1 + (index + 1) / 4 * 2) * n.midicps) + n.midicps;
//     }, nil, nil], 1, 0) * 0.25;
//     var filter = Resonz.ar(
//       in: saw,
//       freq: EnvGen.kr(Env.new([n.midicps * 12, n.midicps, 20], [0, sustain], -4)),
//       // decaytime: 0.5,
//       // mul: 1 / 12
//     );

//     OffsetOut.ar(out, DirtPan.ar(filter, ~dirt.numChannels, pan, env));
//   }).add;
// )

// Synth.new(\rock, [\n, 24])

// (
//   var n = 24;
//   {
//     8.do {
//       Synth.new(\rock, [\n, n, \sustain, 4]);
//       n = n + 1;
//       0.25.wait;
//     }
//   }.fork
// )

// (
// 4.collect {|index|
//   ((2 * index - 1 + (index + 1) / 4 * 2) * 30.midicps) + 30.midicps;
// };

// )

// play({ Klang.ar(`[ [800, 1000, 1200], [0.3, 0.3, 0.3], [pi, pi, pi]], 1, 0) * 0.4});

// s.boot


// 20.midicps

// Env.perc(0.02, 2, 50, -8).plot

// Env.new([50.midicps * 10, 50.midicps, 20], [0, 2], -4).plot

// FreqScope.new

// Env.perc(0.02, 2, 1, -8).plot

// (
//   {
//     inf.do {
//       Synth.new(\rock);
//       0.25.wait;
//     }
//   }.fork
// )

// Platform.systemExtensionDir; // system extensions
// Platform.userExtensionDir; // user extensions

// Custom synth example
// (
//   SynthDef(\tutorial1, {|out, sustain=1, pan, accelerate, n |
//     var env = EnvGen.ar(Env.perc(0.001, 0.999, 1, -4), timeScale: sustain, doneAction: 2);
//     var sound = SinOsc.ar(n * Line.kr(1, 1 + accelerate, sustain));
//     OffsetOut.ar(out, DirtPan.ar(sound, ~dirt.numChannels, pan, env));
//   }).add
// )

// @TODO Adopt for SuperDirt
// (
//   SynthDef("kik", {|basefreq = 50, ratio = 7, sweeptime = 0.05, preamp = 1, amp = 1, decay1 = 0.3, decay1L = 0.8, decay2 = 0.15, out|
//     var fcurve = EnvGen.kr(Env([0.001, basefreq * ratio, basefreq], [0.001, sweeptime], \exp)),
//         env = EnvGen.kr(Env([0.001, 1, decay1L, 0], [0.001, decay1, decay2], -4), doneAction: 2),
//         sig = SinOsc.ar(fcurve, 0.5pi, preamp).distort * env * amp;
//     Out.ar(out, sig ! 2);
//   }).add;
// )

// Synth(\kik, [\basefreq, 55, \decay1, 0.8, \decay1L, 0.75, \decay2, 0.5, \sweeptime, 0.1, \ratio, 2])

// (
//   SynthDef(\tutorial1, {|out, sustain=1, pan, accelerate, n |
//     var env = EnvGen.ar(Env.perc(0.001, 0.999, 1, -4), timeScale: sustain, doneAction: 2);
//     var sound = SinOsc.ar(n * Line.kr(1, 1 + accelerate, sustain));
//     OffsetOut.ar(out, DirtPan.ar(sound, ~dirt.numChannels, pan, env));
//   }).add
// )

// Beautifull FreqScope
// (
// w = Window("My Analyzer", Rect(0, 20, 300, 150)); // width should be 511
// f = FreqScopeView(w, w.view.bounds);
// f.active_(true);
// f.freqMode_(1);

// w.onClose_({ f.kill }); // you must have this
// w.front;
// )
// f.active_(true);

// Stethoscope inserted inside the window
// (
// w = Window.new("my own scope", Rect(20, 20, 400, 500));
// w.view.decorator = FlowLayout(w.view.bounds);
// c = Stethoscope.new(s, view:w.view);
// w.onClose = { c.free }; // don't forget this
// w.front;
// )


// SynthDef.new(\basssynth9, {|out, pan, sustain = 2, n = 30|
//   var env = EnvGen.kr(Env.perc(0.1, sustain, 1, -8), doneAction: Done.freeSelf);
//   var saw = Klang.ar(`[7.collect {|index|
//     ((2 * index - 1 + (index + 1) / 4 * 2) * n.midicps) + n.midicps;
//   }, nil, nil], 1, 0) * 0.25;
//   var filter = Resonz.ar(
//     in: saw,
//     freq: EnvGen.kr(Env.new([n.midicps * 12, n.midicps, 20], [0, sustain], -4)),
//     // decaytime: 0.5,
//     // mul: 1 / 12
//   );

//   OffsetOut.ar(out, DirtPan.ar(filter, ~dirt.numChannels, pan, env));
// }).add;

// SynthDef.new(\kick9, {|out, pan, sustain = 2, n = 50|
//   var env = EnvGen.kr(Env.perc(0.02, sustain, 1, -8), doneAction: Done.freeSelf);
//   var noise = LPF.ar(WhiteNoise.ar(), Env.new([n.midicps * 10, n.midicps, 20], [0, sustain], -2).kr, mul: 5);
//   var osc = Resonz.ar(SinOsc.ar(Env.new([n.midicps * 10, n.midicps, 20], [0, sustain], -1).kr), n.midicps, 0.9, mul: 1);
//   var sig = Mix.new([noise, osc]);
//   OffsetOut.ar(out, DirtPan.ar(sig, ~dirt.numChannels, pan, env));
// }).add;