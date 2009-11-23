gitmp ftgen 1, 0, 16384, 10, 1

; Demo instrument from Csound manual.
instr 1
    kamp = 10000
    kcps = 440
    ifn = 1

    a1 oscil kamp, kcps, ifn
    out a1
endin
