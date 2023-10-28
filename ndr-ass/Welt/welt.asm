***************************************** 
*                                       *
*               Globus                  *    
*                                       *
*       A = kleiner                     *
*       S = rechts                      *   
*       D = hoch                        *
*       J = runter                      *        
*       K = links                       *
*       L = gr�sser                     *
*     ESC = verlassen                   *  
*                                       *
***************************************** 
 
 
start:
        clr dr       
        clr wi
        clr escflag     
 
lp:
        move #!clr,d7
        trap #1
        move r,d3    
        bsr kreis
        lea daten,a0
        move (a0)+,d7
lp01:
        move.l d7,-(a7)
        move (a0)+,d7 
        subq #1,d7
        move.l d7,-(a7) 
        move (a0)+,d6
        move (a0)+,d5 
        jsr calc
        move d4,x1
        move d3,y1
        move.l (a7)+,d7
lp02:
        move.l d7,-(a7)      
        move (a0)+,d6
        move (a0)+,d5
        jsr calc
        move d4,x2 
        move d3,y2
        tst z              
        bpl.b lp03
        tst za
        bmi.b lp04  
lp03:
        cmp x1,d4
        bne.b lp03a      
        cmp y1,d3  
        bne.b lp03a 
        bra.b lp04
lp03a:
        move x0,d1
        add x1,d1
        move y0,d2
        add y1,d2 
        asr #1,d2     
        move #!moveto,d7
        trap #1
        move x0,d1
        add x2,d1
        move y0,d2
        add y2,d2
        asr #1,d2     
        move #!drawto,d7
        trap #1
lp04: 
        move x2,x1
        move y2,y1
        move.l (a7)+,d7   
        dbra.b d7,lp02       
        move.l (a7)+,d7 
        dbra.b d7,lp01

        move #!ci,d7
        trap #1
        lea beftab,a1
        move #-1,d2
lp05:
        addq #1,d2
        move.b (a1)+,d1
        beq.b lp06  
        cmp.b d1,d0
        bne.b lp05     
     
        lea befntab,a1
        asl #2,d2
        adda d2,a1
        movea.l (a1),a1       
        jsr (a1)          
lp06:
        tst escflag
        bpl lp  
 
lpex:
        rts  
 
beftab:
        dc.b 'laksjd',$1b,0      
        ds 0
 
befntab:
        dc.l befl             
        dc.l befa
        dc.l befk
        dc.l befs
        dc.l befj
        dc.l befd
        dc.l befesc
 
befl:        
        cmp #250,r  
        bge.b beflex
        add #10,r        
beflex:           
        rts  
 
befa:        
        cmp #10,r
        ble.b befaex
        sub #10,r
befaex:            
        rts  
 
befk:
        add #10,dr    
        cmp #180,dr
        bne.b befkex
        move #-180,dr
befkex:        
        rts
 
befs:
        sub #10,dr
        cmp #-180,dr
        bne.b befsex
        move #180,dr
befsex:        
        rts
 
befj:
        cmp #90,wi
        beq.b befjex
        add #10,wi
befjex:        
        rts
 
befd:
        cmp #-90,wi
        beq.b befdex
        sub #10,wi
befdex:
        rts
 
befesc:
        move #-1,escflag
        rts
 
eingabe:
        move #$11,d0
        move #20,d1 
        move #240,d2
        move #!write,d7
        lea drehtxt,a0
        trap #1
        move #$11,d0
        move #185,d1
        move #240,d2
        move #3,d3 
        move #!read,d7
        lea puffer,a0 
        trap #1
        move #!wert,d7 
        lea puffer,a0
        trap #1
        move d0,dr 
 
        move #$11,d0
        move #20,d1 
        move #220,d2
        move #!write,d7
        lea neigtxt,a0
        trap #1
        move #$11,d0
        move #185,d1
        move #220,d2
        move #3,d3 
        move #!read,d7
        lea puffer,a0 
        trap #1
        move #!wert,d7 
        lea puffer,a0
        trap #1
        move d0,wi 
        rts
 
drehtxt:
        dc.b 'Drehung    ( z.B. :  0 ) : ',0 
neigtxt:
        dc.b 'Neigung    ( z.B. : 50 ) : ',0 
 
 
kreis:                  ;  d3=r           
 
        move d3,d1
        add x0,d1     
        move y0,d2
        asr #1,d2
        move #!moveto,d7
        trap #1
        move #120,d7 
        move #0,d6 
