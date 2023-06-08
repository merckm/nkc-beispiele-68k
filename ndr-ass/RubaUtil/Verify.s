ORG $400
 
*      V E R I F Y 6 8
*
*      ROUTINE ZUM VERGLEICHEN VON SPEICHERBEREICHEN
*
*      COPYRIGHT (C) 1985 BY RUEDIGER BAECKER - POSTFACH 4111 - 5280 GEVELSBERG
*
*       Aus LOOP 08/09, Seite 22/23
 
KOPF:
DC.L $55AA0180
DC.B 'VERIFY  '
DC.L START-KOPF
DC.L ENDEA-KOPF
DC.B 1
DC.B 0,0,0
DC.L 0,0
 
ZIELADR     EQU     $F4         * ADRESSE EINGABEBUFFER
TAST        EQU     $FFFFFF68
  
START:
    MOVE #!CLPG,D7
    TRAP #1
 
    CLR.B TAST+1
    CLR.L D0
    CLR.L D1
    CLR.L D2
    CLR.L D3
 
    LEA TEXT3(PC),A0            * TEXTE AUSGEBEN
    MOVE.B #$43,D0
    MOVE.B #0,D1
    MOVE.B #200,D2
    MOVE #!WRITE,D7
    TRAP #1
    SUB #45,D2
    LEA TEXT7(PC),A0
    MOVE.B #$32,D0
    MOVE #!WRITE,D7
    TRAP #1 
    SUB #40,D2
    MOVE.B #$21,D0
    LEA TEXT4(PC),A0
    MOVE #!WRITE,D7
    TRAP #1
     
    SUB #20,D2
    LEA TEXT5(PC),A0
    MOVE #!WRITE,D7
    TRAP #1 
    SUB #20,D2
    LEA TEXT6(PC),A0
    MOVE #!WRITE,D7
    TRAP #1
 
GETW1:                         * DANN DATEN HOLEN (VON, BIS, MIT)
    MOVE.B #$21,D0
    MOVE.B #115,D2
    MOVE.B #250,D1
    MOVE.B #9,D3
    LEA ZIELADR(A5),A0
    MOVE #!READ,D7
    TRAP #1
    LEA ZIELADR(A5),A0
    MOVE.B (A0),D4
    CMP.B #'m',D4               * 'm' GEDRUECKT ?
    BEQ VERIEEND                * JA, DANN ENDE
    MOVE #!WERT,D7
    TRAP #1
    MOVEA.L D0,A3
 
GETW2:
    MOVE.B #$21,D0
    MOVE.B #95,D2
    MOVE.B #250,D1
    LEA ZIELADR(A5),A0
    MOVE #!READ,D7
    TRAP #1
    LEA ZIELADR(A5),A0
    MOVE #!WERT,D7
    TRAP #1
    MOVEA.L D0,A4
 
GETW3:
    MOVE.B #$21,D0
    MOVE.B #75,D2
    MOVE.B #250,D1
    LEA ZIELADR(A5),A0
    MOVE #!READ,D7
    TRAP #1
    LEA ZIELADR(A5),A0
    MOVE #!WERT,D7
    TRAP #1
    MOVEA.L D0,A2
 
VERIFYLP:                       * NUN DATEN VERGLEICHEN
    CMPM.B (A3)+,(A2)+          * GLEICH ?
    BNE ERROR                   * NEIN DANN FEHLER
    CMPA.L A3,A4                * ALLES VERGLICHEN ?
    BEQ OK                      * JA, DANN OK-MELDUNG
    BRA VERIFYLP                * SONST WEIER
VERIEEND:
    RTS
  
ERROR:
    LEA TEXT1(PC),A0
    MOVE.B #$21,D0
    MOVE.B #0,D1
    MOVE.B #40,D2
    MOVE #!WRITE,D7
    TRAP #1
    MOVE.L A2,D0
    LEA ZIELADR(A5),A0
    MOVE #!PRINT8X,D7
    TRAP #1
    LEA ZIELADR(A5),A0
    MOVE.B #$21,D0
    MOVE.B #250,D1
    MOVE.B #40,D2
    MOVE #!WRITE,D7             * ADDRESSE DES FALSCHEN WERTES
    TRAP #1
    RTS
 
OK:
    LEA TEXT2(PC),A0
    MOVE.B #$21,D0
    MOVE.B #0,D1
    MOVE.B #40,D2
    MOVE #!WRITE,D7
    TRAP #1
    RTS

TEXT1:
    DC.B 'Fehler ! -->',0
TEXT2:
    DC.B 'OK !',0
TEXT3:
    DC.B 'Verify 68',0
TEXT4:
    DC.B 'Startadresse     ==>',0
TEXT5:
    DC.B 'Endadresse       ==>',0
TEXT6:
    DC.B 'Vergleichen ab   ==>',0
TEXT7:
    DC.B '(C) 1985 by Ruediger Baecker',0
 
ENDEA:
    END.
