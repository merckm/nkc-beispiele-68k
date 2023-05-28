program hanoi(input,output);
  
 var total:integer;

procedure schiebe(hoehe,von,nach,mit:integer); 
begin 
 if hoehe > 0
  then begin
   schiebe(hoehe-1,von,mit,nach);
   writeln('von ',von,' nach ',nach);
   schiebe(hoehe-1,mit,nach,von);
  end;
 end;
 
begin
 repeat
  writeln;
  write('Turmhoehe ');
  read(total);
  writeln;
  schiebe(total,1,3,2);
 until total > 5;
end.
