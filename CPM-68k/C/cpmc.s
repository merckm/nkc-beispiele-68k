* ----------------------------------------------------------------------------
*     Einbindung der BDOS- und BIOS-Funktionen in das C-Programm:
*
*            _sectxtl:        Sector translation
*            _bdos:           BDOS-Aufruf
*            _bios:           BIOS-Aufruf
*            _biosl:          BIOS-Aufruf mit Langwort-Argument
*
* ----------------------------------------------------------------------------
*    
*     Beim Aufruf der Funktionen wird der WErt im D0-Register als
*     Funktionswert zurueckgegeben.
*     Defaultmaessig wird ein Word-Parameter zurueckgegeben. Werden die
*     Funktionen mit
*
*             extern long bios(), biosl(), bdos();
*
*     definiert, so wird D0 als Langwort von C uebernommen. 
*     Aufruf der Funktionen:
*
*             ret = biosl((int)function#, (long)arg);
*             ret = bios((int)function#, (int)arg);
*             ret = bdos((int)function#, (int)arg);
*             xsect = sectxlt((char *)table, (int)sect);
*
* ----------------------------------------------------------------------------
    .globl _biosl                   * Als globale Funktionen definieren
    .globl _bios
    .globl _sectxlt
    .globl _bdos
* ----------------------------------------------------------------------------
    .text
_bios:
    move.w 4(sp),d0                 * Funktionsnummer vom Stack holen
    move.w 6(sp),d1                 * Argument vom Stack holen
    clr.w d2                        * D2 loeschen          
    trap #3                         * BIOS-Aufruf
    rts                             * Zurueck ins C-Programm
  
_biosl:
    move.w 4(sp),d0                 * Dasselbe mit Long-Parameter
    move.l 6(sp),d1
    clr.w d2
    trap #3
    rts
  
_bdos:
    move.w 4(sp),d0                 * Einbindung des BDOS in C
    move.w 6(sp),d1                 * (wie BIOS)
    trap #2
    rts
  
_sectxlt:                           * Sector translation
    move.l 4(sp),d2                 * Addresse der Tabelle vom Stack
    move.w 8(sp),d1                 * Sektornummer vom Stack
    move.w #16,d0                   * BIOS Fkt. #16 (Sector translate)
    trap #3                         * BIOS-Aufruf
    rts
* ----------------------------------------------------------------------------
    end
