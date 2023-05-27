start:      *
 move #5,d3 * 5-Eck
poly:       * m-Eck in d3
 move #360,d4
 divu d3,d4 * Winkel in d4
 sub #1,d3  * fuer DBRA Befehl
polyschleife:
 move #50,d0
 jsr @schreite
 move d4,d0
 jsr @drehe
 dbra d3,polyschleife
 rts
