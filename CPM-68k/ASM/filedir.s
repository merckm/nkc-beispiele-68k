* BDOS Funktionsnummern (TRAP #2)
reboot	    = 0
printstr    = 9
version     = 12
open	    = 15
close	    = 16
searchfirst = 17
searchnext  = 18
read	    = 20
write   	= 21
make    	= 22
currdisk    = 25
setdma	    = 26
getdpb      = 31
filesize    = 35
diskfree    = 46

* BIOS Funktionsnummern (TRAB #3)
* Grundprogramm Funktionsnummern (TRAP #1)
print2x     = 41
print4x     = 42
print8x     = 44
print8b     = 45
print4d     = 46
print8d     = 70
 
 .text
 
start:
 link a6,#0             * mark stack frame
 move.l 8(a6),a0    	* get the address of the base page
 move.l a0,baseadr	    * dort merken
 lea $5c(a0),a1		    * FCB1
 move.l a1,fcb1adr	    * dort merken
 lea $38(a0),a1		    * FCB2
 move.l a1,fcb2adr	    * dort merken
 
 move.l #info,d1
 move.w #printstr,d0
 trap #2
 
******************************************************
* Grundprogrammadresse ermitteln
*
 move #23,d0
 trap #3		* Sonderfunktion
 move.l a4,gruadr
*
 move.w #currdisk,d0
 trap #2

 move.b d0,currdrive

 move.l #(driveinfo+16),a0
 move #print4x,d7
 jsr $420(a4)		* PRINT4X
 move.b #' ',(a0)+

 move.l #driveinfo,d1
 move.w #printstr,d0
 trap #2

 move.l #dpb,d1
 move.w #getdpb,d0
 trap #2

 move.l #dpb,a1
 move.l (a1),d0 
 move.l #(dpbbuffer+7),a0
 move #print8x,d7
 jsr $420(a4)		* PRINT8X
 move.b #' ',(a0)+

 move.l 4(a1),d0 
 move.l #(dpbbuffer+15),a0
 move #print8x,d7
 jsr $420(a4)		* PRINT8X
 move.b #' ',(a0)+

 move.l 8(a1),d0 
 move.l #(dpbbuffer+23),a0
 move #print8x,d7
 jsr $420(a4)		* PRINT8X
 move.b #' ',(a0)+

 move.l 12(a1),d0 
 move.l #(dpbbuffer+31),a0
 move #print8x,d7
 jsr $420(a4)		* PRINT8X
 move.b #' ',(a0)+

 move.l #dpbbuffer,d1
 move.w #printstr,d0
 trap #2

 move.l #spt,a1 
 move.w (a1),d0 
 move.l #(drivedpb+7),a0
 move #print4d,d7
 jsr $420(a4)		* PRINT4D
 move.b #' ',(a0)+

 move.l #dsm,a1 
 move.w (a1),d0 
 move.l #(drivedpb+20),a0
 move #print4d,d7
 jsr $420(a4)		* PRINT4D
 move.b #' ',(a0)+

 move.l #drm,a1 
 move.w (a1),d0 
 move.l #(drivedpb+33),a0
 move #print4d,d7
 jsr $420(a4)		* PRINT4D
 move.b #' ',(a0)+
 
 move.l #off,a1 
 move.w (a1),d0 
 move.l #(drivedpb+46),a0
 move #print4d,d7
 jsr $420(a4)		* PRINT4D
 move.b #' ',(a0)+
 
 move.l #drivedpb,d1
 move.w #printstr,d0
 trap #2
 
 move.l #crlf,d1
 move.w #printstr,d0
 trap #2
 
 move.l fcb1adr,a0
 move.b currdrive,d0
 addq.b #1,d0
 move.b d0,(a0)+
 move.b #'?',(a0)+
 move.b #'?',(a0)+
 move.b #'?',(a0)+
 move.b #'?',(a0)+
 move.b #'?',(a0)+
 move.b #'?',(a0)+
 move.b #'?',(a0)+
 move.b #'?',(a0)+
 move.b #'?',(a0)+
 move.b #'?',(a0)+
 move.b #'?',(a0)+
 
* --- Get first directory entry
 
 move.l fcb1adr,d1  
 move.w #searchfirst,d0
 trap #2
 cmp #255,d0		* =255 dann keine Datei da
 beq error		    * dann Fehler
 move.w d0,-(A7)
 
 move.l #buffer,a0
 move #print4x,d7
 jsr $420(a4)		* PRINT4X
 move.b #13,(a0)+
 move.b #10,(a0)+
 move.b #'$',(a0)+

 move.l #buffer,d1
 move.w #printstr,d0
 trap #2
 
 move.w (A7)+,D0
 asl.w #5,D0

 move.l baseadr,d1
 addi.l #$80,d1
 add.w d0,d1
 move.l d1,a1
 cmpi.b #0,(a1)+
 bne error

 move.b #11,d0
 move.l #buffer,a0
 jsr memcpy
 lea 11(a0),a0
* move.b #' ',(a0)+
* move.b #' ',(a0)+
 move.b #13,(a0)+
 move.b #10,(a0)+
 move.b #'$',(a0)

 move.l #buffer,d1
 move.w #printstr,d0
 trap #2

* move.l fcb2adr,a0
* move.b currdrive,d0
* addq.b #1,d0
* move.b d0,(a0)+
* move.b #11,d0
* jsr memcpy

* move.l fcb2adr,d1  
* move.w #filesize,d0
* trap #2
* cmp #255,d0		* =255 dann keine Datei da
* beq error		    * dann Fehler
 
*  move.l #buffer,a0
*  movea.l fcb2adr,a1
*  move.b #0,(a0)+
*  move.b $21(a1),(a0)+
*  move.b $22(a1),(a0)+
*  move.b $23(a1),(a0)+
*  move.l #buffer,a0
*  move.l (a0),d0

*  move.l #buffer,a0
*  move #print8d,d7
*  jsr $420(a4)		* PRINT8D
*  move.b #13,(a0)+
*  move.b #10,(a0)+
*  move.b #'$',(a0)+

*  move.l #buffer,d1
*  move.w #printstr,d0
*  trap #2

dirloop:
* --- Get first directory entry
 
 move.l fcb1adr,d1  
 move.w #searchnext,d0
 trap #2
 cmp #255,d0		* =255 dann keine Datei da
 beq error		    * dann Fehler
 move.w d0,-(A7)
 
 move.l #buffer,a0
 move #print4x,d7
 jsr $420(a4)		* PRINT4X
 move.b #13,(a0)+
 move.b #10,(a0)+
 move.b #'$',(a0)+

 move.l #buffer,d1
 move.w #printstr,d0
 trap #2
 
 move.w (A7)+,D0
 asl.w #5,D0

 move.l baseadr,d1
 addi.l #$80,d1
 add.w d0,d1
 move.l d1,a1
 cmpi.b #0,(a1)+
 bne error2

 move.b #11,d0
 move.l #buffer,a0
 jsr memcpy
 lea 11(a0),a0
 move.b #' ',(a0)+
 move.b #' ',(a0)+
 move.b #'$',(a0)

 move.l #buffer,d1
 move.w #printstr,d0
 trap #2

*  move.l fcb2adr,a0
*  move.b currdrive,d0
*  addq.b #1,d0
*  move.b d0,(a0)+
*  move.b #11,d0
*  jsr memcpy

*  move.l fcb2adr,d1  
*  move.w #filesize,d0
*  trap #2
*  cmp #255,d0		* =255 dann keine Datei da
*  beq error		    * dann Fehler
 
*  move.l #buffer,a0
*  movea.l fcb2adr,a1
*  move.b #0,(a0)+
*  move.b $21(a1),(a0)+
*  move.b $22(a1),(a0)+
*  move.b $23(a1),(a0)+
*  move.l #buffer,a0
*  move.l (a0),d0

*  move.l #buffer,a0
*  move #print8d,d7
*  jsr $420(a4)		* PRINT8D
*  move.b #13,(a0)+
*  move.b #10,(a0)+
*  move.b #'$',(a0)+

*  move.l #buffer,d1
*  move.w #printstr,d0
*  trap #2

 bra dirloop

 bra exit

error:
 move.l #nofiles,d1
 move.w #printstr,d0
 trap #2
 bra exit
 
error2:
 move.l #direrror,d1
 move.w #printstr,d0
 trap #2

exit:
 move #reboot,d0
 trap #2
 rts
 
* -----------------------------------------------------------------------
* SUBROUTINE: memcpy
*
* Inputs:
*       D0: number of bytes to copy
*       A0: address of destination data
*       A1: address of source data
*
* -----------------------------------------------------------------------
memcpy:
 movem.l d0-d1/a0-a1,-(a7)
 subq #1,d0
cpyl01:
 move.b (a1)+,d1
 andi #$7F,d1
 move.b d1,(a0)+
 dbra d0,cpyl01

 movem.l (a7)+,d0-d1/a0-a1
 rts

* -----------------------------------------------------------------------
* SUBROUTINE: dumpblock
* 
* Dumps a 64 Byte block of memory
*
* Inputs:
*       D1: address of mwmory block to dump
*
* -----------------------------------------------------------------------
dumpblock:
 movem.l d0-d4/a0-a1,-(a7)
 move.l d1,a1
 
 move #8-1,d3
loop1:
 move.l #buffer,a0
 move.l a1,d0
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
 
 movem.l (a7)+,d0-d4/a0-a1
 rts

 .data
 .even
 
baseadr: dc.l 0
fcb1adr: dc.l 0
fcb2adr: dc.l 0
gruadr: dc.l 0 

currdrive: dc.b 0
*
*   TPA Parameter Block
*
trab:   .dc.w  0
low:    .dc.l  1
high:   .dc.l  1
 
*   DPB Disk Parameter Block
dpb:
spt:    .dc.w  0        * sectors per track
bsh:    .dc.b  0        * block shift factor
blm:    .dc.b  0        * block mask
exm:    .dc.b  0        * extend mask
res:    .dc.b  0
dsm:    .dc.w  0        * 
drm:    .dc.w  0        * 
res2:   .dc.w  0        * reserved
cks:    .dc.w  0        * length of checksum in bytes 
off:    .dc.w  0        * track offset to directory

* Disk1 information
disk1info:
d1drive:    .dc.w       * disk drive letter (A:-P:)
d1size:     .dc.l       * in bytes
d1free:     .dc.l       * in bytes
d1blocks:   .dc.w       * Number of blocks on disk (DSM from FCB)
d1blcksize: .dc.w       * block size 128 << bsh

info:
 .dc.b 13,10,'Exploring the CP/M-68K System',13,10,'$'
 
crlf:
 .dc.b 13,10,'$'
 
driveinfo:
 *            234567890123456
 .dc.b 13,10,'Active drive: xxxx ','$'
 
drivedpb:
 *                    1         2         3         4         5 
 *            2345678901234567890123456789012345678901234567890
 .dc.b 13,10,'SPT:       - DSM:       - DRM:       - OFF:       ','$'
 
dpbbuffer:
 *                    1         2         3         4         5 
 *            2345678901234567890123456789012345678901234567890
 .dc.b 13,10,'DPB: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ','$'
 
nofiles:
 .dc.b 13,10,'No files where found on dirve 0:','$'
 
direrror:
 .dc.b 13,10,'Strange directory entry:','$'
 
 .bss
buffer: ds.b 100
drive1info: ds.b 256*(12+1+)
 .end
