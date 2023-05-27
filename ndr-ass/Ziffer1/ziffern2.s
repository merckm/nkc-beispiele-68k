;
; PROGRAMM FUER UNTERSCHIEDLICH
; GROSSE ZIFFERN
;
    org 9000
ZIFFER:
    move #-90,d0
    jsr @drehe
    move d3,do
    mulu #2,d0
    jsr @schreite
    move d3,do
    jsr @schreite
    move #90,d0
    jsr @drehe
    move d3,do
    mulu #4,d0
    jsr @schreite
    move #90+45,d0
    jsr @drehe
    move d3,do
    mulu #200,d0
    divu #141,d0
    jsr @schreite
    mode #-90-45,d0     ; ZURUECKDREHEN
    jsr @drehe
    jsr @hebe           ; KEINE LINIE ZEICHNEN
    move d3,do
    mulu #3,d0          ; 3 * GROESSE BIS UNTEN
    jsr @schreite
    jsr @hsenke
    rts

START:
    move #10,d3
    bsr ZIFFR
    move #20,d3
    bsr ZIFFR
    move #50,d3
    bsr ZIFFR
    rts