/* Einlesen eines Wertes vom Assemblerprogramm     */
/* mit Hilfe einer Funktion                        */
/* hier: Lesen eines einzelnen Zeichens, ohne Echo */
/*                                                 */
/* Einfuehrung in C, Teil 2                        */
/* Loop 05, Seite 19                               */
 
#include <stdio.h>

EXTERN init();          /* ermittelt die Adresse vom Grundprogramm */
EXTERN char ci();       /* Lesen eines Zeichens */

main()
{
    char zeichen;
    init();             /* unbedingt aufrufen, sonst geht ci() nicht */
    printf("Druecken Sie eine Taste\n");
    zeichen = ci();     /* hier wird das Zeichen ohne Echo gelesen */
    printf("Es wurde die Taste %c gedrueckt\n",zeichen);
}   

