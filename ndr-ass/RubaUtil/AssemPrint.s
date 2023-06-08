ORG $20000
 
* A S S E M P R I N T  6 8
* DRUCKERROUTINE FUER EPSONDRUCKER
* COPYRIGHT (C) 1985 BY  :
* RUEDIGER BAECKER - POSTFACH 4111 - 5280 GEVELSBERG 11
*
* Aus LOOP 04, Seite 11
 
KOPF:
DC.L $55AA0180
DC.B 'A-Print '
DC.L Q-KOPF
DC.L ENDEA-KOPF
DC.B 1
DC.B 0,0,0
DC.L 0,0
 

ESC     EQU     $1B
 
LO:
    MOVE !LO,D7
    TRAP #1
    RTS
 
Q:                          * ENTRY
    MOVE #ESC,D0            * DRUCKER NORMALMODUS
    BSR LO
    MOVE #'@',D0
    BSR LO
 
INITZE:                     * ZEICHENSATZ AUF AMERIKANISCH
    MOVE #ESC,D0
    BSR LO
    MOVE #'R',D0
    BSR LO
    MOVE #0,D0
    BSR LO
 
INITS1:                     * DRUCKER AUF SCHMALSCHRIFT
    MOVE #ESC,D0
    BSR LO
    MOVE #15,D0
    BSR LO
 
INITZA:                     * ZEILENABSTAND VORBELEGEN
    MOVE #ESC,D0
    BSR LO
    MOVE #1,D0              * 1/8 " ZEILENABSTAND
    BSR LO
 
INITFL:                     * FORMULARLAENGE SETZEN
    MOVE #ESC,D0
    BSR LO
    MOVE #'C',D0
    BSR LO
    MOVE #72,D0
    BSR LO
 
INITLR:                     * LIMKER RAND SETZEN
    MOVE #ESC,D0
    BSR LO
    MOVE #'l',D0
    BSR LO
    MOVE #15,D0
    BSR LO

    MOVE #!LST,D7           * UMSCHALTEN AUF DRUCKERAUSBABE
    TRAP #1
    MOVE #!ASSEMBLE,D7      * DANN ASSEMBLER AUFRUFEN
    TRAP #1
    MOVE #7,D0              * PIEPSER ALS FERTIGMELDUNG
    BSR LO
    MOVE #12,D0             * FORMULAR FEED
    BSR LO
    MOVE #ESC,D0            * DRUCKER AUFNORMALMODUS
    BSR LO
    MOVE #'@',D0
    BSR LO
    MOVE #!NIL,D7           * NUR FEHLERAUSGABE
    TRAP #1
    RTS                     * ZURUECK ZUM GRUNDPROGRAMM

ENDEA: