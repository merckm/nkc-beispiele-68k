/* Recursive Routinen in C  */
/* Beispiel Baum ausgeben   */
/* Rolf-Dieter Klein 851128 */
/*                          */
/* Einfuehrung in C, Teil 3 */
/* Loop 06, Seite 16        */

#include <stdio.h>

EXTERN initturt();
EXTERN schreite();
EXTERN drehe();

baum(laenge, anzahl) int laenge, anzahl;
{
    if (anzahl > 0)
    {
        schreite(laenge);
        drehe(30);
        baum((laenge * 2) / 3, anzahl - 1);
        drehe(-60);
        baum((laenge * 2) / 3, anzahl - 1);
        drehe(30);
        schreite(-laenge);
    }
}

main()
{
    int laenge, anzahl;
    char buffer[80];        /* fuer gets() */
    initturt();
    printf("\001E @clrscreen\n");
    printf("\001E @setflip 0 0\n\001E @newpage 0 0\n\001E @grapoff\n");
    do
    {
        printf("\nneuer Baum:\n");
        printf("Laenge: ");
        gets(buffer);
        sscanf(buffer, "%d", &laenge);
        printf("\n");
        printf("Anzahl: ");
        gets(buffer);
        sscanf(buffer, "%d", &anzahl);
        printf("\n");
        printf("\001E @clrscreen\n");
        printf("Baum mit Laenge=%d, Anzahl=%d\n", laenge, anzahl);
        printf("\001E @hebe\n\001E @aufxy 0 255\n\001E @senke\n");
        baum(laenge, anzahl);
        printf("\001E @setflip 0 0\n\001E @newpage 0 0\n\001E @grapoff\n");
    } while (laenge != 0);
}