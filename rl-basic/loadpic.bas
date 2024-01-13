    10 REM Lade Bild fuer COL256-Karte von Diskette
    20 REM COL256-Speicherkarte auf $EC000, IO-Adressen ab $FFFFFFAx
    30 REM
    40 REM (c) 1987 R. Lobreyer
    50 REM
    60 REM
    70 FILES 
    80 INPUT "Dateiname ->";na$
    90 OPEN "I",#1,na$
   100 FOR ix% = 0 TO 511 STEP 2
   110   FOR iy% = 0 TO 511 STEP 2
   120     COLOR  =  INP (1)
   125     PSET ix%,iy%
   130   NEXT 
   140 NEXT 
   150 CLOSE #1
   160 END 
