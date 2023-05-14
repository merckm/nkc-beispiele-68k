program fakultaet(input,output);
 
var i:integer;
    r:real;
 
function fac(a:real):real;
begin
    if a=0
        then fac:=1.0
        else fac:=fac(a-1)*a
end;
 
begin
    repeat
        writeln;
        write('fac von: ');
        read(i);
        writeln;
        r:=fac(i);
        writeln(' ist ',r);
        writeln(' ist ',r:14:0);
    until false
end.