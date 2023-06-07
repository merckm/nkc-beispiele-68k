* Assemblerprogramm fuer Turtle-Geometrie
*
* Einfuehrung in C Teil 3
* Loop 06, Seite 15
    .globl _initturt,_schreite,_drehe
 
_initturt:          * initturt()
    movem.l d3-d7/a3-a6,-(a7)
    move #23,d0     * Grundprog. Start
    trap #3         * ueber BIOS
    move.l a4,grund
    movem.l (a7)+,d3-d7/a3-a6
    rts
 
_schreite:          * schreite(schrittzahl)
    link a6,#0
    movem.l d3-d7/a3-a6,-(a7)
    move.w 8(a6),d0
    move #1,d7      * schreite
    movea.l grund,a0
    jsr $420(a0)    * Grundprogramm
    movem.l (a7)+,d3-d7/a3-a6
    unlk a6
    rts
 
_drehe:             * drehe(winkel)
    link a6,#0
    movem.l d3-d7/a3-a6,-(a7)
    move.w 8(a6),d0 * Winkel als Parameter
    move #2,d7      * Drehe
    movea.l grund,a0
    jsr $420(a0)    * Grundprogramm
    movem.l (a7)+,d3-d7/a3-a6
    unlk a6
    rts
 
err:                * falls init vergessen
    rts
 
grund: dc.l err-$420
    end
