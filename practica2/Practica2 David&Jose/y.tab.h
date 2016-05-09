/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ID = 258,
     DEFINE = 259,
     NUM_ENTERO = 260,
     NUM_REAL = 261,
     CADENA = 262,
     INT = 263,
     FLOAT = 264,
     CHAR = 265,
     MAIN = 266,
     OPERADOR = 267,
     OPERADOR2 = 268,
     PRINTF = 269,
     IF = 270,
     FOR = 271,
     ELSE = 272,
     SCANF = 273,
     WHILE = 274,
     CDC = 275
   };
#endif
/* Tokens.  */
#define ID 258
#define DEFINE 259
#define NUM_ENTERO 260
#define NUM_REAL 261
#define CADENA 262
#define INT 263
#define FLOAT 264
#define CHAR 265
#define MAIN 266
#define OPERADOR 267
#define OPERADOR2 268
#define PRINTF 269
#define IF 270
#define FOR 271
#define ELSE 272
#define SCANF 273
#define WHILE 274
#define CDC 275




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 20 "practica2.y"
{
	   int tipo; // 1.int 2.float 3.char
     struct simbolo *indice;
	}
/* Line 1529 of yacc.c.  */
#line 94 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

