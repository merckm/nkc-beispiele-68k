* BDOS Funktionsnummern (TRAP #2)
reboot	    = 0
open	    = 15
make    	= 22
read	    = 20
write   	= 21
close	    = 16
setdma	    = 26
printstr    = 9
 
* BIOS Funktionsnummern (TRAB #3)
* Grundprogramm Funktionsnummern (TRAP #1)
print2x     = 41
print8x     = 44
 
 .text
 
 .org $400
start:
 link a6,#0             * mark stack frame
 move.l 8(a6),a0    	* get the address of the base page
 move.l a0,baseadr	    * dort merken
 lea $5c(a0),a1		    * FCB
* move.l a1,d1		    * Adresse FCB laden
 move.l a1,fcbadr	    * dort merken
 
 
 move.l #message,d1
 move.w #printstr,d0
 trap #2
 
******************************************************
* Grundprogrammadresse ermitteln
*
 move #23,d0
 trap #3		* Sonderfunktion
 move.l a4,gruadr
*
* move.l #buffer,a0
* move.l baseadr,d0
* move #print8x,d7
* jsr $420(a4)		* PRINT8X
* move.b #' ',(a0)+
* move.b #'$',(a0)
* move.l #buffer,d1
* move.w #printstr,d0
* trap #2

*
 move.l #buffer,a0
 move.l baseadr,a1
 move #8-1,d3
loop1:
 move.l #buffer,a0
 move.l baseadr,d0
 move #print8x,d7
 jsr $420(a4)		* PRINT8X
 move.b #' ',(a0)+
 move.b #' ',(a0)+
 move #16-1,d4
loop2:
 move.b (a1)+,d0
 move #print2x,d7
 jsr $420(a4)		* PRINT2X
 move.b #' ',(a0)+
 dbra d4,loop2
 
 move.b #$d,(a0)+
 move.b #$a,(a0)+
 move.b #'$',(a0)
 move.l #buffer,d1
 move.w #printstr,d0
 trap #2
 
 dbra d3,loop1

exit:
 move #reboot,d0
 trap #2
 rts
 
 .data
 .even
 
baseadr: dc.l 0
fcbadr: dc.l 0
gruadr: dc.l 0 
 
buffer: ds.b 100
*
*   TPA Parameter Block
*
TRPB:   .dc.w  0
low:    .dc.l  1
high:   .dc.l  1
 
message:
 .dc.b 13,10,'Inhalt der Base Address:',13,10,'$'

free:
 .dc.b 'Freier Speicher in der TPA: 000000 Byte',13,10,'$'
 
errtxt:
 dc.b 13,10,'Fehler beim oeffnen der Datei',13,10,'$'
 
 .end
