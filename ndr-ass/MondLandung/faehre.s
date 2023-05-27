* Vereinbarungsbaustein

faehre:
 dc.b 1,2,2,0,0,0,6,6,7,3,4,4,4,10
 ds 0

# Programmbaustein

start:
 lea faehre,a0  # Adresse der Faehre
 move #3,d0     # Groesse der Faehre
 move #100,d1   # X-Koordinate
 move #180,d2   # Y-Koordinate
 jsr @figur     # und ausfuehren
 rts
