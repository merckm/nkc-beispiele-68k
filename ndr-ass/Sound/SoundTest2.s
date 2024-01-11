START:
    LEA TABELLE(PC),A0
    MOVEQ #!SOUND,D7
    TRAP #1
    
    RTS
 
TABELLE:
    DC.B $DE,1,$DD,1,$BE,0
    DC.B 0,$F8,$10,$10,$10,0,$a,8,0,0