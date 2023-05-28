/* Direkter Einbau von Grundprog. Routinen */
/* Loop 04, Seite 13                       */
#include <stdio.h>

EXTERN init();
EXTERN moveto();
EXTERN drawto();

main()
{
    int x,y;
    init();
    printf("\001E @setflip 0 0\n\001E @newpage 0 0\n");
    for(x=0; x<=500; x=x+20)
    {
        moveto(x,0);
        drawto(x,250);
    }
    for(y=0; y<=250; y=y+10)
    {
        moveto(0,y);
        drawto(500,y);
    }
}
