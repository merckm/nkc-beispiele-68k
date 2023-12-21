START:
    jsr @clrscreen
    clr d0
    clr d1
    jsr @setflip
    clr d4
SCHLEIFE:
    lea ZIEL,a0
    move.B d4,d0
    jsr @PRINT2X
    lea ZIEL,a0
    move.B #$22,d0
    move #2,d1
    move #128,d2
    jsr @write
    move #4,d0
    jsr @delay
    addq #1,d4
    cmp #256,D4
    bne SCHLEIFE
 
    move.w #1,d0
    clr d1
    jsr @setflip
 
    rts
ZIEL:
    ds.b 10
