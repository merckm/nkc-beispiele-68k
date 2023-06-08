/* Ansprechen des Druckers unter C   */
/* Rolf-Dieter Klein  860116    1.0  */
/*                                   */
/* Einfuehrung in C, Teil 4          */
/* Loop 07, Seite 19                 */
 
#include <stdio.h>
  
int main(int argc, char const *argv[])
{
    FILE *fopen();
    FILE *drucker;

    drucker = fopen("lst:","w");

    fprintf(drucker,"Hallo es geht\n");
    fprintf(drucker,"-------------\n");
}
