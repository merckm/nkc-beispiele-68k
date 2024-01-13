    10 REM Lade Bild fuer GDP64K-Karte von Diskette
    20 REM Bei den abgelegten Bildern handelt es sich um ein Grauwertbild
    30 REM der Groesse 256 x 256.
    40 REM
    50 REM (c) 1987 R. Lobreyer
    60 REM
    70 REM
    80 FILES 
    90 INPUT "Dateiname ->";na$
   100 OPEN "I",#1,na$
   110 PAGE 2,2: CLPG 
   120 FOR ix% = 0 TO 511 STEP 2
   130   FOR iy% = 0 TO 511 STEP 4
   140     c% = ( INP (1) +  INP (1)) / 2
   150     IF c% > 50 THEN 
   160       PSET ix%,iy%
   170       IF c% > 100 THEN 
   180         PSET ix% + 1,iy% + 2
   190       END  IF 
   200       IF c% > 150 THEN 
   210         PSET ix%,iy% + 2
   220       END  IF 
   230       IF c% > 200 THEN 
   240         PSET ix% + 1,iy%
   250       END  IF 
   260     END  IF 
   270   NEXT 
   280 NEXT 
   290 CLOSE #1
   300 END 
