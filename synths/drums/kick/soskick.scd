// DrumSynths SC Example - SOS Drums by Renick Bell, renick@gmail.com
// recipes from Gordon Reid in his Sound on Sound articles
// SOSkick — http:www.soundonsound.com/sos/jan02/articles/synthsecrets0102.asp
// increase modFreq and modIndex for interesting electronic percussion
SynthDef(\soskick, {
  arg out, pan, freq = 50, modFreq = 5, modIndex = 5, sustain = 1, beaterNoiseLevel = 0.025;

  var pitchContour, drumOsc, drumLpf, drumEnv, env;
  var beaterSource, beaterHpf, beaterLpf, lpfCutoffContour, beaterEnv;
  var kickMix, snd;

  pitchContour = Line.kr(freq * 2, freq, 0.02);
  drumOsc = PMOsc.ar(pitchContour, modFreq, modIndex / 1.3, mul: 1, add: 0);
  drumLpf = LPF.ar(in: drumOsc, freq: 1000, mul: 1, add: 0);
  env = EnvGen.kr(Env.perc(0.005, sustain), 1.0, doneAction: Done.freeSelf);
  drumEnv = drumLpf * env;

  beaterSource = WhiteNoise.ar(beaterNoiseLevel);
  beaterHpf = HPF.ar(in: beaterSource, freq: 500, mul: 1, add: 0);

  lpfCutoffContour = Line.kr(6000, 500, 0.03);

  beaterLpf = LPF.ar(in: beaterHpf, freq: lpfCutoffContour, mul: 1, add: 0);
  beaterEnv = beaterLpf * EnvGen.kr(Env.perc, 1.0);

  kickMix = Mix.new([drumEnv, beaterEnv]) * 2;

  OffsetOut.ar(out, DirtPan.ar(kickMix, ~dirt.numChannels, pan, env));
},
metadata: (
  credit: "Renick Bell",
  category: \drums,
  tags: [\pitched, \bass, \sos]
)).add;