    10 REM Demonstration des Quicksortalgorithmus unter RL-BASIc 2.4
    20 REM
    30 REM (c) 1987 R. Lobreyer
    40 REM
    50 CLS 
    60 PRINT : PRINT " Q u i c k s o r t   -   D e m o n s t r a t i o n "
    70 PRINT "---------------------------------------------------"
    80 PRINT 
    90 INPUT "Anzahl der Feldelemente ->";n
   100 DIM a(n)
   110 REM Keller anhand der Feldelementezahl dimensionieren
   120 DIM stack%(2 * n)
   130 s_pointer% = 2 * n + 1
   140 RANDOMIZE n
   150 FOR i% = 0 TO n
   160   a(i%) =  RND 
   170 NEXT 
   180 PRINT "Unsortiertes Feld :"
   190 GOSUB gib_feld_aus!
   200 p% = 0
   210 q% = n
   220 GOSUB quicksort!
   230 PRINT "Sortiertes Feld :"
   240 GOSUB gib_feld_aus!
   250 END 
   260 REM Quicksort
   270 REM Schnelles Sortierverfahren in RL-BASIC 2.4
   280 REM
   290 REM zu sortierendes Feld : a
   300 REM Startelement = p%
   310 REM Endelement = q%
   320 REM
   330 quicksort!
   340 IF q% > p% THEN 
   350   i% = p%
   360   j% = q%
   370   v_wert = a( INT ((p% + q%) / 2))
   380   WHILE i% <  = j%
   390     WHILE a(i%) < v_wert
   400       i% = i% + 1
   410     WEND 
   420     WHILE a(j%) > v_wert
   430       j% = j% - 1
   440     WEND 
   450     IF i% <  = j% THEN 
   460       SWAP a(i%),a(j%)
   470       i% = i% + 1
   480       j% = j% - 1
   490     END  IF 
   500   WEND 
   510   s_pointer% = s_pointer% - 1
   520   stack%(s_pointer%) = q%
   530   s_pointer% = s_pointer% - 1
   540   stack%(s_pointer%) = i%
   550   q% = j%
   560   GOSUB quicksort!
   570   p% = stack%(s_pointer%)
   580   s_pointer% = s_pointer% + 1
   590   q% = stack%(s_pointer%)
   600   s_pointer% = s_pointer% + 1
   610   GOSUB quicksort!
   620 END  IF 
   630 RETURN 
   640 gib_feld_aus!
   650 FOR i% = 0 TO n
   660   PRINT a(i%),
   670 NEXT 
   680 PRINT 
   690 RETURN 
