 org $9C00
 
start:
 move #10,d0    * Anzahl der Schritte
 jsr @schreite  * und vorwaerts
 move #8,d0     * Limit angeben
 jsr @rnd       * Zufalls-Zahl 0..7
 muls #45,d0    * 0,45,90,135,180,25,270,315
 jsr @drehe     * zufaellige Drehung
 jsr @csts      * bis Taste gedrueckt
 beq start      * wiederholen
 rts            * Ende
