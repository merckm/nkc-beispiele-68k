(****************************************)
(* PASCAL-PROGRAMM,SPEICHERPLATZ $9C90, *)
(* WIRD ALS 2.PROGRAMM GELADEN          *)
(****************************************)
 
program SQASH(INPUT,OUTPUT)
var ENDE,GESCHWINDGKEIZ,ZAEHLER,A:integer;
    POSITIONX,POSITIONY:integer;
    ANTWORT,PAUSE,START:integer;
    ABSTAND,ABFRAGE:integer;
    SEED:real;
procedure UMRANDUNG;
    var X,Y:integer;
    begin
        writeln(chr(1),'E @SETFLIP');
        for X:=5 to 9 do begin
            Y:=3;
            writeln(chr(1),'E @MOVETO',0,' ',X,' ',Y);
            Y:=255;
            writeln(chr(1),'E @DRAWTO',0,' ',X,' ',Y);
        end;
        for Y:=241 to 245 do begin
            X:=5;
            writeln(chr(1),'E @MOVETO',0,' ',X,' ',Y);
            Y:=505;
            writeln(chr(1),'E @DRAWTO',0,' ',X,' ',Y);
        end;
        for X:=501 to 505 do begin
            Y:=3;
            writeln(chr(1),'E @MOVETO',0,' ',X,' ',Y);
            Y:=241;
            writeln(chr(1),'E @DRAWTO',0,' ',X,' ',Y);
        end;
        for Y:=255 to 255 do begin
            X:=5;
            writeln(chr(1),'E @MOVETO',0,' ',X,' ',Y);
            Y:=65;
            writeln(chr(1),'E @DRAWTO',0,' ',X,' ',Y);
        end;
        for X:=60 to 65 do begin
            Y:=241;
            writeln(chr(1),'E @MOVETO',0,' ',X,' ',Y);
            Y:=255;
            writeln(chr(1),'E @DRAWTO',0,' ',X,' ',Y);
        end;
    end;
procedure SCHLAEGER1;
    begin
        if POSX <= 9 then
            posx:=10;
        if POSX >= ABSTAND then
            POSX:=ABSTAND;
        writeln(chr(1),'E LOESCHEN',0,' ',POSX-A,' ',LAENGE);
        writeln(chr(1),'E SCHREIBEN',0,' ',POSX,' ',LAENGE);
    end;
procedure TASTATUR;
    begin
        
    end;