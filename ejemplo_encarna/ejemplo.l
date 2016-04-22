%{

  #include "y.tab.h"

  #include <string.h>
  
  int nLineas=0;
%}
entero	[0-9]+
real	{entero}+[.]{entero}([eE][-+]?{entero})?
iden	[a-zA-Z][a-zA-Z0-9]*
%%
{entero}|{real}	{ printf("\n NUM");
	 	 return NUM;
		}
[ \t]	;
"define"  { printf("\n DEFINE");
    return DEFINE;}

{iden}	{ printf("\n ID");
	 

	 return ID;
	}
\n  { nLineas++;
    
    }

.	{printf("\n %c",yytext[0]);
     return yytext[0];}

%%

int yywrap(){
    return 1;
}
