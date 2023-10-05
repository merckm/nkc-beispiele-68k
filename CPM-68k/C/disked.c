/*****************************/
/* DISKEDITOR aus MC 02/1987 */
/* von: Matthias Koefferlein */
/* Angepasst fuer            */
/* NDR-Klein Computer        */
/* Dr. Martin Merck 20230618 */
/*****************************/
#include <stdio.h>

#define CLS 26                      /* Definitionen: Schirm loeschen      */
#define UP 5                        /*   Cursor nach oben                 */
#define DOWN 24                     /*   Cursor nach unten                */
#define LEFT 19                     /*   Cursor nach links                */
#define RIGHT 4                     /*   Cursor nach rechts               */
#define ESC 27                      /*   Escape                           */
#define BS 6                        /*   Backspace                        */
#define CR 13                       /*   Carriage Return                  */
#define HOME 30                     /*   Code fuer Taste: Home            */
#define END 17                      /*                    Linke u. Ecke   */
 
#define scan() bios(3, 0)           /* Keyboard abfragen: BIOS Fkt. #3    */
#define goxy(xp,yp) printf("%c=%c%c",ESC,(yp)+32,(xp)+32)
                                    /* Sequenz fuer Cursor absolut setzen */
#define clrel() printf("%cT",ESC)   /* Sequenz fuer Zeilenende loeschen   */
 
char buffer[128];                   /* Puffer fuer Sektor                 */
int sect = 0;                       /* Sektornummer (physikalisch)        */
int track = 0;                      /* Tracknummer                        */
int cursx = 0;                      /* Position des Cursors               */
int cursy = 0;
int drive;                          /* Nummer der Drives (0:a usw.)       */
char hexl[] = "0123456789abcdef";   /* ASCII-Codes der Hex-Zahlen         */
char hexu[] = "0123456789ABSDEF";   /* Auch als upper-case Buchstaben     */
 
struct dpb {                        /* Disk parameter block               */
    int spt;                        /* Zahl der records (128 Byte)/track  */
    char bsh;                       /* 3: 1024, 4: 2048, 5: 4096 use ...  */
    char r1;                        /* 3 unbenuetzte Bytes                */
    char r2;
    char r3;
    int dsm;                        /* Diskgraesse in Blocks minus 1      */
    int drm;                        /* Directory Eintraege minus 1        */
    int r4;                         /* 2 unbenutzte Worte                 */
    int r5;
    int off;                        /* Zahl der reservierten Tracks       */
};
struct dph {                        /* Disk parameter header              */
    char *xlt;                      /* Addresse der translation table     */
    int r1;                         /* 5 unbenutzte Worte                 */
    int r2;
    int r3;
    long r4;
    struct dpb *diskp;              /* Adresse des DPB                    */
};
char *xtable;                       /* Zeiger auf translation table       */
struct dpb *diskpar;                /* diskpar: Enthaelt Diskparameter    */
int tracks;                         /* Anzahl der Tracksd                 */
 
extern long bdos();                 /* Funktion zur Einbindung des BDOS   */
extern long bios();                 /* Funktionen zur Einbindung des BIOS */
extern long biosl();                /* Fuer Longword-Parameter            */
extern int sectxlt();               /* Sector-Translation                 */

main()                              /* Hauptprogramm                      */
{
    char c = '\0';
 
    drive = bdos(25, 0);            /* BDOS Fkt. #25 /Get current disk)   */
    title();                        /* Titelbild                          */
    login();                        /* Diskparameter holen                */
    reads();                        /* Sektor 0,0 lesen                   */
    display();                      /* Pufferinhalt ausgeben              */
    while(c != ESC) {               /* ESC beendet Hauptprogramm          */
        goxy(cursx * 3 + 5, cursy +5);
                                    /* Cursor setzen                      */
        c = scan();                 /* Keyboard abfragen                  */
        switch (c) {
            case DOWN:
                if (++cursy < 8)    /* Cursor nach unten bewegen          */
                    break;
            case UP:
                if (cursy)          /* Cursor nach oben bewegen           */
                    cursy--;
                break;
            case 'e':
            case 'E':
                editby();           /* E: Byte aendern                    */
                display(cursy);
            case RIGHT:
                if (++cursx < 16)   /* Cursor nach rechts bewegen         */
                    break;
                if (++cursy < 8) {
                    cursx = 0;
                    break;
                }
                cursy--;            /* Kein break: Cursor links           */
            case LEFT:
                if (cursx) {        /* Cursor nach links bewegen          */
                    cursx--;
                    break;
                }
                if (cursy) {
                    cursy--;
                    cursx = 15;
                }
                break;
            case 's':
            case 'S':
                setts();            /* S: Track und Sektor setzen         */
                break;
            case 'r':
            case 'R':
                reads();            /* R: Sektor lesen                    */
                display();
                break;
            case 'w':
            case 'W':
                if (ask())          /* Sicherheitsabfrage fuer W:         */
                    writes();       /* Sektor schreiben                   */
                break;
            case ESC:
                if (!ask())         /* Sicherheitsabfrage bei ESC         */
                    c = 0;          /* Bei Nein: ESC entschaerfen         */
                break;
            case HOME:
                cursx = cursy = 0;  /* HOME: Cursor n. rechts o.          */
                break;
            case END:
                cursx = 7;          /* END: Cursor n. links u.            */
                cursy = 0;
                break;
            case 'l':
            case 'L':
                seldsk();           /* L: Laufwerk auswaehlen             */
                dispts();            /* Statuszeile aktualiesieren         */
                break;
        }
    }
    putchar(CLS);                   /* Zurueck ins System                 */
    bdos(0, 0);                     /* BDOS Fkt. #0 (System reset)        */
}
 
