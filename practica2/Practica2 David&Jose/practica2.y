%{

#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include "practica2.h"

void yyerror(const char* msg) {
    fprintf(stderr, "%s\n", msg);
}
int yylex(void);
FILE *yyin;

int num_sim = 0;
extern int nLineas;

%}

%union {
	   int tipo; // 1.int 2.float 3.char
     struct simbolo *indice;
	}

%token <indice> ID
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
%type <tipo> tipo
%type <indice> id

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
declaracionVble:   tipo id ';' {printf("\nDeclaracion vble");
                                $2->tipo = $1;
					                     	buscar_simbolo($2);}
                   ;
tipo:              INT     { $$ = 1; }
                   | FLOAT { $$ = 2; }
                   | CHAR  { $$ = 3; }
                   ;
listID:            id      
                   | id ',' listID
                   ;
id:                ID            { $$->inic = 0;  
                                   strcpy($$->id, $1->id);
                                 }
                   | ID '=' expr { $$->inic = 1; 
                                   strcpy($$->id, $1->id);
                                 }
                   ;
expr:              val
                   | val OPERADOR expr
                   ;
val:               ID
                   | valor_cte
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

struct simbolo *buscar_simbolo(struct simbolo simbo)
{
  int i;
  if (num_sim == MAX_SIM)
  {
     yyerror("\nDemasiados simbolos");
     exit(1);
  }
  else{
  
    for (i = 0; i<num_sim; i++)
    {
       if ((strcmp(simbo.id,tabla_simbolos[i].id) == 0)) 
       {
          printf("\n Linea %d. ID ya declarado", nLineas);  

          /*strcmp devuelve 0 si son iguales */
          return &tabla_simbolos[i];          
       }
    }
    strcpy(tabla_simbolos[num_sim].id,simbo.id);  //copiamos nombre id
    tabla_simbolos[num_sim].tipo = simbo.tipo;    //copiamos tipo id
    tabla_simbolos[num_sim].inic = simbo.inic;    //copiamos inic del id
    /* tabla_simbolos[num_sim].id = strdup(s);*/
    num_sim++;
    return &tabla_simbolos[num_sim-1];
   
  }

}

