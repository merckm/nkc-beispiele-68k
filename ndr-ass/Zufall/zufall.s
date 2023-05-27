 org $9C00
 
start:
 move #4,d0     * Anzahl der Schritte
 jsr @schreite  * und vorwaerts
 move #360,d0   * Limit angeben
 jsr @rnd       * Zufalls-Zahl 0..359
 jsr @drehe     * zufaellige Drehung
 jsr @csts      * bis Taste gedrueckt
 beq start      * wiederholen
 rts            * Ende
 