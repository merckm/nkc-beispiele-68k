    10 PAGE 3,3: CLPG 
    20 DIM oldlin%(50,4)
    30 RANDOMIZE 511
    40 x0% =  RND :x1% =  RND :y0% =  RND :y1% =  RND 
    50 dx% = 3:dy% = 7:dx1% = 5:dy1% = 3
    60 REPEAT 
    70   k% = (k% + 1) MOD 50
    80   COLOR  = 0
    90   LINE (oldlin%(k%,0),oldlin%(k%,1)) - (oldlin%(k%,2),oldlin%(k%,3))
   100   COLOR  = c%:c% = c% + 1
   110   LINE (x0%,y0%) - (x1%,y1%)
   120   oldlin%(k%,0) = x0%
   130   oldlin%(k%,1) = y0%
   140   oldlin%(k%,2) = x1%
   150   oldlin%(k%,3) = y1%
   160   x0% = x0% + dx%
   170   y0% = y0% + dy%
   180   IF x0% < 10 OR x0% > 500 THEN dx% =  - dx%
   190   IF y0% < 10 OR y0% > 500 THEN dy% =  - dy%
   200   x1% = x1% + dx1%
   210   y1% = y1% + dy1%
   220   IF x1% < 10 OR x1% > 500 THEN dx1% =  - dx1%
   230   IF y1% < 10 OR y1% > 500 THEN dy1% =  - dy1%
   240 UNTIL  FALSE 
