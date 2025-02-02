   100 k1 = 3.1415 / 180
   101 o9 = 0
   102 q1 = 3
   104 q2 = 3
   106 d = 100000
   108 p1 = 100
   110 p2 = 100
   112 i1 = 100
   114 i2 = 100
   116 s1 = 100
   118 s2 = 100
   119 RANDOMIZE 180
   120 a1 =  RND  - 90
   122 a2 = a1 - 180
   123 IF a2 <  - 180 THEN  LET a2 = a2 + 360
   124 l1 = 100
   126 l2 = 100
   128 w1 = 100
   130 w2 = 100
   132 a3 = 0
   134 a4 = 0
   136 a = 0
   138 q = 0
   140 h1 = 0
   142 h2 = 0
   150 CLS 
   152 PRINT " S T A R - T R E C K "
   154 PRINT 
   156 PRINT "Die Klingonen greifen an. Geben Sie die richtigen Befehle !"
   157 PRINT "Die Entfernung der Raumschiffe wird immer neu angezeigt, "
   158 PRINT "die uebrigen Werte nur, wenn ein neuer Lagebericht "
   159 PRINT "verlangt wird. "
   160 PRINT "SCHUSSWINKEL = Winkel der Klingonen - Winkel der Enterprise"
   161 PRINT 
   162 PRINT "1  Phaser-Kanone "
   163 PRINT 
   164 PRINT "2  Photonen Torpedos "
   165 PRINT 
   166 PRINT "3  Neuer Lagebericht "
   170 PRINT 
   172 PRINT "4  Kurskorrektur"
   174 PRINT 
   175 PRINT "5  Selbstzerstoerung"
   176 LOCATE 0,21: PRINT "> Ihr erster Befehl ?"
   177 INPUT o9
   178 CLS 
   179 GOTO 187
   180 GOSUB 470
   181 LOCATE 0,21: PRINT "> Ihr neuer Befehl ?  "
   182 INPUT o9
   183 FOR z = 10 TO 22
   184   LOCATE 0,z: PRINT "                                                                               "
   185 NEXT z
   186 LOCATE 3,0: PRINT "       "
   187 LOCATE 0,11: PRINT 
   190 IF o9 = 5 THEN  GOTO 600
   194 IF o9 = 4 THEN  GOTO 570
   196 IF o9 = 3 THEN  GOTO 620
   198 IF o9 = 2 THEN  GOTO 310
   199 IF o9 = 1 THEN  GOTO 220
   200 GOTO 180
   220 IF w1 <  = 0 THEN  GOTO 180
   221 GOSUB 1060
   222 LOCATE 0,11: PRINT 
   223 IF  ABS (a - (a2 - a1)) > 10 THEN  GOTO 360
   224 IF d > 150000 THEN  GOTO 420
   230 RANDOMIZE 3
   231 c =  RND 
   232 h1 = 2 *  INT ((150000 - d) / 30000)
   233 IF c = 0 THEN  GOTO 250
   234 IF c = 1 THEN  GOTO 260
   235 IF c = 2 THEN  GOTO 270
   250 PRINT "Phaser-Volltreffer "
   252 GOTO 620
   260 PRINT "Checkov meldet einen Phaser-Volltreffer."
   262 GOTO 620
   270 RANDOMIZE 3
   271 c =  RND 
   272 IF c = 0 THEN  GOTO 280
   273 IF c = 1 THEN  GOTO 290
   274 IF c = 2 THEN  GOTO 300
   280 PRINT "Mr.Sulu meldet Volltreffer."
   282 GOTO 620
   290 PRINT "*** Volltreffer ***"
   292 GOTO 620
   300 PRINT "Mr.Spock meldet einen Treffer am Raumschiff der Klingonen."
   302 GOTO 620
   310 GOSUB 1060
   311 IF w1 <  = 0 THEN  GOTO 180
   312 LOCATE 0,11: PRINT 
   313 IF  ABS (a - (a2 - a1)) > 25 THEN  GOTO 440
   314 IF d > 300000 THEN  GOTO 430
   320 RANDOMIZE 3
   321 c =  RND 
   322 h1 =  INT ((300000 - d) / 50000)
   330 IF c = 2 THEN  GOTO 270
   332 IF c = 0 THEN  GOTO 340
   333 IF c = 1 THEN  GOTO 350
   340 PRINT "Volltreffer der Photonentorpedos."
   342 GOTO 620
   350 PRINT "Sulu meldet einen Volltreffer der Photonentorpedos"
   352 GOTO 620
   360 RANDOMIZE 2
   361 c =  RND 
   362 h1 = 0
   363 IF c = 0 THEN  GOTO 370
   364 IF c = 1 THEN  GOTO 380
   370 PRINT "Checkov meldet:Sauber daneben. "
   372 GOTO 620
   380 RANDOMIZE 3
   381 c =  RND 
   382 IF c = 0 THEN  GOTO 390
   383 IF c = 1 THEN  GOTO 400
   384 IF c = 2 THEN  GOTO 410
   390 PRINT "Zu weit."
   392 GOTO 620
   400 PRINT "Spock meldet:Knapp daneben ist auch vorbei."
   402 GOTO 620
   410 PRINT "Sulu meldet einen Fehlschuss."
   412 GOTO 620
   420 PRINT "Sie sind ausserhalb der Reichweite der Phaserkanonen."
   422 GOTO 620
   430 PRINT "Sie sind ausserhalb der Reichweite der Photonentorpedos."
   432 GOTO 620
   440 RANDOMIZE 3
   441 c =  RND 
   442 h1 = 0
   444 IF c = 1 THEN  GOTO 450
   446 GOTO 380
   450 PRINT "Checkov meldet einen Fehlschuss der Photonentorpedos."
   452 GOTO 620
   470 LOCATE 17,0: PRINT "ENTERPRISE"; TAB( 22);"KLINGONEN"
   472 IF o9 <  > 3 THEN  GOTO 560
   475 LOCATE 3,0: PRINT "> NEU <"
   480 PRINT "Geschw.:"; TAB( 21);q1;"   "; TAB( 40);"   ";q2;"   "
   490 PRINT "Winkel :"; TAB( 21);a1;"   "; TAB( 40);"   ";a2;"   "
   500 PRINT "Wendung :"; TAB( 21);a3;"   "; TAB( 40);"   ";a4;"   "
   505 IF l1 < 0 THEN  LET l1 = 0
   506 IF l2 < 0 THEN  LET l2 = 0
   510 PRINT "Lebenserh.:"; TAB( 21);l1;"   "; TAB( 40);"   ";l2;"   "
   515 IF p1 < 0 THEN  LET p1 = 0
   516 IF p2 < 0 THEN  LET p2 = 0
   520 PRINT "Antrieb :"; TAB( 21);p1;"   "; TAB( 40);"   ";p2;"   "
   525 IF i1 < 0 THEN  LET i1 = 0
   526 IF i2 < 0 THEN  LET i2 = 0
   530 PRINT "Impuls :"; TAB( 21);i1;"   "; TAB( 40);"   ";i2;"   "
   540 PRINT "Schirme :"; TAB( 21);s1;"   "; TAB( 40);"   ";s2;"   "
   544 IF w1 < 0 THEN  LET w1 = 0
   545 IF w2 < 0 THEN  LET w2 = 0
   550 PRINT "Waffen :"; TAB( 21);w1;"   "; TAB( 43);w2;"       "
   560 LOCATE 0,9: PRINT "* Entfernung ";d;" km  *                       "
   563 RETURN 
   564 GOTO 620
   570 LOCATE 0,20: PRINT "Um wieviel Grad wollen Sie die Enterprise drehen?"
   572 INPUT a3
   574 IF i1 < a3 THEN  GOTO 572
   580 LOCATE 0,20: PRINT "Auf wieviel Warp wollen sie beschleunigen?       "
   582 INPUT q1
   583 LOCATE 0,21: PRINT "                 "
   590 IF q1 >  INT (p1 / 10) THEN  GOTO 582
   591 LOCATE 0,20: PRINT "                                                  "
   592 LOCATE 0,11: PRINT 
   595 GOTO 620
   600 CLS 
   601 IF d < 50000 THEN  GOTO 610
   602 PRINT "Die Klingonen sind zu weit weg."
   605 GOTO 990
   610 PRINT "Die Klingonen sind vernichtet, die Enterprise auch !"
   612 GOTO 1100
   620 RANDOMIZE 4
   621 c =  RND 
   624 IF w2 > 0 AND c = 0 THEN  GOTO 640
   626 IF w2 > 0 AND c = 1 THEN  GOTO 740
   628 IF i2 > 0 AND c = 2 THEN  GOTO 780
   629 IF c = 3 THEN  GOTO 800
   630 GOTO 620
   640 PRINT "A L A R M "
   645 PRINT "Phaser-Feuer der Klingonen."
   650 IF d > 150000 THEN  GOTO 710
   652 RANDOMIZE 10
   653 IF  RND  > 6 THEN  GOTO 710
   660 RANDOMIZE 100
   661 c =  RND 
   662 IF c > w2 THEN  GOTO 710
   664 h2 =  INT (2 * (150000 - d) / 30000)
   670 RANDOMIZE 3
   671 c =  RND 
   672 IF c = 0 THEN  GOTO 680
   673 IF c = 1 THEN  GOTO 690
   674 IF c = 2 THEN  GOTO 700
   680 PRINT "** Volltreffer **"
   682 GOTO 820
   690 PRINT "Spock meldet die Feststellung eines Volltreffers."
   692 GOTO 820
   700 PRINT "Sulu meldet, dass die Enterprise getroffen wurde."
   702 GOTO 820
   710 RANDOMIZE 3
   711 c =  RND 
   712 h2 = 0
   713 IF  RND  = 1 THEN  GOTO 720
   714 IF  RND  = 2 THEN  GOTO 730
   720 PRINT "Checkov meldet einen Fehlschuss."
   722 GOTO 820
   730 PRINT "Die Sensoren zeigen keine Treffer."
   732 GOTO 820
   740 PRINT "A L A R M "
   741 PRINT "Photonentorpedo-Angriff"
   750 IF d > 300000 THEN  GOTO 710
   752 RANDOMIZE 100
   753 IF  RND  > 85 THEN  GOTO 710
   760 RANDOMIZE 100
   761 c =  RND 
   762 IF c > w2 THEN  GOTO 710
   764 h2 =  INT ((300000 - d) / 50000)
   770 GOTO 670
   780 RANDOMIZE 10
   781 a4 =  INT ((p2 / 2) * ( RND  / 10) - p2 / 4)
   782 RANDOMIZE 10
   783 q2 =  INT (p2 / 10) * ( RND  / 10)
   790 PRINT "Checkov meldet eine Kursaenderung der Klingonen."
   792 GOTO 820
   800 IF w2 > 10 THEN  GOTO 620
   802 PRINT "Die Klingonen haben sich selbst zerstoert."
   810 IF d > 50000 THEN  GOTO 1010
   812 PRINT "Die Enterprise ist auch vernichtet."
   814 GOTO 1100
   820 a1 = a1 + a3
   822 q = a1
   824 GOSUB 1070
   826 a1 = q
   827 a2 = a2 + a4
   828 q = a2
   829 GOSUB 1070
   830 a2 = q
   832 x =  SQR (d * d + (q2 * 5000) *  * 2 - (2 * d * q2 * 5000 *  COS ((a2 + 180) * k1)))
   840 y =  SQR (d * d + (q1 * 5000) *  * 2 - (2 * d * q1 * 5000 *  COS (a1 * k1)))
   850 d =  INT ((x + y) / 2)
   852 h1 = h1 * 3
   853 h2 = h2 * 3
   854 s1 = s1 - h2
   855 s2 = s2 - h1
   860 p1 = p1 - h2 / 3
   861 p2 = p2 - h1 / 3
   862 w1 = w1 - h2 / 3
   863 w2 = w2 - h1 / 3
   870 IF s1 < 0 THEN  GOTO 880
   872 IF s2 < 0 THEN  GOTO 900
   874 GOTO 930
   880 PRINT "Mr.Scott meldet den Ausfall der Abwehrschirme."
   890 k4 = 1
   891 w1 = w1 + s1
   892 p1 = p1 + s1
   893 i1 = i1 + s1
   894 l1 = l1 + s1
   896 s1 = 0
   898 IF s2 > 0 THEN  GOTO 950
   900 p2 = p2 + s2
   901 w2 = w2 + s2
   902 i2 = i2 + s2
   903 l2 = l2 + s2
   904 s2 = 0
   910 PRINT "Checkov meldet den Ausfall der Abwehrschirme der Klingonen."
   912 GOTO 950
   930 IF s1 < 25 AND s1 > 0 THEN  GOTO 935
   931 GOTO 940
   935 PRINT "Scotty meldet den Ausfall der Abwehrschirme 4 und 6."
   940 IF s2 < 25 AND s2 > 0 THEN  GOTO 945
   941 GOTO 950
   945 PRINT "Die Sensoren zeigen ein Ermueden der Abwehrschirme der Klingonen."
   950 h1 = 0
   952 h2 = 0
   954 IF l1 < 10 THEN  GOTO 960
   956 IF l2 < 10 THEN  GOTO 1200
   958 GOTO 1030
   960 RANDOMIZE 3
   961 CLS 
   962 c =  RND 
   963 IF c = 0 THEN  GOTO 970
   964 IF c = 1 THEN  GOTO 980
   965 IF c = 2 THEN  GOTO 990
   970 PRINT "Die Enterprise ist nicht mehr.Sie haben verloren."
   972 GOTO 1100
   980 PRINT "Die Enterprise ist ein Wrack."
   981 PRINT "Die Klingonen naehern sich der Erde."
   982 GOTO 1100
   990 PRINT "Sie haben verloren."
   991 PRINT "Sie sind unfaehig, die Enterprise zu fuehren !!!"
   992 GOTO 1100
  1010 CLS 
  1011 PRINT "Die Klingonen sind ausgeschaltet."
  1012 PRINT "Sie haben die Galaxis gerettet."
  1013 GOTO 1100
  1020 CLS 
  1021 PRINT "Sulu meldet, dass die Klingonen keine Lebenszeichen"
  1022 PRINT "mehr von sich geben.Sie haben gewonnen."
  1023 GOTO 1100
  1030 IF l1 < 50 THEN  GOTO 1040
  1032 IF l2 < 50 THEN  GOTO 1050
  1034 GOTO 180
  1040 PRINT "Lt.Uhura meldet die Schwaechung des Lebenserhaltungssystems."
  1042 GOTO 180
  1050 PRINT "Die Sensoren zeigen, dass die Klingonen "
  1051 PRINT "bald am Ende sind "
  1052 GOTO 180
  1060 LOCATE 0,20: PRINT "In welche Richtung wollen Sie schiessen?                                      "
  1062 INPUT a
  1063 LOCATE 0,20: PRINT "                                                    "
  1064 RETURN 
  1070 IF q <  - 180 THEN  LET q = q + 360
  1072 IF q > 180 THEN  LET q = q - 360
  1074 RETURN 
  1100 PRINT 
  1110 PRINT "Noch einmal?"
  1120 INPUT q$
  1130 IF q$ = "ja" THEN  RUN 
  1140 END 
  1200 RANDOMIZE 2
  1210 c =  RND 
  1220 IF c = 0 THEN  GOTO 1010
  1230 IF c = 1 THEN  GOTO 1020
