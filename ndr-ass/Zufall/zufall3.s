 org $9C00
 
start:
 move #512,d0   * x-Koordinate max
 jsr @rnd       * bestimmen
 move d0,d1     * und mercken
 move #256,d0   * y-Koordinate
 jsr @rnd       * bestimmen
 move d0,d2     * fuer MOVETO
 jsr @moveto    * positionieren
 move.b #$80,d0 * Befehl fuer Einzelpunkt
 jsr @cmd       * an GDP ausgeben
 jsr @csts      * bis Taste gedrueckt
 beq start      * wiederholen
 rts
