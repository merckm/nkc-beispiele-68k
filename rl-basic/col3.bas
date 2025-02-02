20 INPUT "Dateiname ->";na$
30 OPEN "I",#1,na$
40 FOR i = 1 TO 16
50  col% = INP(1)
60  PRINT i,col%
70 NEXT
80 CLOSE #1
90 END
```