title()                             /* Titelbild ausgeben                 */
{
    int i;
 
    putchar(CLS);
    printhl();
    puts("\t\t     SEKTOR <T:  ,S:  > LAUFWERK <  : >");
    puts("\n     x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 xA xB xC xD xE xF\n");
    puts("\n\n\n\n\n\n\n\n\n\n\n\t    <S> TRACK UND SEKTOR SETZEN");
    puts("\t    <R> SEKTOR LESEN\t\t       RECORDS PRO TRACK <  >");
    puts("\t    <W> SEKTOR SCHREIBEN\t\t    BLOCKGROESSE <    >");
    puts("\t    <E> ANGEWAEHLTES BYTE AENDERN\tDISKETTENGROESSE <    >");
    puts("\t    <L> LAUFWERK ANWAEHLEN\t     DIRECTORY-EINTRAEGE <    >");
    puts("\t  <ESC> EDITOR VERLASSEN\t      RESERVIERTE TRACKS <  >");
    puts(" <CURSORTASTEN> CURSOR BEWEGEN\t\t\t\t  TRACKS <    >");
}
 
display()                           /* Pufferinhalt als Hexdump ausgeben  */
{
    int i;
 
    for (i = 0; i < 8; i++)         /* 8 Zeilen Hexdump ausgeben          */
        displn(i);
    dispts();                       /* Statuszeile aktualisieren          */
}
 
dispts()                            /* Statuszeile aktualisieren          */
{
    goxy(28, 1);                    /* Track & Sektor ausgeben            */
    printf("<T:%02x,S:%02x>", track, sect);
                                    /* T & S als zweistellige Hexzahlen   */
    goxy(49, 1);                    /* Drivenummer und Drivecode ausgeben */
    printf("<%02x:%c>", drive, drive + 'A');
}
 
displn(line)                        /* Eine Zeile Hexdump ausgeben        */
int line;                           /* Zeile: 0..7                        */
{
    int i;
    char *p, ascii[17];             /* ascii[]; Puffer fuer ASCII-Dump    */
 
    goxy(0, line + 5);              /* Cursor positionieren               */
    printf("%cx   ",line + 48);     /* Zeilennummer ausgeben (0x .. 7x)   */
    p = buffer + line * 16;         /* p: Zeiger aus auszugebendes Byte   */
    for (i = 0; i < 16; i++) {
        printf("%02x ", (int)*p & 0xFF);
                                    /* Byte als 2-st. Hexzahl ausgeben    */
        ascii[i] = (*p & 0x80) ? *p & 0x7F : '.';
                                    /* ASCII-Dump-String aufbauen:        */
                                    /* '.' falls Zeichen kein ASCII-Code  */
        p++;
    }
    ascii[16] = '\0';               /* ASCII-Dump-String abschliessen     */
    printf("  %s", ascii);
}
 
readby(def)                     /* Byte als 2-stellige Hex-Zahl eingeben  */
int def;                        /* def: default-Wert                      */
{
    int c, i;
    int pos = 0;                    /* pos: Eingabeposition (0 .. 2)      */
    int by = 0;                     /* by: Puffer fuer Byte               */
 
    printf("  \b\b");               /* Feld loeschen                      */
    while ((c = scan()) != CR) {    /* CR beendet eingabe                 */
        for (i = 0; i < 16; i++) {
            if (hexu[i] == c || hexl[i] == c ) {
                                    /* Falls Hex-Ziffer                   */
                if(pos != 2) {
                    by = 16 * by + i;
                                    /* Nibble abspeichern                 */
                    pos++;
                    putchar(c);
                }
            }
        }
        if (c == BS) {
            if(pos) {               /* Backspace: Mibble loeschen         */
                putchar('\b');
                by /= 16;
                pos--;
            }
        }
        if (c == ESC) {
            while (pos) {           /* ESC: default-Werte holen           */
                pos--;
                putchar(LEFT);
            }
            printf("%02x", by = def);
                                    /* Und als Byte abspeichern           */
            pos = 2;
        }
    }
    return(by);
}
 
