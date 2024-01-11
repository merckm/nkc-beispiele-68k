;******************************** 
; Mondlandeprogramm Version 1.0 ;
; vom 13.12.1983                ;
;********************************    
 
; ***** Interrupt-Baustein *****
 
 org $E800C ; Feste Adresse                    
 
 jmp intaus ; dorthin Sprung   
 
 org $a000
 
; ***** Vereinbarungs-Baustein *****
 
tasten equ $ffffff30         
rechts equ 1   ; Bit Masken                   
links  equ 2                    
rauf   equ 4         
runter equ 8         
 
erfolgtext:
 dc.b 'Gut gelandet',0
 
bruchtext:
 dc.b 'Bruchlandung',0
 
faehre:
 dc.b 8,2,9,0,0,7,3,2,2,4,4,4,4
 dc.b 6,6,5,1,0,0,10
 
 ds 0 ; Angleich auf Wortgrenze
 
; Variablenvereinbarungen
 
x: dc.w  0 
y: dc.w  0
dx: dc.w  0
dy: dc.w  0
treibst: dc.w  0
 
timerms: dc.l 0   
timer10tel: dc.w  0 
buffer: ds 50
 
; ***** Unterprogramm-Baustein *****     
 
intaus:
 movem.l d3,-(a7)   
 move.l timerms,d3
 add.l #20,d3
 move.l d3,timerms
 divu #100,d3 ;  umrechnen in 10tel sec 
 move.w  d3,timer10tel
 movem.l (a7)+,d3 
 rte
 
 
zeitaus:
 lea buffer,a0
 move.w  timer10tel,d0
 jsr @print4d
 lea buffer,a0
 move #$22,d0
 move #0,d1
 move #220,d2
 jsr @write
 rts
 
 
 
mondflaeche: 
 move #0,d1       
 move #0,d2        
 move #90,d3       
 jsr @set       ;Setze Schildkroete
 jsr @hide      ;aber nicht zeigen
 move #50-1,d4     ;Anzahl Krater                
mlp1:
 jsr krater 
 dbra d4,mlp1       
 rts       
 
krater:
 move  #-45,d0
 jsr @drehe
 move #10,d0  
 jsr @schreite
 move #-45,d0
 jsr @drehe
 move #6,d0
 jsr @schreite
 move #-45,d0
 jsr @drehe
 move #10,d0 
 jsr @schreite
 move #-45-180,d0
 jsr @drehe
 rts       
 
; ***** Programm-Baustein *****
 
start:
 bsr mondflaeche       
 move #100,x        
 move #200,y       
 move #3,dx       
 move #0,dy       
 move #300,treibst       
 clr.l timerms          ; Initialisieren   
 clr timer10tel
wdh1:
 bsr zeitaus
 movea.l #faehre,a0 
 move #$3,d0             ; Vergroesserung=3       
 move x,d1       
 move y,d2       
 jsr @figur
 tst treibst       
 ble notest              ; Kein Treibstoff ?                    
 move.b tasten,d0                
 and.b #rechts,d0        
 bne.s tst1       
 addq #3,dx       
 bra.s notest       
 
tst1: 
 move.b tasten,d0
 and.b #links,d0       
 bne tst2       
 subq #3,dx         
 bra.s notest       
 
tst2:
 move.b tasten,d0 
 and.b #rauf,d0       
 bne.s tst3       
 addq #3,dy       
 bra.s notest       
 
tst3:
 move.b tasten,d0 
 and.b #runter,d0       
 bne.s notest       
 subq #3,dy       
 
notest:
 subq #1,dy              ;Gravitation       
 move dx,d3              ; x:=x+dx       
 add d3,x             
 move dy,d3              ; y:=y+dy       
 add d3,y        
 subq #1,treibst         ; Treibstoff veringern       
 
 move #5-1,d1           ; Warteschleife  
warte20ms: 
 move #!sync,d7                 
 trap #1       
 beq warte20ms       
 dbra d1,warte20ms               
 
 cmp #5,y                ; Hoehe der Oberflaeche ueber 0           
 bgt wdh1                ; beruecksichtigen       
                         ;       
 move #$3,d0             ; Faehre am Schluss nochmals zeigen       
 move x,d1       
 move y,d2        
 jsr @figur              ; Figur aufrufen
 move dx,d0
 bpl.s ff1    
 neg d0 
ff1:                    ; !dx! < 2       
 cmp #2,d0
 bge.s bruch       
 move dy,d0 
 bpl.s ff2
 neg d0 
ff2:                    ; !dy! < 4
 cmp #4,d0
 bge.s bruch       
 lea erfolgtext,a0                          
 bra.s ende       
 
bruch:
 lea bruchtext,a0              
ende:  
 move #$33,d0           ; Schriftgroesse     
 move #0,d1             ; x-Position  
 move #130,d2           ; y-Position
 jsr @write
 bsr zeitaus            ; letzter Stand 
 jsr @ci                ; warten auf Taste 
 jsr @clr               ; Loeschen      
 bra start              ; unbegrenzt
 
; ***********
 
end
 