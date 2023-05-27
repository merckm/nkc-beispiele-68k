quadrat:
 move #4-1,d3
quad1:
 move #100,d0
 jsr @schreite
 modve #90,d0
 jsr @drehe
 dbra d3,quad1
 rts 
 
dreieck:
 move #3-1,d3
drei1:
 move #100,d0
 jsr @schreite
 move #120,d0
 jsr @drehe
 dbra d3,drei1:
 rts 
 
start:
haus:
 bsr quadrat
 move #100,d0
 jsr @schreite
 move #30,d0
 jsr @drehe
 bsr dreieck
 rts
 
 end