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

int num_sim = 0;
extern int nLineas;

struct simbolo{
    char nombre[30];
    int tipo;
    int cte;
    int inicializado;
};
struct simbolo tablaSimbolos[50];
int dim = 0;

int buscarSimbolo(struct simbolo tablaSimbolos[],char nombre[30],int dim);

%}

%union {
	   int tipo; // 1.int 2.float 3.char
     char nombreId[30];
	}

%token <nombreId> ID
%token            DEFINE
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
%type <tipo> tipo valor_cte

%%
programa:	declaracionesCtes {printf("\n Todo correcto numero de lineas %d\n",nLineas);}
            ;
declaracionesCtes: /*vacia*/
                   | declaracionCte declaracionesCtes
                   ;
declaracionCte:    '#' DEFINE ID valor_cte  { printf("\nDeclaracion cte");
                                              int pos = buscarSimbolo(tablaSimbolos, $3, dim);
                                              if (pos != dim){
                                                  printf("\n ERROR lin: %d: identificador redeclarado\n",nLineas);
                                              }
                                              else {
                                                  //lo añado
                                                  printf("\n Añado %s",$3);
                                                  tablaSimbolos[dim].tipo = $4;
                                                  tablaSimbolos[dim].cte  = 1;
                                                  tablaSimbolos[dim].inicializado = 1;
                                                  strcpy(tablaSimbolos[dim].nombre,$3);
                                                  dim++;
                                              }
                                            }
                   ;
valor_cte:         NUM_ENTERO { $$ = 1; }
                   | NUM_REAL { $$ = 2; }
                   | CADENA   { $$ = 3; }
                   ;
declaracionVbles:  /*vacia*/
                   | declaracionVble declaracionVbles
                   ;
declaracionVble:   tipo id ';'  { printf("\nDeclaracion vble");

                                }
                   ;
tipo:              INT     { $$ = 1; }
                   | FLOAT { $$ = 2; }
                   | CHAR  { $$ = 3; }
                   ;
listID:            id      
                   | id ',' listID
                   ;
id:                ID            { 

                                 }
                   | ID '=' expr {

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
cuerpo:            /*vacía*/
                   | declaracionVbles instrucciones
                   ;
instrucciones:     /*vacía*/
                   | instruccion
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

int buscarSimbolo(struct simbolo tablaSimbolos[],char nombre[50],int dim){
    for (int i=0;i<dim;i++){
        if (strcmp(nombre,tablaSimbolos[i].nombre) == 0){
            return i;
        }
    }
    return dim;
}

