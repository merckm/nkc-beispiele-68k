START:
 LEA BUFFER,A0
 JSR @SETUHR
READUHR:
 LEA BUFFER2,A0
 JSR @GETUHR
 LEA AUSBUF,A0
 MOVE.B BUFFER2+2,D0
 JSR @PRINT2X
 MOVE.B '.',(A0)+
 MOVE.B BUFFER2+3,D0
 JSR @PRINT2X
 MOVE.B '.',(A0)+
 MOVE.B BUFFER2+4,D0
 JSR @PRINT2X
 MOVE.B ' ',(A0)+
 MOVE.B BUFFER2,D0
 JSR @PRINT2X
 MOVE.B ':',(A0)+
 MOVE.B BUFFER2+1,D0
 JSR @PRINT2X
 MOVE.B ':',(A0)+
 MOVE.B BUFFER2+6,D0
 JSR @PRINT2X
 MOVE.B ' ',(A0)+
 LEA AUSBUF,A0
 MOVE #$33,D0
 MOVE #10,D1
 MOVE #120,D2
 JSR @WRITE
 JSR @CSTS
 BEQ READUHR
 RTS

BUFFER:
 DC.B $18,$15,$23,$09,$84;$01,$00
BUFFER2:
 DS.B 7
AUSBUF:
 DS.B 20
