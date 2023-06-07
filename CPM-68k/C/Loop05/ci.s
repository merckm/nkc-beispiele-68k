* Zeichen einlesen, Assembler-Teil
 
    .globl _init,_ci
    
_init:
    movem.l d3-d7/a3-a6,-(a7)
    move #23,d0     * Spezial Bios Einsprung
    trap #3
    move.l a4,merker
    movem.l (a7)+,d3-d7/a3-a6
    rts
 
_ci:
    movem.l d3-d7/a3-a6,-(a7)
    move #12,d7             * CI-Aufruf im Grundprogramm
    movea.l merker,a0       * Grundprogramm Basis
    jsr $420(a0)            * Unterprogramm ausfuehren, Ergebnis nach D0.L
    movem.l (a7)+,d3-d7/a3-a6
    rts
 
fehler:
    rts
  
merker:
    dc.l fehler-$420
    end
