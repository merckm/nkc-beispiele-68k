ORG $400                    * GRUNDPRG: LIEGT AB $E0000
 
* E P R O M C H E C K
* PROGRAMM PRUEFT; OB EPROM LEER IST (PARAMETER FUER 2764, GGF. AENDERN)
* (C) 1985 - RUEDIGER BAECKER, POSTFACH 4111, 820 GEVELSBERG 11
* AUS LOOP Nr 03 Seite 15
 
LOPPROM EQU $2568       * ADRESSE DER VERWENDETEN GRUNDPRG. - ROUTINE

PROMREAD:
 MOVE #!GETBASIS,D7     * BASISADRESSE DES GRUNDPRG HOLEN
 TRAP #1
 MOVEA.L A0,A1          * RETTEN
 MOVE.L #$0,D6          * VON
 MOVE.L #$1FFF,D7       * BIS
 MOVEA.L A5,A0          * IN A5 STEHT STARTADRESSE DES SYSTEMRAMS
 ADDA.L #$1000,A0       * NACH
 MOVEA.L A0,A2          * RETTEN
 JSR LOPPROM(A1)        * DANN EPROM LESEN
 
PROMCHECK:
 MOVE #$1FFE,D0         * SCHLEIFENZAEHLER

CHLP:
 CMP.B #$FF,(A2)+       * $FF ?
 BNE ERROR              * NEIN, DANN NICHT LEER
 DBRA D0,CHLP
 
 LEA OKTXT,A0           * ALLES OK, EPROM LEER
 BRA TXTAUS
 
ERROR:
 LEA ERTXT,A0           * FEHLERMELDUNG
 BRA TXTAUS
 
TXTAUS:
 MOVE #$33,D0           * SCHRIFTGROESSE UND KOORDINATEN SETZEN
 MOVE #100,D2
 CLR.L D1
 MOVE #!WRITE,D7        * UND AUSGEBEN
 TRAP #1

 MOVE #!CI,D7           * WARTE, BIS TASTE GEDRUECKT
 TRAP #1
 CMP.B #$D,D0           * 'cr' GEDRUECKT ?
 BEQ PROMREAD           * JA, DANN WEITER MIT DEM NAECHSTEN EPROM
 RTS                    * SANST ENDE
 
ERTXT:
 DC.B 'Eprom nicht leer !',0
OKTXT:
 DC.B 'Eprom leer',0