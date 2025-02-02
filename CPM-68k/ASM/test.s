* BDOS Funktionsnummern (TRAP #2)
reboot = 0
printstr = 9
* BIOS Funktionsnummern (TRAB #3)
bconst = 2
bconin = 3
* Grundprogramm Funktionsnummern (TRAP #1)
 
 .text
 
start:
 link a6,#0
 
 move.l #header,d1
 move.w #printstr,d0
 trap #2
 
 move.l #line,d1
 move.w #printstr,d0
 trap #2
 
 move.l #drvinf0,d1
 move.w #printstr,d0
 trap #2
 
 move.l #drvinf1,d1
 move.w #printstr,d0
 trap #2
 
 move.l #drvinf2,d1
 move.w #printstr,d0
 trap #2

 move.l #line,d1
 move.w #printstr,d0
 trap #2
  
 move.l #fileinf0,d1
 move.w #printstr,d0
 trap #2
  
 move.w #14-1,d3
loop01:
 move.l #fileinf1,d1
 move.w #printstr,d0
 trap #2
  
 dbra d3,loop01

 move.l #line,d1
 move.w #printstr,d0
 trap #2
  
 move.l #cmd0,d1
 move.w #printstr,d0
 trap #2
  
 move.l #cmd1,d1
 move.w #printstr,d0
 trap #2
 
 move.b #2,d0
 move.b #22,d1
 jsr goxy

main:                   * Main Loop waiting for characters 
charwait:
 move.w #constat,d0
 trap #2
 cmp.b #0,d0
 beq charwait

 move.w #conin,d0
 trap #2
 
 cmp.b #'E',d0
 beq exit

 cmp.b #'e',d0
 beq exit
 
 move.b #2,d0
 move.b #22,d1
 jsr goxy

 bra main
 
exit:
 move.b #$1A,d1         * clear screen and home
 move.w #conout,d0
 trap #2

 unlk a6
 rts
 
* -----------------------------------------------------------------------
* SUBROUTINE: goxy
* 
* Dumps a 64 Byte block of memory
*
* Inputs:
*       D0: x postion on screen (0-79)
*       D1: y postion on screen (0-23)
*
* -----------------------------------------------------------------------
goxy:
 movem.l d0-d1/a0,-(a7)
 
 addi.b #32,d0 
 addi.b #32,d1 
 lea buffer,a0
 move.b #$1B,(a0)+  * ESC
 move.b #'=',(a0)+  * =
 move.b d1,(a0)+    * Y + 32
 move.b d0,(a0)+    * X + 32
 move.b #'$',(a0)+  * =End of string
 
 move.l #buffer,d1
 move.w #printstr,d0
 trap #2
 
 movem.l (a7)+,d0-d1/a0
 rts
 
 .data
 .even
 
buffer:
 .dc.l 100
 
header:
 .dc.b ' CPM-68K - File Explorer - (C) Martin Merck                                    '
 .dc.b 13,10,'$'
line:
 .dc.b '+--------------------------------------'
 .dc.b '+--------------------------------------+'
 .dc.b 13,10,'$'
drvinf0:
 .dc.b '| Drive: A:                            '
 .dc.b '| Drive: G:                            |'
 .dc.b 13,10,'$'
drvinf1:
 .dc.b '| Size:    776K    Free:     776K      '
 .dc.b '| Size:    776K    Free:     776K      |'
 .dc.b 13,10,'$'
drvinf2:
 .dc.b '| DirSize: 256     BlckSize: 2048      '
 .dc.b '| DirSize: 256     BlckSize: 2048      |'
 .dc.b 13,10,'$'
fileinf0:
 .dc.b '| Name         Size  Name         Size '
 .dc.b '| Name         Size  Name         Size |'
 .dc.b 13,10,'$'
fileinf1:
 .dc.b '|>FILEDIR2.68K 128K< FILEDIR2.68K 128K '
 .dc.b '| FILEDIR2.68K 128K  FILEDIR2.68K 128K |'
 .dc.b 13,10,'$'
cmd0:
 .dc.b '> '
 .dc.b 13,10,'$'
cmd1:
 .dc.b '| Ctrl-D=Sel Drive | Ctrl-V=Display |'
 .dc.b '$'
 
 .end
