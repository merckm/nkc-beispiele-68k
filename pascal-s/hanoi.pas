program hanoi(input,output);
 
 const
  x1 = 200;     (* Lage der Tuerme in x-Richtung *)
 
  y0 = 40;      (* Hoehe der Tuerme *)
  yoben = 200;  (* Hoehe max der Tuerme *)
 
 
 var total:integer;
 x,y: integer;
 
 h: array[1..3] of integer;     (* hoehe *)
 
 
procedure setturm;              (* Startturm *)
var i:integer;
 
begin
 for i:=1 to total do begin
  writeln(chr(1),'E assplatte ',(1+total-i)*2,' ',x1,' ',y0+i*14); 
  writeln(chr(1),'E assfest');
 end;
 writeln(chr(27),'=',chr(32+23),chr(32+31),' 1        2        3');
 h[1]:=total;
 h[2]:=0;
 h[3]:=0;
end;
 
procedure platte(hoehe,von,nach:integer);
 
 var x,y,i:integer;
  dx:integer;
  xziel:integer;
 
begin 
 for y:=h[von]*14+y0 to yoben do 
  writeln(chr(1),'E assplatte ',hoehe*2,' ',x1+50*(von-1),' ',y); 
 h[von]:=h[von]-1;
 x:=x1+50*(von-1);
 xziel:=x1+50*(nach-1);
 if xziel < x then dx:=-1 else dx:=1;
 repeat
  writeln(chr(1),'E assplatte ',hoehe*2,' ',x,' ',yoben);
  x:=x+dx;
 until x=xziel;
 h[nach]:=h[nach]+1;
 for y:=yoben downto h[nach]*14+y0 do
  writeln(chr(1),'E assplatte ',hoehe*2,' ',x1+50*(nach-1),' ',y);
 writeln(chr(1),'E assfest');
end;
 
 
 
procedure schiebe(hoehe,von,nach,mit:integer); 
begin 
 if hoehe > 0
  then begin
   schiebe(hoehe-1,von,mit,nach);
   writeln(chr(27),'=  ');
   writeln('von ',von,' nach ',nach);
   platte(hoehe,von,nach);
   schiebe(hoehe-1,mit,nach,von);
  end;
end;
 
begin
 repeat
  writeln;
  write('Turmhoehe ');
  read(total);
  writeln(chr(1),'E assinit');
  setturm;
  writeln;
  schiebe(total,1,3,2);
 until total > 5;
end.
