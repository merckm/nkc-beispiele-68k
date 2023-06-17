* DARSTELLUNG DER MANDELBROTMENGE
* RDK 20.9.85 (LOOP 5 SEITE 16)
* VERSION FUER COL 256 AM 27.5.1986 VON KEI THOMSEN
*
* AUS LOOP 14, SEITE 21-22
 
* ALLE WERTE WERDEN MIT 1000 MULTIPLIZIERT ALS
* FESTKOMMAZAHL VERWENDET. DAMIT IST EINE
* SCHNELLE INTEGER-ARITHMETIK MOEGLICH.
 
 ORG    $400
 
PMIN: DC.L 0
PMAX: DC.L 0
QMIN: DC.L 0
QMAX: DC.L 0
QMAXQMIN: DC.L 0
PMAXPMIN: DC.L 0
 
APFELROR: DC.B 0
DS 0
 
M EQU 16*1000*1000      * RADIUS*RADIUS FUER TEST
ANZAHL EQU 100           * DERECHNUNGSTIEFE (MAXTIEFE)
ENDFARBE EQU $00       * ENDFARBE (FARBE BEI MAXTIEFE)
 
START:
 BSR COLINIT            * INITIALISIERUNG DER GRAFIK
 MOVE.L #-1000,PMIN     * GRENZWERTE FESTLEGEN
 MOVE.L #0,PMAX
 MOVE.L #0,QMIN
 MOVE.L #1000,QMAX
 MOVE.B #$03,APFELROR   * FARBVERFAELSCHUNG
 MOVE.L PMAX,PMAXPMIN   * P-SCHRITT BERECHNEN
 MOVE.L PMIN,D0
 SUB.L D0,PMAXPMIN 
 MOVE.L QMAX,QMAXQMIN   * Q-SCHRITT BERECHNEN
 MOVE.L QMIN,D0
 SUB.L D0,QMAXQMIN 

 CLR.L D1               * X-COUNTER AUF 0
XLOOP:
 CLR.L D2               * Y-COUNTER AUF 0
YLOOP:
 MOVE.L PMAXPMIN,D3
 MULS D1,D3             * MIT X-KOORD.
 DIVS #255,D3           * X-AUFLOESUNG
 ADD PMIN+2,D3         * D3=P0 START
 MOVE.L QMAXQMIN,D4
 MULS D2,D4             * MIT Y-KOORD.
 DIVS #255,D4           * Y-AUFLOESUNG
 ADD QMIN+2,D4 
 CLR.L D5               * X0=0
 CLR.L D6               * Y0=0
 CLR.L D7               * K=0, ZAEHLER
 MOVEM.L D1-D2,-(A7)    * FREIRAUM SCHAFFEN
ITERAT:                 * ITERATIONSSCHLEIFE
 MOVE D5,D1
 MULS D1,D1
 MOVE D6,D0
 MULS D0,D0
 SUB.L D0,D1
 DIVS #1000,D1
 ADD D3,D1              * XK+1 IN D1
 MOVE D5,D2
 MULS D6,D2
 DIVS #500,D2           * WEGEN FESTKOMMA ( UND * 2 )
 ADD D4,D2
 MOVE D1,D5
 MOVE D2,D6             * NEUE Y-WERTE
 ADDQ #1,D7             * NEUES K
 MULS D1,D1
 MULS D2,D2
 ADD.L D2,D1
 CMP.L #M,D1
 BGE.S AUSGABE
 CMP #ANZAHL,D7
 BEQ.S AUSGABE
 BRA ITERAT
AUSGABE:
 MOVEM.L (A7)+,D1-D2
 BNE.S OUTPUT           * HAENGT VON * CMP #ANZAHL,D7 * AB       
 MOVE.B ENDFARBE,D0    * WENN TIEFE = MAXTIEFE (ANZAHL) DANN
 BRA.S OUTPUT1          * FARBE = ENDFARBE
 
OUTPUT:
 MOVE.B D7,D0           * TIEFE ALS FARBE DARSTELLEN
 MOVE.B APFELROR,D7     * FARBVERFAELSCHUNG
 ROR.B D7,D0

OUTPUT1:
 MOVEM.W D1-D2,-(A7)
 BSR SETFDOT            * PUNKT SETZEN
 MOVEM.W (A7)+,D1-D2

 ADDQ #1,D2             * NEUES Y
 CMP #256,D2
 BLT YLOOP
 ADDQ #1,D1          * NEUES X
 CMP #256,D1
 BLT XLOOP
 RTS
 
* COL 256 UNTERPROGRAMM
 
CPU     EQU     1      * 68008 = 1  68000 = 2  608020 = 4
 
CRT     EQU     $FFFFFFCC*CPU
CRTD    EQU     $FFFFFFCD*CPU
CRTB    EQU     $FFFFFFCE*CPU
 
 COLRAM EQU     $CC000  * RAM ADRESSE DER COL 256
 
COLINIT:
 LEA TAB(PC),A0
 CLR D1
 MOVE.W #LENGTH-1,D3
LPP:
 MOVE.B D1,CRT
 MOVE.B (A0)+,CRTD
 ADDQ.W #1,D1
 DBRA D3,LPP
 BSR CLR
 RTS
 
TAB:
 DC.B 111,64,80,7,77,0,64,70,0,3,0,0,0,0,0
LENGTH EQU *-TAB
 
 DS 0
 
CLR:
 CLR.L D0
 MOVE.B #$80,CRTB
 BSR CLRP
 MOVE.B #$81,CRTB
 BSR CLRP
 MOVE.B #$82,CRTB
 BSR CLRP
 MOVE.B #$83,CRTB
 BSR CLRP
 CLR.B CRTB
 RTS
  
CLRP:                   * GEHT AUCH SCHNELLER, DAFUER
 LEA COLRAM*CPU,A0      * ABER ALLGEMEIN!
 MOVE.W #$4000-1,D3
CLRPLOOP:
 CLR.B (A0)
 ADDQ.L #CPU,A0
 DBRA D3,CLRPLOOP
 RTS

SETFDOT:                * PUNKT BERECHNEN
 MOVE.W D2,-(A7)
 NOT.B D2
 ROR.W #6,D2
 OR.B #$80,D2
 MOVE.B D2,CRTB.S
 LSR.W #2,D2
 MOVE.B D1,D2

* LSL.L #1,D2           * NUR FUER 68000
* LSL.L #2,D2           * NUR FUER 68020
 
 LEA COLRAM*CPU,A0
 ADDA.L D2,A0
 MOVE.W (A7)+,D2
 MOVE.B D0,(A0)         * PUNKT DARSTELLEN
 CLR.B CRTB.S
 RTS
