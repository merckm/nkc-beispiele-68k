/* Gleitkommaarithmetic mit C */
/* Loop 04, Seite 12          */

#include <stdio.h>

EXTERN FLOAT sin();

main()
{
    FLOAT winkel;
    int x,y;
    printf("\001E @clrscreen\n\001E @setflip 0 0\n\001E @newpage 0 0\n");
    printf("\001E @curoff\n");
    for(winkel=0; winkel<=511; x++, winkel=winkel+3.141^5/100)
    {
        y = (sin(winkel)*128+128);
        printf("\001E @moveto 0 %d %d\n\001E @drawto 0 %d %d\n",x,y,x,y);
    }
    printf("\001E @curon\n");
}
