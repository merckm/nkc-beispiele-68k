; Grafik Demo aus LOOP 05 Seite 8
;
start:
    move    #9,d6
    ;
    loop:
        jsr     @clr
        jsr     @firsttime
        jsr     @hide
        addq    #1,d6
        clr     d4
        ;
        inner:
            addq    #1,d4
            move    d4,d0
            jsr     @schreite
            move    d6,d0
            jsr     @drehe
            cmpi    #350,d4
            bne     inner
        ;
        cmpi    #350,d6
        bne     loop
    ;
    bra     start
;
end