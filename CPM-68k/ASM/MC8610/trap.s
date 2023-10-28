write     EQU  	10
read      EQU  	11
wert      EQU  	29
ci        EQU  	12
cls       EQU   16
clrscreen EQU   20
setflip   EQU   34

start:
    move #23,D0         * Grundprgstart in A4
    trap #3
    add.l #$3200,A4     * Adresse Traphandler
    move #22,D0         * BIOS Funktion SET EXCEPTION
    move #$21,D1        * TRAP #1 - Vektor
    move.l A4,D2        * Trappadresse in D2
    trap #3             * Nun fuehrt TRAP #1 wieder ins Grundprg.
    move.l D0,-(A7)     * alte Vectoradresse auf Stack retten
    move #cls,D7        * Bildschirm loeschen (ist Routine CLR)
    trap #1
    clr D0              * 2 Seitem-Flip aus
    clr D1              * 4 Seiten dto.
    move #setflip,D7    * aufrufen
    trap #1

ende2:
    move #clrscreen,D7
    trap #1
    move #22,D0         * BIOS Funktion SET EXCEPTION
    move #$21,D1        * TRAP #1 - Vektor
    move.l (A7)+,D2     * alten Exceptionvector zurueckholen
    trap #3             * Nun fuehrt TRAP #1 wider ins CP/M
    clr.l D0            * Code fuer BDOS REBBOT = 0
    trap #2             * return to CP/M - BDOS Aufruf
