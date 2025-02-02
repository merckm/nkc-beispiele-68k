    10 REM  Graphik Demonstration    
    20 REM  Fuellen von Zufaellig gezeichneten Flaechen 
    25 REM  Nur mit COL256 richtig  funktionstuechtig
    30 RANDOMIZE 511
    32 max = 30
    33 FOR m = 0 TO 1
    35   GRMODE m: CLPG 
    36 NEXT 
    37 REPEAT 
    38   COL% = RND
    40   COLOR  =  COL% 
    50   i% = RND  MOD 4
    60   x =  RND 
    70   y =  RND 
    80   x1 =  RND 
    90   y1 =  RND 
   100   ON i% GOSUB box!,triangle!,kreis!
   105   k = k + 1
   110 UNTIL k >  = max
   120 REPEAT : UNTIL  INKEY$  <  > ""
   125 RUN 
   130 box!
   135 FOR m = 0 TO 1
   138   GRMODE m
   140   CONNECT (x,y) - (x1,y) - (x1,y1) - (x,y1) - (x,y)
   141   IF x1 > x THEN x2 = x+(x1-x)/2 ELSE x2 = x+(x-x1)/2
   142   IF y1 > y THEN y2 = y+(y1-y)/2 ELSE y2 = y+(y-y1)/2
   144   PAINT (x2,y2), COL% 
   145 NEXT 
   150 RETURN 
   160 triangle!
   162 FOR m = 0 TO 1
   163   GRMODE m
   165   x2 = (x + x1) / 2:y2 = y / 2
   166   x4 = (x+x1+x2)/3:y4 = (y+y1+y2)/3
   170   CONNECT (x,y) - (x1,y1) - (x2,y2) - (x,y)
   171   PAINT (x4,y4),  COL% 
   172 NEXT 
   175 REM PAINT (X2,Y2), RND 
   180 RETURN 
   190 kreis!
   195 FOR m = 0 TO 1
   196   GRMODE m
   200   CIRCLE (x,y),x1 / 2
   210   PAINT (X,Y),  COL%  
   215 NEXT 
   220 RETURN 
