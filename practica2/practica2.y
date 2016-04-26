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
%token  ID
%token  DEFINE
%token  NUM_ENTERO
%token  NUM_REAL
%token  CADENA
%token  INT
%token  FLOAT
%token  CHAR
%token  MAIN
%token  OPERADOR
%token  OPERADOR2
%token  PRINTF
%token  IF
%token  FOR
%token  ELSE
%token  SCANF
%token  WHILE
%token  CDC


%%
programa:	declaracionesCtes declaracionVbles main {printf("\n Todo correcto numero de lineas %d\n",nLineas);}
            ;
declaracionesCtes: /*vacia*/
                   | declaracionCte declaracionesCtes
                   ;
declaracionCte:    '#' DEFINE ID valor_cte {printf("\nDeclaracion cte");}
                   ;
valor_cte:         NUM_ENTERO
                   | NUM_REAL
                   | CADENA
                   ;
declaracionVbles:  /*vacia*/
                   | declaracionVble declaracionVbles
                   ;
declaracionVble:   tipo listID ';' {printf("\nDeclaracion vble");}
                   ;
tipo:              INT
                   | FLOAT
                   | CHAR
                   ;
listID:            id
                   | id ',' listID
                   ;
id:                ID
                   | asig
                   ;
main:              MAIN '{' cuerpo '}'
                   ;
cuerpo:            declaracionVbles instrucciones
                   ;
instrucciones:     instruccion
                   | instruccion instrucciones
                   ;
instruccion:       asig ';' {printf("\nAsignacion");}
                   | visu ';' {printf("\nVisualizacion");}
                   | lect ';' {printf("\nLectura");}
                   | cond {printf("\nCondicion");}
                   | repe 
                   ;
asig:              ID '=' expr
                   | ID OPERADOR2
                   ;
expr:              val
                   | val OPERADOR expr
                   ;
val:               ID
                   | valor_cte
                   ;
visu:              PRINTF '(' listExpr ')'
                   ;
listExpr:          /*vacia*/
                   | expr
                   | expr ',' listExpr
                   ;
lect:              SCANF '(' CDC  ',' OPERADOR ID ')'
                   ;
cond:              bloqueIF {printf("\nBloque IF");}
                   | bloqueIF else {printf("\nBloque IF+ELSE");}
                   ;
bloqueIF:          IF '(' expr ')' '{' instrucciones '}' 
                   ;
else:              ELSE '{' instrucciones '}' 
                   | ELSE cond 
                   ;
repe:              for {printf("\nRepeticion: bloque FOR");}
                   | while {printf("\nRepeticion: bloque WHILE");}
                   ;
for:               FOR '(' inicia ';' expFOR ';' increm ')' '{' instrucciones '}'  
                   ;
inicia:            /*vacia*/ 
                   | asig
                   ;
expFOR:            /*vacia*/ 
                   | expr
                   ;
increm:            /*vacia*/
                   | ID OPERADOR2
                   ;
while:             WHILE '(' expr ')' '{' instrucciones '}' 
                   ;


%%

int main()
{
    yyin=fopen("practica2.c","r");
    yyparse();
 
}


