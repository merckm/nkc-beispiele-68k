polyspi:
 move #2,d3     * Startwert
 move #200,d4   * Gesamtzahl
schleife:
 move d3,d0
 jsr @schreite
 move #144,d0   * Winkel
 jsr @drehe
 add #2,d3      * Laenge veraendern
 dbra d4,schleife
 rts
