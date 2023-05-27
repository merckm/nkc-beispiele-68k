test:
    move #200,d5

kreis:
    move d5,d3          * Radius holen
    mulu #279,d3        * (2*PI*RADIUS)/36*16
    divu #100,d3        * in gerundeter Form
    move #36-1,d4       * Anzahl der Durchlaeufe
.schleife:
    move #5,d0          * zuerst Drehen
    jsr @drehe
    move d3,d0
    jsr @schr16tel      * mit berechneter Zahl
    move #5,d0          * und gesamt 10 Grad
    jsr @drehe          * Drehung, aber
    dbra d4,.schleife   * symmetrisch.
    dbra d5,kreis
    rts