%{
#include "y.tab.h"
#include "practica2.h" 
#include <string.h>
  
int nLineas=1;
%}

entero	[0-9]+
real	{entero}+[.]{entero}([eE][-+]?{entero})?
iden	[a-zA-Z][a-zA-Z0-9]*
cadena \"(\\.|[^\\"])*\"
operador [+\-*/&|!<>%]
cdc \"(%d|%f|%c)\"
input [^\r\n]
eol (\n|\r|\r\n)
coment ("//"{input}*{eol}?)

%%

{entero}  { printf("\n %d NUM_ENTERO",nLineas);
            return NUM_ENTERO;
		      }

{real}  { printf("\n %d NUM_REAL",nLineas);
          return NUM_REAL;
        }

{cdc}  { printf("\n %d CDC",nLineas);
                  return CDC;
        }     

{cadena}  { printf("\n %d CADENA",nLineas);
            return CADENA;
          }

[ \t]	;

"define"  { printf("\n %d DEFINE",nLineas);
            return DEFINE;
          }

"int"     { printf("\n %d INT",nLineas);
            return INT;
          }

"float"   { printf("\n %d FLOAT",nLineas);
            return FLOAT;
          }

"char"    { printf("\n %d CHAR",nLineas);
            return CHAR;
          }

"int main()"    { printf("\n %d MAIN",nLineas);
                  return MAIN;
                }

"printf"  { printf("\n %d PRINTF",nLineas);
            return PRINTF;
          }

"scanf" { printf("\n %d SCANF",nLineas);
          return SCANF;
        }

"if"  { printf("\n %d IF",nLineas);
        return IF;
      }

"else"  { printf("\n %d ELSE",nLineas);
          return ELSE;
        }

"while" { printf("\n %d WHILE",nLineas);
          return WHILE;
        }

"for" { printf("\n %d FOR",nLineas);
        return FOR;
      }

{iden}    { printf("\n %d ID",nLineas);
            strcpy(yylval.nombreId, yytext);
            return ID;
          }

{operador}|"&&"|"||"|"=="|"<="|">="|"!="   { printf("\n %d OPERADOR",nLineas);
                                             return OPERADOR;
                                            }
"++"|"--" { printf("\n %d OPERADOR2",nLineas);
            return OPERADOR2;
          }
{coment} {  printf("\n %d COMENTARIO",nLineas);

         }

\n  { nLineas++; }

.	{ printf("\n %d %c",nLineas, yytext[0]);
    return yytext[0];
  }

%%

int yywrap(){
    return 1;
}
