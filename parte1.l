%{
    #include "y.tab.h"
    #include "parte1.h"
    #include <stdlib.h>
	#include <stdio.h>
	#include <string.h>
	

%}
	letra [a-zA-Z]
	natural [0-9]
	nodigitos [_a-zA-Z]
	separadores [,;(){}]
	input [^\r\n]
	operador [+*=&"&&"]
	blanco (" ")+
	tabulacion \t
	eol (\n|\r|\r\n)
	numero ({natural}+("."{natural}+)?)
	ident {letra}({nodigitos}|{natural})*
	variables ((("int"|"float"){blanco}+{ident})(","{blanco}*{ident})*";")
	coment ("//"{input}*{eol}?)
	cadena \"(\\.|[^\\"])*\"
	llaves [(){}]
%%

%%
	int yywrap()
	{
		return 1;
	}

