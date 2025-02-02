START:    JSR @CLRSCREEN    * Bildschirm loeschen
          MOVE.B #$1E,D0    * 9600 Baud, 1Stop, 8Bit
          MOVE.B #$0B,D1    * keine Paritaet
          JSR @SIINIT       * Werte einstellen
TERMINAL: JSR @CURSEIN      * Cursor soll blinken
          JSR @SISTS        * Zeichen da ?
          BEQ TERM1         * nein, dann weiter
          JSR @CURSAUS      * Cursor ausblenden
          JSR @SI           * ja, dann abholen
          JSR @CO2          * und ausgeben
          JSR @CURSEIN      * Cursor wieder darstellen
TERM1:    JSR @CSTS         * Zeichen von der Tastatur da?
          BEQ TERM2         * nein, dann weiter
          JSR @CI           * ja, dann abholen
          JSR @SO           * und ausgeben
TERM2:    JSR @AUTOFLIP     * und Cursor blinken lassen
          BRA TERMINAL      * und so weiter
