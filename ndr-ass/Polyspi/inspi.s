inspi:
 move #0,d3     * Winkel
 move #7,d4     * Increment
 move #400,d5   * Schleifendurchlaufe
schleife:
 move #10,d0
 jsr @schreite
 move d3,d0
 jsr @drehe
 add d4,d3      * neuen Winkel bestimmen
 dbra d5,schleife
 rts
