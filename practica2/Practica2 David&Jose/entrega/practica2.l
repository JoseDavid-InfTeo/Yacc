%{
#include "y.tab.h"
#include <string.h>
  
int nLineas=1;
%}

entero	[0-9]+
real	{entero}+[.]{entero}([eE][-+]?{entero})?
iden	[a-zA-Z][a-zA-Z0-9]*
cadena \"(\\.|[^\\"])*\"
operador [+\-*/&|!<>%]
cdc1 \"%d\"
cdc2 \"%f\"
cdc3 \"%c\"
input [^\r\n]
eol (\n|\r|\r\n)
coment ("//"{input}*{eol}?)

%%

{entero}  {
            return NUM_ENTERO;
		      }

{real}  { 
          return NUM_REAL;
        }

{cdc1}  { 
		  yylval.tipo = 1;
          return CDC;
        }    
{cdc2}  { 
		  yylval.tipo = 2;
          return CDC;
        }  
{cdc3}  { 
		  yylval.tipo = 3;
          return CDC;
        }   

{cadena}  {
            return CADENA;
          }

[ \t]	;

"define"  {
            return DEFINE;
          }

"int"     { 
            return INT;
          }

"float"   {
            return FLOAT;
          }

"char"    {
            return CHAR;
          }

"int main()"    {
                  return MAIN;
                }

"printf"  { 
            return PRINTF;
          }

"scanf" {
          return SCANF;
        }

"if"  { 
        return IF;
      }

"else"  {
          return ELSE;
        }

"while" { 
          return WHILE;
        }

"for" { 
        return FOR;
      }

{iden}    { 
            strcpy(yylval.nombreId, yytext);
            return ID;
          }

{operador}|"&&"|"||"|"=="|"<="|">="|"!="   { 
                                             return OPERADOR;
                                            }
"++"|"--" { 
            return OPERADOR2;
          }
{coment} { nLineas++; }

\n  { nLineas++; }

.	{
    return yytext[0];
  }

%%

int yywrap(){
    return 1;
}
