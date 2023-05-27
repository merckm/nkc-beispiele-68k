program taschenrechner(input, output);
 
{ Vereinbarubgs - Baustein }
  
var
 ch : char;
 a : real;
 
{ Unterprogramm - Baustein }
 
procedure getchar;  { Zeichen einlesen }
 begin
  read(ch);
 end;
 
procedure expr(var exprval : real);  { Ausdruck }
 var
  nexttermval : real;
  ch1 : char;
 
 procedure term(var termval : real);  { Term }
  var
   nextfacval : real;
   ch2 : char;
 
  procedure factor(var facval : real);  { Faktor }
   var
    fac1val : real;
 
   begin
    if ch ='(' then begin
     getchar;
     expr(facval);
     if ch=')'
      then getchar
      else writeln('Fehler ) fehlt ')
     end else begin
      facval:=0;
      while (ord(ch)>=ord('0')) and (ord(ch) <=ord('9')) do begin
       facval := facval * 10 + ord(ch) - ord('0');
       getchar;
     end;
     if ch='.' then begin
      fac1val:=10.0;
      getchar;
      while (ord(ch)>=ord('0')) and (ord(ch) <=ord('9')) do begin
       facval := facval + (ord(ch)-ord('0'))/fac1val;
       fac1val:=fac1val*10;
       getchar;
      end;
     end;
    end;
   end;
 
  begin {* term *}
   factor(termval);
   while (ch='*') or (ch='/') do begin
    ch2 := ch;
    getchar;
    factor(nextfacval);
    if ch2='*'
     then termval:=termval*nextfacval
     else termval:=termval/nextfacval
   end;
  end; 
 
 begin {* expr *}
  ch1:=ch;
  if (ch='+') or (ch='-') then getchar;
  term(exprval);
  if ch1='-' then exprval:=-exprval;
  while (ch='+') or (ch='-') do begin
   ch1 := ch;
   getchar;
   term(nexttermval);
   if ch1='+' 
    then exprval := exprval + nexttermval
    else exprval := exprval - nexttermval
  end;
 end;
 
{ Programm - Baustein }
 
begin
 writeln('Taschenrechner');
 repeat
  write(':');   { Bereitmeldung }
  getchar;      { Erstes Zeichen lesen }
  expr(a);      { dann Ausdruck auswerten }
  writeln;      { Zeilenvorschub }
  writeln(' = ',a);      { Ergebnis ausgeben } 
  writeln(' = ',a:14:8); { auf verschiedene Art }
 until false    { unbegrenzt wiederholen }
end.