editby()                            /* Byte editieren                     */
{
    char *p;                        /* Adresse des aktuellen Bytes        */
 
    p = buffer + cursx + cursy * 16;
    *p = readby((int)*p & 0xff);    /* Byte editieren                     */
}
 
setts()                             /* Track und Sektor setzen            */
{
    goxy(31,1);                     /* Cursor auf Track-Feld              */
    track = readby(track) % tracks; /* Track eingeben                     */
    dispts();                       /* Eingegebenen Wert anzeigen         */
    goxy(36,1);                     /* Dasselbe mit der Sektornummer      */
    sect = readby(sect) % (diskpar->spt);
    dispts();
}
 
reads()                             /* Sektor lesen                       */
{
    int stat;                       /* stat: Status beim Lesen            */
 
    setsek();                       /* Sektorparameter setzen             */
    stat = bios(13, 0);             /* BIOS Fkt. #13 (Read sector)        */
    if (stat) {                     /* Falls stat == 1: Fehler            */
        putchar(HOME);
        clrel();
        printf("READ ERROR AUF <T:%02x,S:%02x>", track, sect);
    }
    return(stat);
}
 
setsek()                            /* Sektorparameter setzen             */
{
    bios(9, drive);                 /* BIOS Fkt. #9 (Select disk drive)   */
    bios(10, track);                /* BIOS Fkt. #10 (Set trach number)   */
    bios(11, sectxlt(xtable, sect));
                                    /* BIOS Fkt. #11 (Set sector number)  */
    biosl(12, buffer);              /* BIOS Fkt. #12 (Set DMA address)    */
}
 
writes()                            /* Sektor schreiben                   */
{
    int stat;                       /* stat: Status beim Schreiben        */
 
    setsek();                       /* Sektorparameter setzen             */
    stat = bios(14, 1);             /* BIOS Fkt. #14 (Write sector)       */
                                    /* Directory-Sektor schreiben (1)     */
    if (stat) {                     /* stat == 1: Schreibfehler           */
        putchar(HOME);
        clrel();
        printf("WRITE ERROR AUF <T:%02x,S:%02x>", track, sect);
    }
}
 
ask()                               /* Sicherheitsabfrage                 */
{
    int c;
 
    putchar(HOME);                  /* Ueberschrift loeschen              */
    clrel();
    printf("SIND SIE SIICHER <J/N> ? ");
    c = scan();                     /* Keyboard abfragen                  */
    printhl();                      /* Uberschrift wieder schreiben       */
    return(c == 'j' || c == 'J');
                                    /* Rueckgabe: 1:JA, 0: Sonst          */
}
 
printhl()                           /* Ueberschrift ausgeben              */
{
    putchar(HOME);
    puts("DISKEDITOR CP/M 68k, MATTHIAS KOEFFERLEIN 1986");
}
 
seldsk()                            /* Drive auswaehlen                   */
{
    goxy(50, 1);                    /* Cursor auf Feld positionieren      */
    drive =readby(drive) & 0xf;     /* Drivenummer einlesen (0 .. 15)     */
    login();
}
 
login()                             /* Login fuer aktuelle Disk           */
{
    int stat;
    struct dph *p;                  /* Zeiger auf DPH                     */
 
    track = 0;                      /* Track und Sektor auf 0 setzen      */
    sect = 0;
    dispts();                       /* Und anzeigen                       */
    p = bios(9, drive);             /* BIOS Fkt. #9 (Select disk drive)   */
    xtable = p->xlt;                /* Addresse der translation table     */
    diskpar = p->diskp;             /* Addresse des DPB                   */
    diskdpb();                      /* DPB anzeigen                       */          
}

diskdpb()                           /* DPB anzeigen                       */
{
    int bls;                        /* bls: Blockgroesse                  */
 
    bls = 128 << (diskpar->bsh);    /* Blockgroesse berechnen             */
    goxy(66,17);                    /* SPT ausgeben                       */
    printf("%02x", diskpar->spt);
    goxy(66,18);                    /* BSH ausgeben                       */
    printf("%04x", bls);
    goxy(66,19);                    /* DSM ausgeben (in kBytes)           */
    printf("%04x", ((diskpar->dsm) + 1) * (bls >> 10));
    goxy(66,20);                    /* DRM ausgeben (Dir.-entries)        */
    printf("%04x", (diskpar->drm) + 1);
    goxy(66,21);                    /* OFF ausgeben (resrvd tracks)       */
    printf("%02x", diskpar->off);
    tracks = (diskpar->off) * 
            ((long) ((diskpar->dsm) + 1) * bls) / (128 * (diskpar->spt));
                                    /* Anzahl der Tracks berechnen        */
    goxy(66,22);                    /* Und ausgeben                       */
    printf("%04x", tracks);
}
