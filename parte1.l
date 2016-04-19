%{
  #include "y.tab.h"
  #include "calc3.h"
  #include <string.h>
  

%}
entero	[0-9]+
real	{entero}+[.]{entero}([eE][-+]?{entero})?
cadena \"(\\.|[^\\"])*\"
iden	[a-z][a-z0-9]*
cte_iden [A-Z]+
define  #define

%%
{define} 	 	{return DEFINE;}

{cte_iden}   	{yylval.indice = buscar_simbolo(yytext);
				 return ID;}
{entero}|{real} {yylval.valor = atof(yytext);
	 	 		 return NUM;
				}

{cadena}		{yylval.valor = yytext;
				 return CADENA;}

[ \t]	;

.|\n	;

%%
int yywrap(){
return 1;
}

