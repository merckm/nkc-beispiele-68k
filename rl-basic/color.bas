 10 REM Color-Test
 20 GRMODE 1
 30 CLPG
 40 i = 0
 50 FOR y = 0 TO 480 STEP 32
 60    FOR x = 0 TO 480 STEP 32
 70        COLOR = i
 80        i = i + 1
 90        x1 = x + 31
100        y1 = y + 31
110        CONNECT (x,y) - (x1,y) - (x1,y1) - (x,y1) - (x,y)
120        x2 = x + 8
130        y2 = y + 8
140        PAINT (x2,y2),i-1
150    NEXT
160 NEXT 
170 END