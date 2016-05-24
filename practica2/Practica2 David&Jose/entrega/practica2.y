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

int errores = 0;

%}

%union {
		 int tipo; // 1.int 2.float 3.char
		 char nombreId[30];
	}

%token  <nombreId> ID
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
%token  <tipo> CDC
%type   <tipo> tipo valor_cte val expr
%type   <nombreId> id

%%
programa:	declaracionesCtes main {if (errores > 0) {
																		printf("\n Programa compilado con %d errores en %d lineas\n",errores,nLineas);
																	}else{
																		printf("\n Programa compilado sin errores y con %d lineas\n", nLineas);
																	}	
																 }

						;
declaracionesCtes: /*vacia*/
									 | declaracionCte declaracionesCtes
									 ;
declaracionCte:    '#' DEFINE ID valor_cte  { 
																							int pos = buscarSimbolo(tablaSimbolos, $3, dim);
																							if (pos != dim){
																									printf("\n ERROR lin %d: Constante redeclarado",nLineas);
																									errores++;
																							}
																							else {
																									//lo añado
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
declaracionVble:   tipo id ';'  { 
																	int pos = buscarSimbolo(tablaSimbolos, $2, dim);
																	if (pos != dim){
																			printf("\n ERROR lin %d: Identificador redeclarado",nLineas);
																			errores++;
																	}
																	else {
																			//lo añado
																			tablaSimbolos[dim].tipo = $1;
																			tablaSimbolos[dim].cte  = 0;
																			tablaSimbolos[dim].inicializado = 0;
																			strcpy(tablaSimbolos[dim].nombre,$2);
																			dim++;
																	}
																}
									 | tipo id '=' expr ';' {
																						int pos = buscarSimbolo(tablaSimbolos, $2, dim);
																						if (pos != dim){
																								printf("\n ERROR lin %d: Identificador redeclarado",nLineas);
																								errores++;
																						}
																						else {
																							if ($1 != $4){
																								printf("\n ERROR lin %d: No coinciden los tipos", nLineas);
																								errores++;
																							}else if ($4 != 4){ //el tipo 4 es indicador de que no existe la variable
																							  //lo añado
																								tablaSimbolos[dim].tipo = $1;
																								tablaSimbolos[dim].cte  = 0;
																								tablaSimbolos[dim].inicializado = 1;
																								strcpy(tablaSimbolos[dim].nombre,$2);
																								dim++;
																							}
																						}
																          }									
									 ;
tipo:              INT     { $$ = 1; }
									 | FLOAT { $$ = 2; }
									 | CHAR  { $$ = 3; }
									 ;
id:                ID { strcpy($$, $1); }
									 ;
expr:              val { $$ = $1; }
									 | val OPERADOR expr { 	if ($1 < $3)
									 												{
									 													$$ = $3;
									 												}else{
									 													$$ = $1;
									 												}
																			 }
									 ;
val:               ID         { int pos = buscarSimbolo(tablaSimbolos, $1, dim);
																int tipo = tablaSimbolos[pos].tipo;
																if (tipo == 0){
																	printf("\n ERROR lin %d: Variable %s no declarada", nLineas, $1);
																	errores++;
																	tipo = 4;
																}
																if (tablaSimbolos[pos].inicializado == 0){
																	printf("\n ERROR lin %d: Variable %s no inicializada", nLineas, $1);
																	errores++;
																	tipo = 4;
																}
																$$ = tipo;
															}
									 | valor_cte { $$ = $1; }
									 ;
main:              MAIN '{' cuerpo '}'
									 ;
cuerpo: 					 declaracionVbles instrucciones
									 ;
instrucciones:     /*vacía*/
									 | instruccion instrucciones
									 ;
instruccion:       asig ';'
									 | visu ';'
									 | lect ';'
									 | cond 
									 | repe 
									 ;
asig:              ID '=' expr {  int pos = buscarSimbolo(tablaSimbolos, $1, dim);
																	int tipo = tablaSimbolos[pos].tipo;
																	if (tipo == 0){
																		printf("\n ERROR lin %d: Variable %s no declarada", nLineas, $1);
																		errores++;
																	}
																	if (tablaSimbolos[pos].cte == 1){
																		printf("\n ERROR lin %d: No se puede modificar el valor de una constante", nLineas);
																		errores++;
																	}
																	if ((tipo == 1 && $3 == 2) || (tipo == 3 && $3 == 2)){ //Problemas con entero = float y char = float
																		printf("\n ERROR lin %d: No coinciden los tipos", nLineas);
																		errores++;
																	}

																}
									 | ID OPERADOR2
									 ;
visu:              PRINTF '(' listExpr ')'
									 ;
listExpr:          /*vacia*/
									 | expr
									 | expr ',' listExpr
									 ;
lect:              SCANF '(' CDC  ',' OPERADOR ID ')' { int pos = buscarSimbolo(tablaSimbolos, $6, dim);
																												int tipo = tablaSimbolos[pos].tipo;
																												if (tipo == 0){
																													printf("\n ERROR lin %d: Variable %s no declarada", nLineas, $6);
																													errores++;
																												}
																												if ($3 != tipo && tipo != 0){
																													printf("\n ERROR lin %d: Tipos incompatibles en scanf", nLineas);
																													errores++;
																												}																								
																											}
									 ;
cond:              bloqueIF 
									 | bloqueIF else
									 ;
bloqueIF:          IF '(' expr ')' '{' instrucciones '}' 
									 ;
else:              ELSE '{' instrucciones '}' 
									 | ELSE cond 
									 ;
repe:              for 
									 | while 
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
									 | ID OPERADOR2 { int pos = buscarSimbolo(tablaSimbolos, $1, dim); 
									 									int tipo = tablaSimbolos[pos].tipo;
																		if (tipo == 0){
																			printf("\n ERROR lin %d: Variable %s no declarada", nLineas, $1);
																			errores++;
																		}
																		else if (tablaSimbolos[pos].inicializado == 0){
																			printf("\n ERROR lin %d: Variable %s no inicializada", nLineas, $1);
																			errores++;
																		}
									 								}
									 ;
while:             WHILE '(' expr ')' '{' instrucciones '}' 
									 ;


%%

int main()
{
		yyin=fopen("practica2conErrores.c","r");
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

