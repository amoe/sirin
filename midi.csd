<CsoundSynthesizer>
  <CsOptions>
    csound -go dac -M1
  </CsOptions>
  <CsInstruments>
  instr 1
      kcps cpsmidib 32
      kenv madsr 0.1, 0.1, 0.5, 0.1
      a0 oscil ampdbfs(-12), kcps, 1
      a1 = a0 * kenv
      out a1
  endin
  </CsInstruments>
  <CsScore>
    ; Sine wave.
    f 1 0 16384 10 1
    e 4600
  </CsScore>
</CsoundSynthesizer>