kreis01:
        move d7,-(a7)   

        move d6,d0 
        move #!cos,d7
        trap #1
        move d3,d1
        muls d0,d1
        asr.l #8,d1
        add x0,d1
        move d1,d4
        
        move d6,d0
        move #!sin,d7
        trap #1
        move d3,d2
        muls d0,d2
        asr.l #8,d2
        add y0,d2
        asr #1,d2    
        move d2,d5
 
        move #!drawto,d7
        trap #1
 
        move d4,d1
        move d5,d2
        move #!moveto,d7
        trap #1
 
        addq #3,d6
 
        move (a7)+,d7
        dbra.b d7,kreis01
 
        rts
 
 
 
calc:           ; L=d6, B=d5, X=d4, Y=d3
 
        sub dr,d6
calc01:        
        cmp #360,d6
        ble.b calc02   
        sub #360,d6
        bra.b calc01
calc02:
        cmp #0,d6  
        bgt.b calc03 
        add #360,d6
        bra.b calc02
calc03:
        move d6,d0
        move #!sin,d7
        trap #1  
        move d0,d4  
        move d5,d0
        move #!cos,d7   
        trap #1
        muls d0,d4
        asr.l #8,d4   
 
        move d6,d0
        move #!cos,d7
        trap #1
        move d0,d6
        move d5,d0
        move #!cos,d7
        trap #1 
        muls d0,d6
        asr.l #8,d6   
        
        move d5,d0
        move #!sin,d7
        trap #1
        move d0,d5
 
        move wi,d1
        move d5,d3
 
        move d1,d0
        move #!cos,d7 
        trap #1
        muls d0,d3        
        asr.l #8,d3   
 
        move d1,d0
        move #!sin,d7 
        trap #1
        muls d6,d0 
        asr.l #8,d0   
        
        sub d0,d3    

        move z,d2  
        move d2,za
 
        move d5,d2
        move d1,d0
        move #!sin,d7
        trap #1
        muls d0,d2
        asr.l #8,d2   
        
        move d1,d0
        move #!cos,d7
        trap #1
        muls d6,d0
        asr.l #8,d0   
        add d0,d2
        move d2,z
 
        move r,d1
        muls d1,d4
        asr.l #8,d4  
        muls d1,d3
        asr.l #8,d3  
 
        rts   
 
x0:     dc.w 256 
y0:     dc.w 256 
r:      dc.w 200  
 
dr:     dc.w 0
wi:     dc.w 0
 
x1:     dc.w 0
y1:     dc.w 0
 
x2:     dc.w 0
y2:     dc.w 0
 
z:      dc.w 0       
za:     dc.w 0        
 
escflag:        dc.w 0
 
puffer:
        ds.b 10
 
 
daten:
 
dc.w 32   ;  Anzahl Datenbl�cke - 1        
 
