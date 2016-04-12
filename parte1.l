%{
  #include "y.tab.h"
  #include "parte1.h"
  #include <stdlib.h>
	#include <stdio.h>
	#include <string.h>
	int ints = 0, floats = 0, ifs = 0, mains = 0, elses = 0, scanfs = 0, printfs = 0, lineasTotales = 0, lineasComentario = 0, idents = 0, cadenas = 0, numeros = 0;
	int llaves = 1, parentesis = 1, parent = 0, llav = 0;
	char *identificadores[100][100];
	char *cads[100][100];
	char *nums[100][100];

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

