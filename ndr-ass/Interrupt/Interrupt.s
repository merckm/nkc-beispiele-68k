**************************
* UHRZEIT EINBLENDEN     *
**************************
 
* INTERRUPT - BAUSTEIN
 
ORG $E0006      * FESTE ADRESSE Lv. 5 INT
JMP INTAUS      * DORT INT-PROGRAMM
ORG $E000C      * FESTE ADRESSE Lv. 7 INT
JMP INTAUS      * DORT INT-PROGRAMM

ORG $E9C00      * FESTE ADRESSE

* VEREINBARUNGS BAUSTEIN
 
GDP EQU $FFFFFF70
 
GDPREGISTERS: DS.B 15   * HIER ALLE REGISTERWERTE MERKEN
BUFFER:     DS.B 80     * AUSGABE PUFFER
            DS 0        * BYTE ANGLEICH
 
MILLISEK:   DC.W 0      * UHRZEIT DURCH KONSTANTEN
SEKUNDEN:   DC.W 0      * VOREINSTELLBAR
MINUTEN:    DC.W 08     *
STUNDEN:    DC.W 22     *
SAFE:       DC.W 0      * Zum Speichern des SR

ENABLE:
    move.w SR,D0
    move.w D0,SAFE
    move.w #$2000,SR
    rts
 
DISABLE:
    move.w SAFE,D0
    move.w D0,SR
    rts

 

* UNTERPROGRAMM-BAUSTEIN
 
TRENNUNG:        * ZEICHEN ZWISCHEN DER ZEITAUSGABE
    MOVE.B #':',(A0)+
    CLR.B (A0)
    RTS
 
* PROGRAMM-BAUSTEIN
 
INTAUS:                         * IST DIESMAL AUCH DIESMAL 
                                * HAUPTPROGRAMM 
    MOVEM.L D0-D7/A0-A6,-(A7)   * ALLES RETTEN
    JSR @WAIT                   * WARTEN BIS GDP FERTIG
    LEA GDPREGISTERS,A1         * ZIEL
    LEA GDP+1,A0                * DANN ALLE GDP-REGISTER RETTEN
    MOVE #15-1,D3               * NUR COMMANDPORT NICHT
RETTEG:
    MOVE.B (A0)+,(A1)+          * OK TRANSPORT
    DBRA D3,RETTEG
    ADD #20,MILLISEK            * ERST MS BILDEN
    CMP #1000,MILLISEK          * WENN <1000 DANN WEITER
    BLT INT0                    * SONST SEKUNDEN BEARBEITEN
    CLR MILLISEK                * BEREICH 0..999
    ADD #1,SEKUNDEN             * SEKUNDEN NEU
    CMP #60,SEKUNDEN            * 0..59 ERLAUBT
    BLT INT1                    * JA, DANN WEITER
    CLR SEKUNDEN                * SONST MINUTEN
    ADD #1,MINUTEN              * ERHOEHEN
    CMP #60,MINUTEN             * AUCH 0..59
    BLT INT1                    * WEITER WENN IM BEREICH
    CLR MINUTEN                 * SONST UEBERTRAG AUF STUNDEN
    ADD #1,STUNDEN              * ERHOEHEN
    CMP #24,MINUTEN             * 0..23 ERLAUBT
    BLT INT1                    * JA, DANN WEITER
    CLR STUNDEN                 * EINEN WEITEREN UEBERTRAG
INT1:                           * NUN AUSGABE AUF DEM BILDSCHIRM DURCHFUEHREN
                                * ABER NUR ALLE SEK. DURCHFUEHREN
    LEA BUFFER,A0               * ZIEL DER AUSGABE
    MOVE STUNDEN,D0             * ALLES IN ASCII UMWANDELN UND ABLEGEN
    JSR @PRINT4D                * 0..23
    BSR TRENNUNG
    MOVE MINUTEN,D0
    JSR @PRINT4D                * 0..59
    BSR TRENNUNG
    MOVE SEKUNDEN,D0
    JSR @PRINT4D                * 21:47:0 AUSGEBEN, Z.B.
    MOVE #10-1,D3               * REST AUFFUELLEN
INTLP1:
    MOVE.B #' ',(A0)+           * MIT LEERZEICHEN
    DBRA D3,INTLP1              * DA UNTERSCHIEDLICH VIELE ZEICHEN
    CLR.B (A0)                  * ENDE MARKIEREN
    LEA BUFFER,A0               * UND DANN AUSGEBEN
    MOVE.B #$22,D0              * SCHRIFTGROESSE 2,2
    MOVE #400,D1                * X-KOORDINATE
    MOVE #1,D2                  * Y-KOORDINATE
    JSR @WRITE                  * UND AUSGABE DURCHFUEHREN
INT0:                           * ALLE 20 MS, ERFOLGT HIER EIM EINSPRUNG
************* INT--PROGRAMM ENDE, JETZT REGISTER ZURUEK *************
    JSR @WAIT                   * DANN WIEDER ZURUECK DAMIT
    LEA GDPREGISTERS,A1         * QUELLE
    LEA GDP+1,A0                * DANN ALLE GDP-REGISTER LADEN
    MOVE #15-1,D3               * aNUR COMMANDPORT NICHT
LADEG:
    MOVE.B (A1)+,(A0)+          * OK TRANSPORT
    DBRA D3,LADEG               * DURCHFUEHREN
    MOVEM.L (A7)+,D0-D7/A0-A6   * UND ALTE INHALTE WIEDER ZURUECK
    RTE
 