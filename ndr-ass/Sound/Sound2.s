    DC.B 0,$F8,$10,$10,$10,0,$a,8,0,0
START:
    LEA STOP,A0
    JSR @SOUND
    JSR SEK
    JSR SEK

    LEA MEER,A0
    JSR @SOUND
    JSR SEK
    JSR SEK

    LEA STOP,A0
    JSR @SOUND
    JSR SEK
    JSR SEK

    LEA LOKO,A0
    JSR @SOUND
    JSR SEK
    JSR SEK

    LEA STOP,A0
    JSR @SOUND
    RTS

SEK:                    * UNTERPROGRAMM 1 SEK
    MOVE #5-1,D3        * 1/10 SEK. AUSZAEHLEN
WARTE:                  * DURCHLAUF IST 20MS
    JSR @SYNC           * UNTERPROG, LIEFERT
    BEQ WARTE           * ALLE 20MS WERT <> 0
    DBRA D3,WARTE       * DAS GANZE 5 MAL
    RTS
 

TAB:
    DC.B $DE,1,$DD,1,$BE,0
    DC.B 0,$F8,$10,$10,$10,0,$a,8,0,0
;
; SOUND:
;     DC.B $EF,$E, $19,$E, $4E,$D, $8D,$C,
;       3823, 3609, 3406, 3213, 3034, 2863, 2703, 2551, 2408, 2273, 2145, 2025,  // Octave 0
;   1911, 1804, 1703, 1607, 1517, 1432, 1351, 1276, 1204, 1136, 1073, 1012,  // Octave 1
;    956,  902,  851,  804,  758,  716,  676,  638,  602,  568,  536,  506,  // Octave 2
;    478,  451,  426,  402,  379,  358,  338,  319,  301,  284,  268,  253,  // Octave 3
;    239,  225,  213,  201,  190,  179,  169,  159,  150,  142,  134,  127,  // Octave 4
;    119,  113,  106,  100,   95,   89,   84,   80,   75,   71,   67,   63,  // Octave 5
;     60,   56,   53,   50,   47,   45,   42,   40,   38,   36,   34,   32,  // Octave 6
;     30,   28,   27,   25,   24,   22,   21,   20,   19,   18,   17,   16,  // Octave 7
;     15,   14,   13,   13,   12,   11,   11,   10,    9,    9,    8,    8   // Octave 8
;
LOKO:
DC.B 0,0,0,0,0,0
DC.B 15,199,16,16,16
DC.B 180,3,12
DC.B 0,0
;
MEER:
DC.B 0,0,0,0,0,0
DC.B 31,199,16,16,16
DC.B 255,60,14,0,0
;
LASER:
DC.B 0,0,0,0,0,0
DC.B 0,3eh,15,0,0
DC.B 0,0,0,0,0
;
STOP:
DC.B 0,0,0,0,0,0
DC.B 0,0,0,0,0,0
DC.B 0,0,0,0
;