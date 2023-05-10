* BDOS Funktionsnummern (TRAP #2)
printstr = 9
* BIOS Funktionsnummern (TRAB #3)
* Grundprogramm Funktionsnummern (TRAP #1)
 
 .text
 
start:
 link a6,#0
 
 move.l #message,d1
 move.w #printstr,d0
 trap #2
 
 unlk a6
 rts
 
 .data
 .even
 
variable:
 .dc.l 100
 
message:
 .dc.b 13,10,'Hallo, ich bin der NKC',13,10,'$'
 
 .end
