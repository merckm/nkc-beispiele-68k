ORG $400
 
*      R U B A F I L L  6 8
*
*      ROUTINE ZUM FUELLEN VON SPEICHERBEREICHEN
*
*      COPYRIGHT (C) 1985 BY RUEDIGER BAECKER - POSTFACH 4111 - 5280 GEVELSBERG
*
*       Aus LOOP 08/09, Seite 25
 
KOPF:
DC.L $55AA0180
DC.B 'Rubafill'
DC.L RUBAFILL-KOPF
DC.L FILLEND-KOPF
DC.B 1
DC.B 0,0,0
DC.L 0,0
 
ZIELADR     EQU     $9DA        * ADRESSSE EINGABEBUFFER
TAST        EQU     $FFFFFF68
 
RUBAFILL:
    MOVE #!CLPG,D7
    TRAP #1
 
    CLR.B TAST+1
    CLR.L D0
    CLR.L D1
    CLR.L D2
    CLR.L D3
 
    LEA TEXT9(PC),A0            * TEXTE AUSGEBEN
    MOVE.B #$43,D0
    MOVE.B #0,D1
    MOVE.B #200,D2
    MOVE #!WRITE,D7
    TRAP #1
    SUB #45,D2
    LEA DT2(PC),A0
    MOVE.B #$32,D0
    MOVE #!WRITE,D7
    TRAP #1 
    SUB #40,D2
    MOVE.B #$21,D0
    LEA TEXT10(PC),A0
    MOVE #!WRITE,D7
    TRAP #1
     
    SUB #20,D2
    LEA TEXT11(PC),A0
    MOVE #!WRITE,D7
    TRAP #1 
    SUB #20,D2
    LEA TEXT12(PC),A0
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
    BEQ ENDE                    * JA, DANN ENDE
    MOVE #!WERT,D7
    TRAP #1
    MOVEA.L D0,A3               * VON IN A3
 
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
    MOVEA.L D0,A4               * BIS IN A4
 
GETW3:
    MOVE.B #$21,D0
    MOVE.B #75,D2
    MOVE.B #250,D1
    LEA ZIELADR(A5),A0
    MOVE #!READ,D7
    TRAP #1
    LEA ZIELADR(A5),A0
    MOVE #!WERT,D7
    TRAP #1                     * FILLWERT IN D0

FILL:                           * NUN SPEICHER FUELLEN
    MOVE.B D0,(A3)+
    CMPA.L A3,A4
    BEQ ENDE
    BRA FILL
 
ENDE:
    RTS
FILLEND:                      * MERKER FUER BIBLIOTHEKSEINTRAG

TEXT9:
    DC.B 'Rubafill 68',0
TEXT10:
    DC.B 'Startadresse    ==>',0
TEXT11:
    DC.B 'Endadresse      ==>',0
TEXT12:
    DC.B 'Fuellwert       ==>',0
DT2:
    DC.B '(C) 1985 by Ruediger Baecker',0
