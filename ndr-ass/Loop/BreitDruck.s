; Das Programm druckt sich eselbst aus.
; Soll ein anderes Programm ausgedruckt werden,
; muss zuerst der Textstart geändert werden
;
; Aus LOOP 05, Seite 8
    org $0
    offset $a000
    dc.l $55AA0180
    dc.b 'Breit Dr'
    dc.l start
    dc.l ende
    dc.b 1,0,0,0
    dc.l 0,0,0
    dc.l 0,0
;
start:
    move #!ciinit2,d7       * Ram auslesen
    trap #1
loop:
    move #$1b,d0    * ESC setzen
    move #!lo,d7    * Drucker initialisieren
    trap #1
    move #$0e,d0    * umschalten auf Breitschrift
    move #!lo,d7
    trap #1
    move #!ci2,d7   * Zeichen lesen
    trap #1
    beq ende
    move #!lo,d7   * Zeichen auf Drucker ausgeben
    trap #1
    bra.s loop
ende:
    move #$12,d0    * Drucker auf Normalschrift schalten
    move #!lo,d7
    trap #1
    rts
