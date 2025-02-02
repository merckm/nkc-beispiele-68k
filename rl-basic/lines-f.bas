    10 REM  Liniendemo 
    20 REM  
    30 REM  
    40 PAGE 3,3: CLPG 
    50 RANDOMIZE 512
    60 REPEAT 
    70   x% =  RND 
    80   x1% =  RND 
    90 UNTIL x1% >  = 2 AND x1% <  = 501 AND x% >  = 5 AND x% <  = 502
   100 REPEAT 
   110   y% =  RND 
   120   y1% =  RND 
   130 UNTIL y1% >  = 2 AND y1% <  = 501 AND y% >  = 5 AND y% <  = 502
   140 c% = 1
   150 t% = 5:t1% = 2
   160 s% = 2:s1% = 5
   170 REPEAT 
   180   GOSUB zeichnen!
   190   x% = x% + t%: IF x% > 502 OR x% < 5 THEN t% =  - t%
   200   y% = y% + s%: IF y% > 502 OR y% < 5 THEN s% =  - s%
   210   x1% = x1% + t1%: IF x1% > 502 OR x1% < 5 THEN t1% =  - t1%
   220   y1% = y1% + s1%: IF y1% > 502 OR y1% < 5 THEN s1% =  - s1%
   230   k% = k% + 1
   240   IF k% > 500 THEN 
   250     k% = 0
   260     CLPG 
   270   END  IF 
   290 UNTIL  FALSE 
   300 REM
   310 REM Unterprogramm Zeichnen : Hier z.b. Kreis, Dreieck , Linie o.ae.
   320 zeichnen!
   330 CONNECT (x%,y%) - (x1%,y1%)
   340 RETURN 
   350 REM Unterprogramm zur Auswahl der naechsten Zeichenfarbe
   360 REM Auswahl erfolgt so, dass COL256 Karte mit Farbausgabe schoene
   370 REM Ergebnisse liefert.
   375 REM Fuer GDP64K kann z.b. nur COLOR = 1 eingtragen werden.
   380 n_col!
   390 c% = c% + 65
   400 COLOR  = c%
   410 RETURN 