dc.w 31   ;       SUEDAMERIKA                   
dc.w  -70,12, -61,10, -56,6, -52,5, -50,0, -40, -4, -36, -6                     
dc.w  -35, -9, -39, -15, -41, -22, -48, -26, -49, -29                           
dc.w  -55, -35, -57, -35, -58, -39, -61, -39, -68, -47                          
dc.w  -66, -48, -70, -51, -63, -55, -70, -56, -75, -53                          
dc.w  -76, -49, -74, -37, -72, -30, -70, -18, -76, -14                          
dc.w  -81, -6, -80,0, -77,7, -75,11, -70,12                         
dc.w 56   ;      NORDEMERIKA                   
dc.w  -80,25, -81,25, -83,30, -95,30, -98,27, -98,22                         
dc.w  -95,19, -90,21, -87,21, -89,15, -84,15, -84,10                         
dc.w  -75,10, -85,10, -95,17, -105,20, -112,32, -117,32                         
dc.w  -110,23, -117,34, -120,34, -125,40, -125,48                       
dc.w  -130,54, -140,60, -150,60, -165,55, -158,58                       
dc.w  -165,62, -160,64, -166,64, -166,66, -160,66                       
dc.w  -166,68, -156,71, -135,69, -127,70, -110,68                       
dc.w  -81,70, -81,66, -95,62, -92,57, -83,55, -83,52                         
dc.w  -79,52, -79,55, -77,57, -78,63, -70,58, -65,60                         
dc.w  -56,52, -65,50, -62,45, -75,42, -76,36                       
dc.w  -81,32, -80,25                 
dc.w 3   ;      NEUFUNDLAND                   
dc.w  -53,47, -59,48, -56,52, -53,47                     
dc.w 2   ;      KUBA                   
dc.w  -85,22, -82,23, -75,21                   
dc.w 7   ;      BAFFIN                   
dc.w  -66,63, -77,65, -72,68, -89,70, -90,73, -79,73                         
dc.w  -62,66, -66,63                 
dc.w 4   ;      VICTORIA                   
dc.w  -101,70, -115,70, -120,73, -105,74, -101,70                       
dc.w 4   ;      ELLISMERE                   
dc.w  -80,76, -90,76, -95,82, -70,83, -80,76                       
dc.w 10   ;      GROENLAND                   
dc.w  -45,60, -50,62, -55,70, -60,76, -60,76, -70,78, -40,85                    
dc.w  -20,80, -22,70, -40,65, -45,60                     
dc.w 37   ;      AFRIKA                   
dc.w  -6,35,2,36,10,37,10,33,20,31,21,33,32,32               
dc.w 36,20,44,11,51,12,50,8,47,3,39, -4,41, -14                 
dc.w 35, -19,35, -24,33, -26,31, -30,26, -34,19, -34                         
dc.w 17, -28,15, -23,12, -18,14, -11,13, -5,9, -1,10,4                         
dc.w 6,4,4,6, -2,5, -8,5, -12,8, -17,15, -16,21, -12,28                         
dc.w  -10,30, -9,32, -6,35                   
dc.w 11  ;      MADAGASKAR                   
dc.w 49,-12,51,-16,50,-16,50,-17,47,-25       
dc.w 44,-25,43,-22,44,-20,44,-17,47,-16,49,-13
dc.w 49,-12
dc.w 117   ;      EURASIEN                   
dc.w 76,8,72,21,70,20,66,25,55,26,50,30,48,28             
dc.w 52,24,56,26,60,22,57,19,52,16,44,12,41,20              
dc.w 33,32,34,32,36,37,27,36,27,42,42,42,38,47             
dc.w 30,46,29,42,22,40,25,38,22,36,20,40,20,42             
dc.w 13,46,12,44,17,40,15,37,12,38,17,39,10,44             
dc.w 7,43,3,43,3,41,0,40,0,38, -2,37, -6,36, -7,37                   
dc.w  -9,37, -9,43,2,43, -2,46, -4,48,9,54,8,57                     
dc.w 10,58,14,54,21,55,25,66,21,65,18,62,16,56             
dc.w 12,55,10,60,5,57,5,63,20,70,25,71,43,67             
dc.w 65,70,70,73,80,72,80,74,105,78,112,76,113,74             
dc.w 130,73,130,71,150,72,160,70,175,70,170,66              
dc.w 180,65,180,63,170,60,162,60,162,56,157,52             
dc.w 156,58,160,60,157,62,155,59,141,59,136,55             
dc.w 141,54,140,47,134,43,128,39,129,35,126,35             
dc.w 125,40,118,39,121,31,120,26,116,23,109,21             
dc.w 105,19,109,16,109,11,105,10,100,14,100,8             
dc.w 104,2,100,4,98,8,97,17,94,16,94,20,92,22             
dc.w 88,22,80,16,80,10,76,8             
dc.w 22  ;      GROSSBRITANNIEN                   
dc.w  -5,59,-3,59,-4,58,-2,58,-3,56,-2,56,0,54,0,53
dc.w  2,53,2,52,1,51,2,51,-6,50,-4,51,-3,51,-5,52 
dc.w  -4,53,-3,54,-5,55,-5,56,-6,56,-6,57,-5,59
dc.w 10  ;      IRLAND                   
dc.w  -8,55,-6,55,-6,52,-8,52,-10,51,-10,52
dc.w -9,53,-10,53,-10,54,-8,54,-8,55
dc.w 12  ;      ISLAND                   
dc.w  -23,64,-22,65,-24,65,-22,66,-24,66,-23,67
dc.w  -21,65,-20,66,-17,66,-16,67,-14,65,-19,63
dc.w  -23,64
dc.w 23   ;    JAPAN                   
dc.w 142,45,141,43,140,43,140,39,137,37,137,38             
dc.w 136,36,132,35,130,33,131,31,132,33,131,34             
dc.w 133,34,132,33,134,33,135,35,136,33,137,35             
dc.w 140,35,142,40,141,42,143,42,145,43,142,45             
dc.w 4   ;     TAIWAN                   
dc.w 121,22,122,25,121,25,120,23,121,22             
dc.w 3   ;      SRI LANKA                   
dc.w 80,10,82,8,80,7,80,10             
dc.w 50   ;      AUSTRALIEN                   
dc.w 115,-34,116,-34,116,-31,115,-30,115,-29
dc.w 112,-26,114,-27,113,-24,114,-22,120,-20
dc.w 122,-18,123,-16,123,-18,124,-16,127,-14
dc.w 130,-15,131,-11,133,-11,133,-12,137,-12
dc.w 136,-15,140,-18,142,-15,142,-10,143,-10
dc.w 144,-14,145,-14,146,-19,153,-26
dc.w 153,-28,150,-38,148,-38,146,-39,145,-38
dc.w 144,-39,140,-38,139,-36,136,-36,138,-35
dc.w 138,-34,137,-35,138,-33,136,-35,133,-32
dc.w 130,-32,124,-33,123,-34,120,-34,118,-35
dc.w 117,-35,115,-34
dc.w 4    ;    Tasmanien 
dc.w 145,-41,148,-41,148,-43,146,-43,145,-41 
dc.w 21   ;    NEUSEELAND                   
dc.w 173, -34,175, -37,174, -39,175, -40,175, -41                       
dc.w 173, -41,173, -40,171, -43,166, -46,169, -47                       
dc.w 171, -46,172, -44,173, -44,173, -43,174, -42                       
dc.w 174, -41,176, -41,178, -39,179, -37,177, -38                        
dc.w 174, -35,173, -34                 
dc.w 28   ;      NEUGUINEA                   
dc.w 151,-11,150,-10,150,-9,149,-9,149,-8,148,-8,146,-7
dc.w 147,-7,145,-6,145,-5,138,-2,136,-4,134,-1
dc.w 131,-1,132,-2,134,-2,132,-3,133,-4,134,-3
dc.w 137,-5,139,-7,137,-8,140,-8,141,-9 
dc.w 143,-9,144,-8,145,-8,148,-10,151,-11
dc.w 12    ;   Luzon 
dc.w 121,19,122,19,122,17,121,15,125,13,126,11,125,11
dc.w 125,10,124,13,122,14,121,14,120,16,121,19
dc.w 9    ;    Mindanao
dc.w 126,10,127,7,126,6,126,7,125,5,124,7,122,7
dc.w 123,9,125,9,126,10
dc.w 5    ;    Negros
dc.w 122,12,124,11,125,10,123,9,122,10,122,12
dc.w 8    ;    Palawan
dc.w 117,8,120,12,121,12,120,14,122,13,121,12
dc.w 120,12,120,10,117,8 
dc.w 9    ;    Halmahera
dc.w 128,3,129,3,128,1,129,2,129,0,128,0,128,-2
dc.w 127,-2,127,0,128,3 
dc.w 7    ;    Seram
dc.w 126,-3,127,-3,128,-4,128,-3,131,-3,131,-4,127,-4,126,-3
dc.w 18   ;    BORNEO                   
dc.w 115, -4,116, -3,118,1,119,1,118,2,117,3,119,5                 
dc.w 117,7,113,3,111,3,111,2,109,2,109,0,110, -1               
dc.w 110, -3,112, -3,112, -4,113, -3,115, -4                       
dc.w 18   ;    SULAWESI (CELEBES)                   
dc.w 125,2,124,1,121,1,120,0,119, -3,120, -4,119, -6                   
dc.w 120, -6,120, -3,121, -3,121, -4,122, -5,123, -4,121, -2                    
dc.w 123, -1,120, -1,120,0,124,0,125,2                 
dc.w 12  ;      SUMATRA                   
dc.w 95,6,98,5,100,3,102,2,104,0,103,-1,104,-1
dc.w 105,-2,106,-2,106,-6,104,-6,95,5,95,6
dc.w 8    ;    JAVA      
dc.w 106,-6,111,-7,111,-6,114,-7,113,-8,114,-8
dc.w 115,-9,105,-7,106,-6
dc.w 8    ;  Kl. Sunda Inseln                  
dc.w 114,-8,128,-8,123,-11,125,-9,120,-9,121,-10
dc.w 118,-9,116,-9,114,-8
dc.w 34   ;      ANTARKTIKA                   
dc.w  -180, -89, -180, -85, -155, -86, -159, -77, -122, -72                     
dc.w  -100, -74, -100, -72, -75, -73, -70, -66, -55, -63                        
dc.w  -65, -68, -60, -73, -70, -80, -35, -80, -35, -77, -20, -73                
dc.w 0, -70,20, -70,40, -69,53, -66,70, -67,70, -70                         
dc.w 80, -68,85, -66,100, -66,115, -65,120, -66,135, -65                        
dc.w 150, -68,166, -70,170, -72,162, -75,160, -82                       
dc.w 180, -85,180, -89                  
 
end