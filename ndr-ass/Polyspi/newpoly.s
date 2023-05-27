newpoly:
 move #125,d3   * Startwinkel
 move #200,d4   * Gesantzahl
schleife:
 move #20,d0
 jsr @schreite
 move d3,d0
 jsr @drehe
 move #20,d0
 jsr @schreite
 move d3,d0
 add d0,d0      * Winkel * 2
 jsr @drehe
 dbra d4,schleife
 rts
