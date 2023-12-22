(****************************************)
(* PASCAL-PROGRAMM,SPEICHERPLATZ $9C90, *)
(* WIRD ALS 2.PROGRAMM GELADEN          *)
(****************************************)
 
program SQASH(INPUT,OUTPUT);
var ENDE,GESCHWINDIGKEIT,ZAEHLER,A:integer;
    POSX,POSITIONX,POSITIONY:integer;
    ANTWORT,PAUSE,START:integer;
    LAENGE,ABSTAND,ABFRAGE:integer;
    SEED:real;
 
procedure UMRANDUNG;
  var X,Y:integer;
  begin
    writeln(chr(1),'E @SETFLIP');
    for X:=5 to 9 do begin
      Y:=3;
      writeln(chr(1),'E @MOVETO ',0,' ',X,' ',Y);
      Y:=255;
      writeln(chr(1),'E @DRAWTO ',0,' ',X,' ',Y);
    end;
    for Y:=241 to 245 do begin
      X:=5;
      writeln(chr(1),'E @MOVETO ',0,' ',X,' ',Y);
      X:=505;
      writeln(chr(1),'E @DRAWTO ',0,' ',X,' ',Y);
    end;
    for X:=501 to 505 do begin
      Y:=3;
      writeln(chr(1),'E @MOVETO ',0,' ',X,' ',Y);
      Y:=241;
      writeln(chr(1),'E @DRAWTO ',0,' ',X,' ',Y);
    end;
    for Y:=255 to 255 do begin
      X:=5;
      writeln(chr(1),'E @MOVETO ',0,' ',X,' ',Y);
      X:=65;
      writeln(chr(1),'E @DRAWTO ',0,' ',X,' ',Y);
    end;
    for X:=60 to 65 do begin
      Y:=241;
      writeln(chr(1),'E @MOVETO ',0,' ',X,' ',Y);
      Y:=255;
      writeln(chr(1),'E @DRAWTO ',0,' ',X,' ',Y);
    end;
  end;
 
procedure SCHLAEGER1;
  begin
    if POSX <= 9
      then
        begin
          POSX:=10;
        end;
    if POSX >= ABSTAND
      then
        POSX:=ABSTAND;
    writeln(chr(1),'E LOESCHEN ',0,' ',POSX-A,' ',LAENGE);
    writeln(chr(1),'E SCHREIBEN ',0,' ',POSX,' ',LAENGE);
  end;
 
procedure TASTATUR;
  begin
    writeln(chr(1),'G $FFFFFF68');
    read(A);
    if A >= 128
      then
        A:=0
      else
        A:=A-53;
    A:=A*15;
    POSX:=POSX+A;
    SCHLAEGER1;
  end;
 
procedure PUNKTE;
  begin
    if (POSITIONX>=POSX) AND (POSITIONX<=POSX+LAENGE)
    then
    else
      begin
        ENDE:=ENDE+1;
        writeln(chr(27),'=', CHR(32+0),CHR(32+0),ENDE:4);
      end;
  end;
 
procedure HOCH;
  begin
    while (POSITIONX>=20) AND (POSITIONY<=235) do
      begin
        writeln(chr(1),'E BALL ',2,' ',POSITIONX,' ',POSITIONY);
        TASTATUR;
        POSITIONX:=POSITIONX+0;
        POSITIONY:=POSITIONY+GESCHWINDIGKEIT;
      end;
  end;
 
procedure RUNTER;
  begin
    while (POSITIONX>=20) AND (POSITIONY>=ABFRAGE) do
      begin
          writeln(chr(1),'E BALL ',2,' ',POSITIONX,' ',POSITIONY);
          TASTATUR;
          if POSITIONY=ABFRAGE then
              PUNKTE;
          POSITIONX:=POSITIONX+0;
          POSITIONY:=POSITIONY-GESCHWINDIGKEIT;
      end;
  end;
 
procedure RECHTSHOCH;
  begin
    while (POSITIONX<=490) AND (POSITIONY<=235) do
      begin
          writeln(chr(1),'E BALL ',2,' ',POSITIONX,' ',POSITIONY);
          TASTATUR;
          POSITIONX:=POSITIONX+GESCHWINDIGKEIT;
          POSITIONY:=POSITIONY+GESCHWINDIGKEIT;
      end;
  end;
 
procedure LINKSHOCH;
  begin
    while (POSITIONX>=20) AND (POSITIONY<=235) do
      begin
          writeln(chr(1),'E BALL ',2,' ',POSITIONX,' ',POSITIONY);
          TASTATUR;
          POSITIONX:=POSITIONX-GESCHWINDIGKEIT;
          POSITIONY:=POSITIONY+GESCHWINDIGKEIT;
      end;
  end;        
 
