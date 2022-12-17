
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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
     INT = 258,
     NUM_INT = 259,
     DOUBLE = 260,
     FLOAT = 261,
     RP = 262,
     LP = 263,
     EOL = 264,
     OP_ASSIGN = 265,
     MAIN = 266,
     LC = 267,
     RC = 268,
     ID = 269,
     COMMA = 270,
     PLUS = 271,
     MINUS = 272,
     MULT = 273,
     DIV = 274,
     POWR = 275,
     IF = 276,
     ELSE = 277,
     GT = 278,
     GE = 279,
     LT = 280,
     LE = 281,
     EQ = 282,
     NEQ = 283,
     FOR = 284,
     SEM = 285,
     OP_LOGICAL_OR = 286,
     OP_LOGICAL_AND = 287,
     SWITCH = 288,
     BREAK = 289,
     CASE = 290,
     COLON = 291,
     DEFAULT = 292,
     FUNC = 293,
     CALL = 294,
     FROM = 295,
     TO = 296,
     STEP = 297,
     LEAPYEAR = 298,
     PRIME = 299
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


