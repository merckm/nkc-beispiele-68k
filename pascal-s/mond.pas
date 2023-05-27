program mondlandung(input, output);
 
{ Vereinbarubgs - Baustein }
 
const   { Konstanden definieren }
    grav=1.6;
    anfhoehe=1000;
    anftreib=80;
 
var     { Variable definieren }
    hoehe   : real;
    treibst : real;
    geschw  : real;
    schub   : real;
 
{ Programm - Baustein }
 
begin
    writeln('Mondlandespiel');
    hoehe := anfhoehe;
    geschw := 0;
    treibst := anftreib;
    repeat
        if treibst < 0 then treibst := 0;
        writeln('Hoehe:      ',hoehe:8:2,' m');
        writeln('Geschw.:    ',geschw:8:2,' m/s');
        writeln('Treibstoff: ',treibst:8:2);
        writeln;
        repeat
            write('Schub in m/s (-9..+9): ');
            read(schub);
        writeln;
        until abs(schub)<10;
        if treibst > 0 then
            geschw:=geschw+schub;
        geschw:=geschw-grav;
        hoehe:=hoehe+geschw;
        treibst:=treibst-1-abs(schub)*0.1;
    until hoehe <= 0;
    if (abs(hoehe)<0.5) and (abs(geschw)<1) then
        writeln('Gut gelandet')
    else begin 
        writeln('Bruchlandung mit');
        writeln(geschw:8:2,' m/s');        
        writeln(hoehe:8:2,' m');
    end;
end.
