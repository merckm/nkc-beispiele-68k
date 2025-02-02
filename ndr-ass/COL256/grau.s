cpu equ 1
colcrt equ $ffffffac*cpu
colcrtd equ $ffffffad*cpu
colcrtb equ $ffffffae*cpu
coladr equ $a0000
 
start:
 bsr colinit
 move.b #$80, colcrtb.w
 bsr grau
 move.b #$00, colcrtb.w
 rts
 
grau:
 movea.l #coladr, a0
 move #255, d4
grau01:
 move #255, d3
grau02:
 move.b d3, (a0)+            * fuer Grautreppe
 move.b #$00110000           * fuer homogenes Blau
 move.b #$00001100           * fuer homogenes Gruen
 move.b #$00000011           * fuer homogenes Rot
 subq #1, d3
 bpl.s grau02
 subq #1, d4
 bpl.s grau01
 rts
 
colinit:
 lea coltab(pc), a0
 clr d1
 move #length-1, d3
colilp01:
 move.b d1, colcrt.w 
 move.b (a0)+, colcrtd.w
 addq #1, d1
 dbra d3, colilp01
 rts
 
coltab:
 dc.b 111, 64, 80, 7, 79, 0, 64, 70, 0, 3, 0, 0, 0, 0, 0
 
length equ *-coltab

 ds 0