/* Kleines C-Beispiel */

#include <stdio.h>

main()
{
    int i;
    for(i=1; i<36; i++)
    {
        printf("\001 E @schreite 10\n");
        printf("\001 E @drehe 10\n");
    }
    printf("\001 E @setflip 0 0\n\001 E @newpage 0 0\n\001 E @grapoff\n");
}