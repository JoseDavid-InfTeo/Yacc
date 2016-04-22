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
%token 	NUM_ENTERO
%token  NUM_REAL
%token  CADENA
%token  INT
%token  FLOAT
%token  CHAR



%%
programa:	declaracionesCtes declaracionVbles {printf("\n Todo correcto numero de lineas %d\n",nLineas);}
            ;
declaracionesCtes: /*vacia*/
                   | declaracionCte declaracionesCtes
                   ;
declaracionCte:    '#' DEFINE ID NUM_ENTERO {printf("\nDeclaracion cte entera");}
                   | '#' DEFINE ID NUM_REAL {printf("\nDeclaracion cte real");}
                   | '#' DEFINE ID CADENA {printf("\nDeclaracion cte cadena");}
                   ;
declaracionVbles:  /*vacia*/
                   | declaracionVble declaracionesVbles
                   ;
declaracionVble:   tipo listID {printf("\nDeclaracion vble");}
                   ;
tipo:              INT {printf("\n-INT-");}
                   | FLOAT {printf("\n-FLOAT-");}
                   | CHAR {printf("\n-CHAR-");}
                   ;
listID:            id
                   | id ',' listID
                   ;
id:                ID
                   | ID '=' NUM_ENTERO
                   | ID '=' NUM_REAL
                   | ID '=' CADENA
                   ;

%%

int main()
{
    yyin=fopen("ejemplo.c","r");
    yyparse();
 
}


