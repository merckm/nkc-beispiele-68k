***************************************
* ASSEMBLER-ROGRAMM                   *
* SPEICHERPLATZ $9000                 *
* WIRD ALS 1.PROGRAMM GELADEN         *
*                                     *
* LOOP 05, Seite 11                   *
***************************************
 
*** SQASH - ASSEMBLER- UNTERPOGRAMM ***
 
BALL:
 LEA FIGUR,A0
 MOVE #2,D0
 JSR @FIGUR
 RTS
 
SCHLAEGER:
 MOVE #4,D2
 JSR @MOVETO
 ADD D3,D1
 JSR @DRAWTO
 RTS
 
SCHREIBEN:
 JSR @SETPEN
 JSR SCHLAEGER
 RTS
 
LOESCHEN:
 JSR @ERAPEN
 JSR SCHLAEGER
 RTS
 
NAME:
 LEA TEXT,A0
 MOVE #5,D1
 MOVE #100,D2
 MOVE #7,D0
 JSR @WRITE
 RTS
 
TEXT:
 DC.B 'SQASH',0
FIGUR:
 DC.B 4,5,6,7,0,0,1,2,3,4,10