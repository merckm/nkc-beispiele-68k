*
* ASSEMBLERUNTERPROGRAMME
* FUER DIE TUERME VON HANOI
*
ORG $A800       * FREIEN PLATZ NEHMEN
 
ASSINIT:        * BILDSCHIRM VORBEREITEN
 JSR @CLRSCREEN
 CLR D0
 CLR D1
 JSR @SETFLIP
 RTS
 
ASSPLATTE:      * D0= HOEHE, D1=X, D2= Y
 LEA SCHEIBE,A0 * SCHEIBE AUSGEBEN
 JSR @FIGUR
RTS
 
ASSFEST:        * SCHEIDE FIXIEREN
 JSR @SETFIG
 RTS
 
SCHEIBE:        * SCHEIBENFORM
 DC.B 0,0,2,4,4,4,4,6,0,0,10
 
END