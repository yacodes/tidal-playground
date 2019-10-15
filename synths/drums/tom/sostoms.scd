// Retrieved from http:sccode.org/1-5aD
// DrumSynths SC Example - SOS Drums by Renick Bell, renick_at_gmail.com
// recipes from Gordon Reid in his Sound on Sound articles
// SOStom — http:www.soundonsound.com/sos/Mar02/articles/synthsecrets0302.asp
// Modified by Bruno Ruviaro and Josh Mitchell 8/19.
SynthDef(\sostoms, {
  arg out = 0, pan = 0, sustain = 1, drumModeAmp = 0.5, freq = 250, timbreIndex = 0.77, amp = 1, att = 0.005, curve = -6;

  var drumMode, drumModeEnv, stick, stickEnv, snd;

  drumModeEnv = Env.perc(attackTime: att, releaseTime: sustain / 1.25, level: 0.5, curve: curve).kr(doneAction: Done.freeSelf);

  drumMode = PMOsc.ar(carfreq: Saw.ar(freq: freq * 0.9), modfreq: freq * 0.85, pmindex: timbreIndex, mul: drumModeEnv * 10);
  drumMode = drumMode + SinOsc.ar(freq: [freq, freq * 0.8], mul: drumModeEnv);
  drumMode = Mix.ar(drumMode) * drumModeAmp;

  stick = Crackle.ar(chaosParam: 2.01);
  stickEnv = Env.perc(attackTime: att, releaseTime: sustain / 5, level: 3, curve: curve).kr;

  snd = Mix.ar(drumMode + stickEnv) * amp;
  snd = LeakDC.ar(snd);

  OffsetOut.ar(out, DirtPan.ar(snd, ~dirt.numChannels, pan, drumModeEnv));
},
metadata: (
  credit: "Renick Bell",
  category: \drums,
  tags: [\pitched, \tom, \sos]
)).add;