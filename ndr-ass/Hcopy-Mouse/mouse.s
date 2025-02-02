;**************************************************
;* Programm zum Test der Maus-Schnittsetlle und
;* des Fadenkreuzes der HCOPY/MAUS-Platine mit
;* der CPU 68008.
;*
;* Nach dem Aufruf des Programms erscheint das
;* Fadenkreuz in der Mitte des Bildschirms und
;* folgt allen Bewegungen der Maus. Doe Betaetigung
;* einer Taste fuehrt zur Beendigung des Programms.
;*
;* (C) G. Sternberg 1985          Stand 24.7.1985
;**************************************************
 
LoX         equ $ffff89    ; Fadenkreuze X-Position (lo-Byte) 
HiX         equ $ffff88    ; Fadenkreuze X-Position (hi-Byte) 
LoY         equ $ffff8b    ; Fadenkreuze Y-Position (lo-Byte) 
HiY         equ $ffff8a    ; Fadenkreuze Y-Position (hi-Byte) 
Up          equ $ffff8c    ; Zaehler fuer Aufwaertsimpulse
Down        equ $ffff8d    ; Zaehler fuer Abwaertsimpulse
Right       equ $ffff8e    ; Zaehler fuer Rechtsbewegung
Left        equ $ffff8f    ; Zaehler fuer Linksbewegung
Latch       equ $ffff8d    ; Adresse zum Latchen der Zaehler
Clear       equ $ffff8e    ; Adresse zum Loeschen der Zaehler
 
Start:      move.w #$ffff-128,d0        ; Y-Position vorbelegen
            move.w #$ffff-256-191,d1    ; X-Position vorbelegen
 
Loop:       move.b #0,Latch             ; Zaehlerstand speichern
            move.b #0,Clear             ; alten Zaehlerstand loeschen
            move.l #0,d2                ; Register loeschen
            move.b Right,d2             ; Rechtsbewegung
            sub d2,d1                   ; X-Position aktualisieren
            move.b Left,d2              ; Linksbewegung
            add d2,d1                   ; X-Position aktualisieren
            move.b up,d2                ; Aufwaertsbewegung
            add d2,d0                   ; Y-Position aktualisieren
            move.b down,d2              ; Abwaertsbewegung
            sub d2,d0                   ; Y-Position aktualisieren

            move.b d0,LoY              ; Fadenkreuze Y-Position (lo-Byte)
            ror.w #8,d0                ; Register um 8 Bit verschieben
            move.b d0,HiY              ; Fadenkreuze Y-Position (hi-Byte) 
            ror.w #8,d0                ; Register um 8 Bit verschieben
            move.b d1,LoX              ; Fadenkreuze X-Position (lo-Byte)
            ror.w #8,d1                ; Register um 8 Bit verschieben
            move.b d1,HiX              ; Fadenkreuze X-Position (hi-Byte) 
            ror.w #8,d1                ; Register um 8 Bit verschieben
            btst #7,$ffff68            ; Taste gedrueckt?
            bne Loop

            move.b #0,LoX              ; Fadenkreuz ausblenden
            move.b #0,HiX
            move.b #0,LoY
            move.b #0,HiY
            rts
            end
            