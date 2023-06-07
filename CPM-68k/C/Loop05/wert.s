* Routine zur Berechnung eines arith. Ausdrucks  - Assemblerteil
 
    .globl _init,_wert
 
_init:
    movem.l d3-d7/a3-a6,-(a7)
    move #23,d0     * Spezial Bios Einsprung
    trap #3
    move.l a4,merker
    movem.l (a7)+,d3-d7/a3-a6
    rts
 
_wert:                      * wert(string,ergebnis,status)
    link a6,#0              * fuer Parameter
    movem.l d3-d7/a3-a6,-(a7)
    movea.l 8(a6),a0         * Adresse des Textes
    move #29,d7             * WERT-Aufruf im Grundprogramm
    movea.l merker,a1
    movem.l a6,-(a7)        * retten ist sicherer
    jsr $420(a1)            * Aufruf Grundprogramm
    movem.l(a7)+,a6
    movea.l 12(a6),a0       * Ergebnis-Adresse
    movea.l 16(a6),a1       * Status-Adresse
    move.l d0,(a0)          * als Langwort ablegen
    move.w d1,(a1)          * Status ist Wort
    movem.l (a7)+,d3-d7/a3-a6
    unlk a6
    rts
 
fehler:
    rts                     * Falls Init vergessen wird
  
merker:
    dc.l fehler-$420
    end
