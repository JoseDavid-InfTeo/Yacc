%{

#include "y.tab.h"
#include <string.h>
  
int nLineas=0;

%}

entero	[0-9]+
real	{entero}+[.]{entero}([eE][-+]?{entero})?
iden	[a-zA-Z][a-zA-Z0-9]*
cadena \"(\\.|[^\\"])*\"
operador [+\-*/&|!<>%]

%%

{entero}  { printf("\n NUM_ENTERO");
            return NUM_ENTERO;
		      }

{real}  { printf("\n NUM_REAL");
          return NUM_REAL;
        }

{cadena}  { printf("\n CADENA");
            return CADENA;
          }

[ \t]	;

"define"  { printf("\n DEFINE");
            return DEFINE;
          }

"int"     { printf("\n INT");
            return INT;
          }

"float"   { printf("\n FLOAT");
            return FLOAT;
          }

"char"    { printf("\n CHAR");
            return CHAR;
          }

"int main()"    { printf("\n MAIN");
                  return MAIN;
                }

{iden}    { printf("\n ID");
            return ID;
          }

{operador}|"&&"|"||"|"++"|"--"|"=="|"<="|">="|"!="  { printf("\n OPERADOR");
                                                      return OPERADOR;
                                                    }

\n  { nLineas++; }

.	{ printf("\n %c",yytext[0]);
    return yytext[0];
  }

%%

int yywrap(){
    return 1;
}
