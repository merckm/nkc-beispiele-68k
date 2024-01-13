     5 k1 = 3.1415 / 180
    15 geschwe = 3
    20 geschwk = 3
    25 entf = 100000
    30 antriebe = 100
    35 antriebk = 100
    40 pulse = 100
    45 pulsk = 100
    50 schirme = 100
    55 schirmk = 100
    60 RANDOMIZE 180
    65 a1 =  RND  - 90
    70 a2 = a1 - 180
    75 IF a2 <  - 180 THEN  LET a2 = a2 + 360
    80 lebene = 100
    85 lebenk = 100
    90 waffene = 100
    95 waffenk = 100
   100 drehunge = 0
   105 drehungk = 0
   110 a = 0
   115 q = 0
   120 h1 = 0
   125 h2 = 0
   130 PAGE 2,2: CLPG 
   135 DIM text$(90)
   140 text$(0) = "         S T A R - T R E C K "
   142 text$(2) = "     Die Klingonen greifen an. Geben Sie die richtigen Befehle !"
   144 text$(3) = "     Die Entfernung der Raumschiffe wird immer neu angezeigt, "
   146 text$(4) = "     die uebrigen Werte nur, wenn ein neuer Lagebericht "
   148 text$(5) = "     verlangt wird. "
   150 text$(7) = "SCHUSSWINKEL = Winkel der Klingonen minus Winkel der Enterprise"
   152 text$(9) = "                     1 = Phaser-Kanone "
   154 text$(11) = "                     2 = Photonen Torpedos "
   156 text$(13) = "                     3 = Neuer Lagebericht "
   158 text$(15) = "                     4 = Kurskorrektur"
   160 text$(17) = "                     5 = Selbstzerstoerung"
   162 text$(20) = "     Ihr erster Befehl ?"
   163 text$(30) = "Die Klingonen sind vernichtet !"
   164 text$(31) = "Die Enterprise auch !"
   165 text$(32) = "Sie sind zu weit entfernt !"
   166 text$(33) = "Die Klingonen haben gewonnen !"
   167 text$(34) = "Wollen Sie es nochmal versuchen ? (j/n)"
   168 text$(21) = "     Ihr neuer Befehl ?"
   169 text$(22) = "Bitte Schusswinkel eingeben :   "
   170 text$(23) = "Bitte Wendung eingeben (Grad) : "
   171 text$(24) = "Bitte Geschwindigkeit eingeben :"
   172 text$(25) = "Wert zu hoch !"
   173 text$(26) = "> > > Aktueller Lagebericht < < <"
   174 text$(27) = "> > >      Lagebericht      < < <"
   175 text$(28) = "Lagebericht Grafik = j"
   176 text$(29) = "Lagebericht Normal = j"
   177 text$(40) = "                   Enterprise      Klingonen"
   178 text$(41) = "Geschwindigkeit :"
   179 text$(42) = "         Winkel :"
   180 text$(43) = "        Wendung :"
   181 text$(44) = "Lebenserhaltung :"
   182 text$(45) = "        Antrieb :"
   183 text$(46) = "         Impuls :"
   184 text$(47) = "        Schirme :"
   185 text$(48) = "         Waffen :"
   250 WRITE 0,480,$22,text$(0)
   252 y = 1
   254 FOR x = 460 TO 100 STEP  - 20
   256   WRITE 20,x,$11,text$(y)
   258   y = y + 1
   260 NEXT x
   262 WRITE 50,60,$22,text$(20)
   264 tast!:bef$ =  INKEY$ 
   266 IF bef$ = "1" THEN  GOTO phaser!
   268 IF bef$ = "2" THEN  GOTO photon!
   270 IF bef$ = "3" THEN  GOTO lage!
   272 IF bef$ = "4" THEN  GOTO kurs!
   274 IF bef$ = "5" THEN  GOTO selbst!
   276 GOTO tast!
   300 lage!
   310 CLPG 
   315 z = 450
   320 FOR a = 40 TO 48
   330   WRITE 0,z,$21,text$(a)
   340   z = z - 20
   350 NEXT a
   360 GOTO tast!
  1000 selbst!
  1010 IF entf <  = 50000 THEN 
  1020   CLPG 
  1030   WRITE 0,300,$22,text$(30)
  1040   WRITE 0,200,$22,text$(31)
  1050 ELSE 
  1060   CLPG 
  1070   WRITE 0,300,$22,text$(32)
  1080   WRITE 0,200,$22,text$(33)
  1090 END  IF 
  1100 noch!
  1110 WRITE 0,50,$22,text$(34)
  1120 a$ =  INKEY$ 
  1130 IF a$ = "j" THEN  RUN 
  1140 IF a$ = "n" THEN  END 
  1150 GOTO 1120
