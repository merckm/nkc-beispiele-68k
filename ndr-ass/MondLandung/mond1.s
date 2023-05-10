;*******************************;
; MONDLANDEPROGRAMM VERSION 1.0 ;
;*******************************;

    org $A000

; ***** VEREINBARUNGS-BAUSTEINE *****

TASTEN EQU $FFFFFF30
RECHTS EQU 1            ; BIT MASKEN
LINKS  EQU 2
RAUF   EQU 4
RINTER EQU 8

ERFOLGTEXT:
    DC.B    'Gut gelandet',0
BRUCHTEXT:
    DC.B    'Bruchlandung',0

FAEHRE:
    DC.B    8,2,9,0,0,7,3,2,2,4,4,4,4
    DC.B    6,6,5,1,0,0,10

    DS 0        ; ANGLEICH AUF WORTGRENZE


    