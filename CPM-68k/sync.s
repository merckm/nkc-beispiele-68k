TASTEN EQU $FFFFFF30

SEK:                    * UNTERPROGRAMM 1 SEK
 MOVE #5-1,D3           * 1/10 SEK. AUSZAEHLEN
WARTE:                  * DURCHLAUF IST 20MS
 JSR @SYNC              * UNTERPROG, LIEFERT
 BEQ WARTE              * ALLE 20MS WERT <> 0
 DBRA D3,WARTE          * DAS GANZE 5 MAL
 RTS
 
START:
 BSR SEK
 MOVE.B #$01,TASTEN
 BRA START

 END
