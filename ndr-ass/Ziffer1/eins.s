    org 9000
ziffer1:
    move #-90,d0
    jsr @drehe
    move #50,d0
    jsr @schreite
    move #-25,d0
    jsr @schreite
    move #90,d0
    jsr @drehe
    move #100,d0
    jsr @schreite
    move #90+45,d0
    jsr @drehe
    move #5000/141,d0
    jsr @schreite
    rts