procedure LINKSRUNTER;
  begin
    while (POSITIONX>=20) AND (POSITIONY>=ABFRAGE) do
      begin
          writeln(chr(1),'E BALL ',2,' ',POSITIONX,' ',POSITIONY);
          TASTATUR;
          if POSITIONY=ABFRAGE then
              PUNKTE;
          POSITIONX:=POSITIONX-GESCHWINDIGKEIT;
          POSITIONY:=POSITIONY-GESCHWINDIGKEIT;
      end;
  end;
 
procedure RECHTSRUNTER;
  begin
    while (POSITIONX<=490) AND (POSITIONY>=ABFRAGE) do
      begin
          writeln(chr(1),'E BALL ',2,' ',POSITIONX,' ',POSITIONY);
          TASTATUR;
          if POSITIONY=ABFRAGE then
              PUNKTE;
          POSITIONX:=POSITIONX+GESCHWINDIGKEIT;
          POSITIONY:=POSITIONY-GESCHWINDIGKEIT;
      end;
  end;
 
function RANDOM:integer;
  begin
    SEED:=SEED*27.182813+31.415917;
    SEED:=SEED-trunc(SEED);
    RANDOM:=trunc(SEED*6);
  end;
 
begin
  repeat
    writeln(chr(1),'E @CLRSCREEN');
    writeln(chr(1),'E NAME');
    for ZAEHLER:=1 to 15000 do;
    writeln(chr(1),'E @CLRSCREEN');
    writeln(chr(27),'=',CHR(32+4),CHR(32+0),'GESTEUERT WIRD MIT DEN TASTEN:');
    writeln(chr(27),'=',CHR(32+6),CHR(32+0),'  L I N K S  =  4');
    writeln(chr(27),'=',CHR(32+8),CHR(32+0),'R E C H T S  =  6');
    writeln(chr(27),'=',CHR(32+10),CHR(32+0),'    S T O P  =  5');
    write(chr(27),'=',CHR(32+12),CHR(32+0),'WAEHLEN SIE DEN SCHWIERIGKETS');
    write('GRAD:');
    writeln;
    write(chr(27),'=',CHR(32+14),CHR(32+0),'1 = LEICHT , 2 = SCHWER  <>  ');
    readln(GESCHWINDIGKEIT);
    if GESCHWINDIGKEIT=1
      then
        begin
          ABFRAGE:=15;
          GESCHWINDIGKEIT:=5;
        end
      else
        begin
          ABFRAGE:=20;
          GESCHWINDIGKEIT:=10;
        end;
    write(chr(27),'=',CHR(32+16),CHR(32+0),'WAEHLEN SIE DIE SCHLAEGERGROESSE.');
    writeln;       
    write(chr(27),'=',CHR(32+18),CHR(32+0),'1 = KLEIN , 2 = GROSS   <>  ');
    readln(LAENGE);
    if LAENGE=1
      then
        begin
          LAENGE:=15;
          ABSTAND:=485;
        end
      else
        begin
          LAENGE:=25;
          ABSTAND:=475;
        end;
    writeln(chr(27),'=',CHR(32+20),CHR(32+0),'DRUECKEN SIE DIE TASTE > 5 <');
    writeln(chr(27),'=',CHR(32+22),CHR(32+0),'UND DAS SPIEL BEGINNT.');
    repeat
      writeln(CHR(1),'G $FFFFFF68');
      read(START);
    until START=53;
    POSX:=300;
    POSITIONX:=95;
    POSITIONY:=100;
    ENDE:=0;
    SEED:=1.2345678;
    writeln(chr(1),'E @CLRSCREEN');
    UMRANDUNG;            
    writeln(chr(27),'=',CHR(32+0),CHR(32+0),ENDE:4);
    repeat
      case RANDOM of
        0:RUNTER;
        1:RECHTSHOCH;
        2:HOCH;
        3:LINKSRUNTER;
        4:LINKSHOCH;
        5:RECHTSRUNTER;
      end;
    until ENDE=15;
    for PAUSE:=1 to 10000 do;
    writeln(chr(1),'E @CLRSCREEN');
    writeln(chr(27),'=',CHR(32+12),CHR(32+0),'WOLLEN SIE NOCHMAL');
    writeln(chr(27),'=',CHR(32+14),CHR(32+0),'SPIELEN ?    (J/N)');
    repeat
      writeln(CHR(1),'G $FFFFFF68');
      read(ANTWORT);
    until (ANTWORT=74) OR (ANTWORT=78);
    writeln(chr(1),'E @CLRSCREEN');
  until ANTWORT=78;
  writeln(chr(27),'=',CHR(32+12),CHR(32+0),'ES WAR WIN VERGNUEGEN,');
  writeln(chr(27),'=',CHR(32+14),CHR(32+0),'MIT IHNEN ZU SPIELEN');
end.