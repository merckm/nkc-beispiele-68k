ORG $400
 
*      R A M - U S R
*
*      ROUTINE ZUM UMLENKEN DER CO2-ROUTINE INS RAM
*      MIT ANPASSUNG DER ZEICHENFOLGE FUER EDITOR
*
*      COPYRIGHT (C) 1985 BY RUEDIGER BAECKER - POSTFACH 4111 - 5280 GEVELSBERG
*
*       Aus LOOP 08/09, Seite 24
 
TEXT    EQU $30000          * ABLAGEADRESSE FUER TEXT AUS CO2-ROUTINE

USERINIT:                   * BELEGT IOSTAT MIT STARTADRESSE DER ROUTINE
    MOVE.W #$4EF9,$24(A5)   * SEDEZIMALER CODE FUER SPRUNGBEFEHL
    MOVE.L #USER,$24+2(A5)  * ADRESSE DER USER-ROUTINE

    MOVE #!USR,D7           * UMSCHALTEN AUS USR-AUSGABE
    TRAP #1
    MOVE.L #TEXT,MERKER     * ABLAGEADRESSE IN MERKER
 
    RTS
 
USER:                       * HIER EIGENTLICHE USR-ROUTINE
    MOVEM.L A5,-(A7)        * A5 RETTEN, DA VON GRPRG. BENUTZT
    MOVEM.L MERKER,A5       * DANN ABLAGEADRESSE HOLEN
 
    MOVE.B D0,(A5)+         * WERT AUS D0 DORTHIN
    MOVE.B #$0,(A5)         * ENDEZEICHRN DAHINTER
    MOVEM.L A5,MERKER       * ABLAGEADRESSE MERKEN
 
    MOVEM.L (A7)+,A5        * UND A5 WIEDER VOM STACK HOLEN
    RTS
 
MODIFY:                     * HIER ANPASSUNG VON ZEILENSCHALTUNG
    LEA TEXT,A0             * ABLAGEADRESSE HOLEN
 
MODIFLP:                    * WANDELROUTINE
    MOVE.B (A0)+,D0         * ZEICHEN HOLEN
    CMP.B #$0,D0            * ENDEZEICHEN ?
    BEQ ENDE1               * JA, DANN ENDE
    CMP.B #$A,D0            * LF ?
    BEQ WANDCR              * JA, DANN WANEL
    BRA MODIFLP             * SONST WEITER

ENDE1:                      * BEENDET WANDELROUTINE
    MOVE.L #TEXT,D0         * TESTSTART FUER EDITOR AUF ABLAGEADRESSE
    MOVE #!PUTSTX,D7        * SETZEN
    TRAP #1
    MOVE #!NIL,D7           * UND AUF 'Nur Fehler'-AUSGABE UMSCHALTEN
    TRAP #1
    RTS
 
WANDCR:                     * ZEICHENFOLGE $A,$D IN $D,$A WANDELN
    MOVE.B (A0),D0          * ZEICHEN HOLEN
    CMP.B #$D,D0            * MUSS $D SEIN
    BNE ENDE1               * SONST ENDE
    SUBA.L #1,A0            * AUF VORHERIGE SPEICHERADRESSE ZEIGEN
    MOVE.B #$D,(A0)+        * DANN $D,$A SETZEN
    MOVE.B #$A,(A0)+
    BRA MODIFLP             * UND WEITER
 
MERKER: DS.L 1
 
    END.