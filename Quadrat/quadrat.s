;
; Beispiel Program aus "Die Prozessoren 68000 und 68008" Seite 62
; Author Rolf-Dieter Klein
; VASM Assembler code von Dr. Martin Merck
;
	org $9C00

schreite	equ	1
drehe		equ	2

quadrat:
	move.w #4-1,d3
schleife:
	move.w #50,d0
	move.w #schreite,d7
	trap #1
	move.w #90,d0
	move.w #drehe,d7
	trap #1
	dbra d3,schleife
	rts

	end
	