     1 RANDOMIZE 1000
    10 PRINT  TAB( 20);"Vier in einer Reihe"
    20 PRINT  TAB( 20);"Creative Computing"
    30 PRINT  TAB( 25);"Berny (C)"
    40 PRINT : PRINT : PRINT 
   100 DIM b$(8,8),l(8),s(4),f(4)
   110 DIM v(16),n(4)
   130 DATA 1,100,500,1.0000000E+020,1,800,4000,1.0000000E+020
   140 DATA 1,75,900,1.0000000E+018,1,450,3000,1.0000000E+018
   150 FOR z1 = 1 TO 16: READ v(z1): NEXT z1
   160 PRINT "Das Vier in einer Reihe Spiel"
   170 INPUT "Moechtest du Anweisungen?";a$
   180 IF a$ = "n" OR a$ = "N" THEN  GOTO 270
   190 IF a$ = "j" OR a$ = "J" THEN  GOTO 210
   200 PRINT "J(j) oder N(n)": GOTO 170
   210 PRINT "Das Spiel besteht darin, X und O so aufzustapeln,"
   220 PRINT "(Computer hat die O), bis einer der Spieler Vier"
   230 PRINT "in einer Reihe , entweder Vertikal, Horizontal oder"
   240 PRINT "Diagonal, bekommt"
   250 PRINT : PRINT 
   260 REM
   270 x$ = "X":o$ = "O"
   280 FOR i = 1 TO 8: FOR j = 1 TO 8:b$(i,j) = "-": NEXT j: NEXT i
   290 FOR z1 = 1 TO 8:l(z1) = 0: NEXT z1
   300 INPUT "Moechtest du zuerst ziehen:";a$
   310 IF a$ = "n" OR a$ = "N" THEN  GOTO 610
   320 GOSUB 340
   330 GOTO 450
   340 FOR i = 8 TO 1 STEP  - 1
   350   FOR j = 1 TO 8
   360     PRINT "  ";b$(i,j);
   370   NEXT j
   380   PRINT 
   390 NEXT i
   400 PRINT "  ";
   410 FOR i = 1 TO 8: PRINT i;: PRINT "  ";: NEXT i
   420 PRINT : PRINT 
   430 RETURN 
   440 PRINT "Ungueltiger Zug, nochmal!"
   450 INPUT "Eine Zahl zwischen 1 und 8:";m
   460 m =  INT (m)
   470 IF m < 1 OR m > 8 THEN  GOTO 440
   480 l = l(m)
   490 IF l > 7 THEN  GOTO 440
   500 l(m) = l + 1:l = l + 1
   510 b$(l,m) = x$
   520 PRINT 
   530 GOSUB 340
   540 p$ = x$
   550 GOSUB 1240
   560 FOR z = 1 TO 4
   570   IF s(z) < 4 THEN  GOTO 600
   580   PRINT "D u  G e w i n n s t ! ! !"
   590   GOTO 1580
   600 NEXT z
   610 m9 = 0:v1 = 0
   620 n1 = 1
   630 FOR m4 = 1 TO 8
   640   l = l(m) + 1
   650   IF l > 8 THEN  GOTO 1080
   660   v = 1
   670   p$ = o$:w = 0
   680   m = m4
   690   GOSUB 1240
   700   FOR z1 = 1 TO 4:n(z1) = 0: NEXT z1
   710   FOR z = 1 TO 4
   720     s = s(z)
   730     IF s - w > 3 THEN  GOTO 1130
   740     t = s + f(z)
   750     IF t < 4 THEN  GOTO 780
   760     v = v + 4
   770     n(s) = n(s) + 1
   780   NEXT z
   790   FOR i = 1 TO 4
   800     n = n(i) - 1
   810     IF n =  - 1 THEN  GOTO 880
   820     i1 = 8 * w + 4 *  SGN (n) + i
   830     v = v + v(i1) + n * v(8 * w + i)
   840   NEXT i
   850   IF w = 1 THEN  GOTO 880
   860   w = 1:p$ = x$
   870   GOTO 690
   880   l = l + 1
   920   IF l > 8 THEN  GOTO 1020
   930   GOSUB 1240
   940   FOR z = 1 TO 4
   950     IF s(z) > 3 THEN v = 2
   960   NEXT z
  1020   IF v < v1 THEN  GOTO 1080
  1030   IF v > v1 THEN n1 = 1: GOTO 1060
  1040   n1 = n1 + 1
  1050   IF  RND  / 1000 > 1 / n1 THEN  GOTO 1080
  1060   v1 = v
  1070   m9 = m4
  1080 NEXT m4
  1090 IF m9 <  > 0 THEN  GOTO 1120
  1100 PRINT "U N E N T S C H I E D E N ! !"
  1110 GOTO 1580
  1120 m = m9
  1130 PRINT "Der Computer waehlt Spalte ";m: PRINT 
  1140 l = l(m) + 1:l(m) = l(m) + 1
  1150 b$(l,m) = o$
  1160 p$ = o$: GOSUB 340
  1170 GOSUB 1240
  1180 FOR z = 1 TO 4
  1190   IF s(z) < 4 THEN  GOTO 1220
  1200   PRINT "C O M P U T E R  G E W I N N T ! ! !"
  1210   GOTO 1580
  1220 NEXT z
  1230 GOTO 450
  1240 q$ = x$
  1250 IF p$ = x$ THEN q$ = o$
  1260 d2 = 1:d1 = 0
  1270 z = 0
  1280 GOSUB 1360
  1290 d2 = 1:d1 = 1
  1300 GOSUB 1360
  1310 d2 = 0:d1 = 1
  1320 GOSUB 1360
  1330 d2 = 1:d1 = 1
  1340 GOSUB 1360
  1350 RETURN 
  1360 d = 1:s = 1
  1370 t = 0
  1380 z = z + 1
  1390 c = 0
  1400 FOR k = 1 TO 3
  1410   m5 = m + k * d1:l1 = l + k * d2
  1420   IF m5 < 1 OR l1 < 1 OR m5 > 8 OR l1 > 8 THEN  GOTO 1510
  1430   b$ = b$(l1,m5)
  1440   IF c = 0 THEN  GOTO 1480
  1450   IF b$ = q$ THEN k = 3: GOTO 1510
  1460   t = t + 1
  1470   GOTO 1510
  1480   IF b$ = p$ THEN s = s + 1: GOTO 1510
  1490   c = 1
  1500   GOTO 1450
  1510 NEXT k
  1520 IF d = 0 THEN  GOTO 1550
  1530 d = 0:d1 =  - 1:d2 =  - d2
  1540 GOTO 1390
  1550 s(z) = s
  1560 f(z) = t
  1570 RETURN 
  1580 END 
