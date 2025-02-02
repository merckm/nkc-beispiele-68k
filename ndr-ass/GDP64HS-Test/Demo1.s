;*********************************************************
;*        Demo- Programm (Schildkroete)                  *
;*        fuer 680xx- Systeme                            *
;*********************************************************

start:
 move #50,d1             ;setzen bei 50/50   
 move #50,d2
 move #90,d3             ; Richtung nach oben
 jsr @set

 move #100,d0            ; 50 * schreiten und zeichnen
 jsr @schreite

 jsr @hebe               ; Schreibstift anheben
 move #50,d0             ; 50 * schreiten und zeichnen
 jsr @schreite

 move #-45,d0            ; um 45 Grad drehen
 jsr @drehe
 
 jsr @senke              ; Schreibstift ansenken
 move #50,d0             ; 50 * schreiten und zeichnen
 jsr @schreite

 move #-45,d0            ; um 45 Grad drehen
 jsr @drehe
 
 move #50,d0             ; 50 * schreiten und zeichnen
 jsr @schreite
 rts
 
 end