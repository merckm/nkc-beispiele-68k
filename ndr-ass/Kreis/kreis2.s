test:
    move #200,d5

kreis:
    move d5,d3        ; RADIUS ZEICHNEN
    mulu #279,d3        ; (2*PI*RADIUS)/36*16
    divu #100,d3        ; GERUNDET
    
    move #36-1,d4
.schleife:
    move #5,d0
    jsr @drehe
    move d3,d0
    jsr @schr16tel
    move #5,d0
    jsr @drehe
    dbra d4,.schleife
    dbra d5,kreis
    rts