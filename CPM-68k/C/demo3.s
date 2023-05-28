* Assemblerprogramm zum Aufruf vo Grundprog.
* Funktionen von C aus.
* Loop 04, Seite 13
    .globl _init,_moveto,_drawto
_init:
    movem.l d3-d7/a3-a6,-(a7)
    move #23,d0     * Spezial Bios Einsprung
    trap #3
    move.l a4,merker
    movem.l (a7)+,d3-d7/a3-a6
    rts
 
_moveto:
    link a6,#0
    movem.l d3-d7/a3-a6,-(a7)
    move.w 8(a6),d1
    move.w 10(a6),d2
    move #8,d7
    movea.l merker,a0
    jsr $420(a0)
    movem.l (a7)+,d3-d7/a3-a6
    unlk a6
    rts
 
_moveto:
    link a6,#0
    movem.l d3-d7/a3-a6,-(a7)
    move.w 8(a6),d1
    move.w 10(a6),d2
    move #9,d7
    movea.l merker,a0
    jsr $420(a0)
    movem.l (a7)+,d3-d7/a3-a6
    unlk a6
    rts
 
fehler:
    rts
 
merker: dc.l fehler
    end
