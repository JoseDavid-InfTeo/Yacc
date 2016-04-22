%{

#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <stdio.h>

void yyerror(const char* msg) {
    fprintf(stderr, "%s\n", msg);
}
int yylex(void);
FILE *yyin;

extern int nLineas;

%}


%token 	ID
%token  DEFINE
%token 	NUM




%%
programa:	declaracionesCtes {printf("\n Todo correcto numero de lineas %d",nLineas);}
   ;
declaracionesCtes: /*vacia*/
                  | declaracionCte declaracionesCtes
                  ;
declaracionCte: '#' DEFINE ID NUM {printf("\nDeclaracion cte");}
                ;


%%

int main()
{
    yyin=fopen("ejemplo.c","r");
    yyparse();
 
}


