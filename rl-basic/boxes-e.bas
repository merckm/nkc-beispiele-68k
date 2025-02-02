    10 REM  Liniendemo 
    20 REM  
    30 REM  
    40 PAGE 3,3: CLPG 
    50 RANDOMIZE 512
    60 x =  RND :x1 =  RND 
    70 y =  RND :y1 =  RND 
    75 c =  RND 
    80 t = 5:t1 = 2
    90 s = 5:s1 = 2
    95 weiter!
   100 GOSUB zeichnen!
   110 x = x + t: IF x > 502 OR x < 5 THEN t =  - t
   120 y = y + s: IF y > 502 OR y < 5 THEN s =  - s
   130 x1 = x1 + t1: IF x1 > 502 OR x1 < 2 THEN t1 =  - t1
   140 y1 = y1 + s1: IF y1 > 502 OR y1 < 2 THEN s1 =  - s1
   150 k = k + 1
   160 IF k > 500 THEN k = 0: CLPG 
   170 GOSUB ncol!: GOTO weiter!
   200 zeichnen!
   210 CONNECT (x,y) - (x1,y) - (x1,y1) - (x,y1) - (x,y)
   220 RETURN 
   300 ncol!
   305 c = c + 64
   310 IF c > 255 THEN c = c - 254
   320 COLOR  = c
   400 RETURN 
