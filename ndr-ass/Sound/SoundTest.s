START:
    LEA TAB,A0
    JSR @SOUND
    RTS
 
TAB:
    DC.B $DE,1,$DD,1,$BE,0
    DC.B 0,$F8,$10,$10,$10,0,$a,8,0,0