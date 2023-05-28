* Program zum Drucken von Texten im Editor
* unter CP/M 68K
* Aus LOOP 05, Seite 9

    .text
start:
    move    #23,d0      * Sonderfunktion des BIOS
    trap    #3
    move.l  a4,gruard
    move    #31,d7      * Textstart auf Anfang setzen
    jsr     $420(a4)    * CIINIT2
    movea.l gruadr,a4
loop:
    move    #32,d7      * Zeichen wird eingelesen
    jsr     $420(a4)    * CI2
    movea.l gruadr,a4
    beq.s   ende        * Wenn Textende erreicht ist
    move    #22,d7      * Zeichen wird auf Drucker ausgegeben
    jsr     $420(a4)    * LO
    movea.l gruadr,a4
    bra.s   loop        * Wenn nicht erreicht weider zurück
ende:
    rts                 * Textende ist erreicht
 
    .data
    .even
    gruadr: dc.l 0
end