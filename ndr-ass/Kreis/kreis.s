kreis:
    move #57,d0        ; RADIUS ZEICHNEN
    jsr @schreite
    move #90,d0
    jsr @drehe
 
    move #360-1,d3
schleife:
    move #1,d0
    jsr @schreite
    move #1,d0
    jsr @drehe
    dbra d3,schleife
    rts