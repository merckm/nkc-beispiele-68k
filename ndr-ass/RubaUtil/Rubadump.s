ORG $400
 
*      R U B A D U M P
*
*      PROGRAMM ZUR AUSGABE VON SPEICHERBEREICHEN IN HEX * ASCII
*      AUF DEM BILDSCHIRM ODER DEM DRUCKER
*
*      COPYRIGHT (C) !)(% BY RUEDIGER BAECKER - POSTFACH 4111 - 5280 GEVELSBERG
*
*       Aus LOOP 6, Seite 12/13
 
KOPF:
DC.L $55AA0180
DC.B 'Rubadump'
DC.L RUBADUMP-KOPF
DC.L ENDEA-KOPF
DC.B 1
DC.B 0,0,0
DC.L 0,0
 
ZEILENZ     EQU     $70         * BUFFER FUER ZEILENZAEHLER
ZIELADR     EQU     $F4
TAST        EQU     $FFFFFF68
 
RUBADUMP:
    MOVE #!CLPG,D7
    TRAP #1
    CLR.B TAST+1
    CLR.L D0
    CLR.L D1
    CLR.L D2
    CLR.L D3
    MOVE.B #0,ZEILENZ(A5)

    LEA DUTEXT1(PC),A0
    MOVE.B #$42,D0
    MOVE.B #0,D1
    MOVE.B #200,D2
    MOVE #!WRITE,D7
    TRAP #1
 
    SUB #30,D2
    MOVE.B #$32,D0
    LEA TEXT2(PC),A0
    MOVE #!WRITE,D7
    TRAP #1
 
    SUB #40,D2
    MOVE.B #$21,D0
    LEA DUTEXT2(PC),A0
    MOVE #!WRITE,D7
    TRAP #1
 
    SUB #20,D2
    LEA DUTEXT3(PC),A0
    MOVE #!WRITE,D7
    TRAP #1

GETWD1:                     * START- & ENDADRESSE HOLEN
    MOVE.B #$21,D0
    MOVE.B #130,D2
    MOVE.B #250,D1
    MOVE.B #9,D3
    LEA ZIELADR(A5),A0
    MOVE #!READ,D7
    TRAP #1
    LEA ZIELADR(A5),A0
    MOVE.B (A0),D4
    CMP.B #'m',D4
    BEQ ENDDUMP
    MOVE #!WERT,D7
    TRAP #1
    MOVEA.L D0,A4
 
GETWD2:
    MOVE.B #$21,D0
    MOVE.B #110,D2
    MOVE.B #250,D1
    LEA ZIELADR(A5),A0
    MOVE #!READ,D7
    TRAP #1
    LEA ZIELADR(A5),A0
    MOVE #!WERT,D7
    TRAP #1
    MOVEA.L D0,A5
 
    SUBA.L A4,A5
    MOVE.L A5,D1
    MOVEA.L A4,A0
    LEA ANFTAB(PC),A2
    CLR.L D2
    CLR.L D0
    MOVE #!CLRSCREEN,D7
    TRAP #1
    BSR LHEAD
    MOVE.B #4,D4
    MOVE.L A0,ZIELADR(A5)
    BSR ADRLOOP
    LEA ZIELADR(A5),A4
    MOVE.B #16,D4
LOOP:
    MOVE.B (A0),D2
    BSR PUTASCII
    AND.B #$F0,D2
    LSR.B #4,D2
    MOVE.B 0(A2,D2),D0
    MOVE #!CO2,D7
    TRAP #1
    MOVE.B (A0)+,D2
    AND.B #$0F,D2
    MOVE.B 0(A2,D2),D0
    MOVE #!CO2,D7
    TRAP #1
    MOVE.B #' ',D0
    MOVE #!CO2,D7
    TRAP #1
    SUB #1,D4
    CMP.B #0,D4
    BEQ LF
LFR:
    DBRA D1,LOOP
    RTS
LF:
    MOVE.B #' ',D0
    MOVE #!CO2,D7
    TRAP #1
    BSR GETASCII
    CLR.L D0
    MOVE.B ZEILENZ(A5),D0
    CMP.B #68,D0
    BEQ NEXTPP
PSCHLPP:
    BSR HEND
    MOVE.L A0,ZIELADR(A5)
    MOVE.B #4,D4
    BSR ADRLOOP
    MOVE.B #16,D4
    BRA LFR
 
NEXTPP:
    MOVE.B #0,ZEILENZ(A5)
    MOVE.B #$0A,D0
    CLR.L D3
    MOVE.B #4-1,D3
MPP1A:
    MOVE #!CO2,D7
    TRAP #1
    DBRA D3,MPP1A
    BRA PSCHLPP
 
ADRLOOP:
    MOVEM.L A0/D2,-(A7)
    LEA ZIELADR(A5),A4
    LEA ZIELADR(A5),A0
WL:
    MOVE.B (A0),D2
    AND.B #$F0,D2
    LSR.B #4,D2
    MOVE.B 0(A2,D2),D0
    MOVE #!CO2,D7
    TRAP #1
    MOVE.B (A0)+,D2
    AND.B #$0F,D2
    MOVE.B 0(A2,D2),D0
    MOVE #!CO2,D7
    TRAP #1
    SUB #1,D4
    CMP.B #0,D4
    BNE WL
    MOVE.B #' ',D0
    MOVE #!CO2,D7
    TRAP #1
    MOVE.B #'-',D0
    MOVE #!CO2,D7
    TRAP #1
    MOVE.B #'-',D0
    MOVE #!CO2,D7
    TRAP #1
    MOVE.B #'>',D0
    MOVE #!CO2,D7
    TRAP #1
    MOVE.B #' ',D0
    MOVE #!CO2,D7
    TRAP #1
    MOVEM.L (A7)+,D2/A0
    RTS

PUTASCII:
    CMP.B #$20,D2
    BLT PUNKT
    CMP.B #$7F,D2
    BGT PUNKT
    MOVE.B D2,(A4)+
    RTS
 
PUNKT:
    MOVE.B #'.',(A4)+
    RTS
 
GETASCII:
    LEA ZIELADR(A5),A4
    CLR.L D5
    MOVE.B #15,D5
GETLOOP:
    MOVE.B (A4)+,D0
    MOVE #!CO2,D7
    TRAP #1
    DBRA D5,GETLOOP
    RTS
 
LHEAD:
    MOVEM.L A0,-(A7)
    LEA DUTEXT1(PC),A0
HSCHL:
    MOVE.B (A0)+,D0
    CMP.B #0,D0
    BEQ COPYR
    MOVE #!CO2,D7
    TRAP #1
    BRA HSCHL:
 
COPYR:
    MOVE.B #' ',D0
    MOVE #!CO2,D7
    TRAP #1
    LEA TEXT2(PC),A0
COPYR1:
    MOVE.B (A0)+,D0
    CMP.B #0,D0
    BEQ HENDD
    MOVE #!CO2,D7
    TRAP #1
    BRA COPYR1:
HENDD:
    MOVEM.L (A7)+,A0
HEND:
    MOVE.B #$D,D0
    MOVE #!CO2,D7
    TRAP #1
    MOVE.B #$A,D0
    MOVE #!CO2,D7
    TRAP #1
    MOVE.B ZEILENZ(A5),D0
    ADD #1,D0
    MOVE.B D0,ZEILENZ(A5)
    RTS
 
ENDDUMP:
    RTS
 
ANFTAB:
    DC.B $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$41,$42,$43,$44,$45,$46
DUTEXT1:
    DC.B 'Rubadump',0
TEXT2:
    DC.B '(C) 1985 by Ruediger Baecker',0
DUTEXT2:
    DC.B 'von -->',0
DUTEXT3:
    DC.B 'bis -->',0
ENDEA:
    END.