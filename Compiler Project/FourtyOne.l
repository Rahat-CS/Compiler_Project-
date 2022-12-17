%{
    #include<stdio.h>
	#include<string.h>
	#include<stdlib.h>
	#include<math.h>
	#include "FourtyOne.tab.h" 
	extern FILE *yyin;
	extern FILE *yyout;
%}

header "~include<...>"
digit  [0-9]
id     [a-z]
main   "main()"


%%

{main}       { return MAIN_FUNC; }
"int"        { return INT; }
"float"      { return FLOAT; }
{id}         { yylval.itype = *yytext - 'a'; return VAR; }
"read"       { return READ; }
"write"      { return WRITE; }
"+"          { return ADD; }
"-"          { return SUB; }
"*"          { return MUL; }
"/"          { return DIV; }
"^"          { return EXPONEN; }
"="          { return EQUALS; }
"lt"         { return LT; }
"gt"         { return GT; }
"le"         { return LE; }
"ge"         { return GE; }
"ne"         { return NE; }
","          { return COMA; }
";"          { return SEMI; }
":"          { return COLON; }
"("          { return LPAR; }
")"          { return RPAR; }
"{"          { return SLPAR; }
"}"          { return SRPAR; }
"sqr"        { return SQR; }
"cube"       { return CUBE; }
"sqrt"       { return SQRT; }
"sin"        { return SINE; }
"cos"        { return COSINE; }
"tan"        { return TANGENT; }
"ln"         { return LN; }
"fact"       { return FACTORIAL; }
"prime"      { return PRIME; }
"divisors"   { return Divisors; }
"leap_year"  { return Leap_Year; }
"summation"  { return SUMMATION; }
"even_odd"   { return EVEN_ODD; }
"if"         { return IF; }
"else"       { return ELSE; }
"for"        { return FOR; }
"in"         { return IN; }
"range"      { return RANGE; }
"while"      { return WHILE; }
"switch"     { return SWITCH; }
"case"       { return CASE; }
"default"    { return DEFAULT; }
"-"?{digit}+ { yylval.dtype = atof(yytext); return NUM ; }
"-"?{digit}*[.][0-9]+ { yylval.dtype = atof(yytext); return NUM ; }
{header}     { fprintf(yyout,"This is a header file\n"); }
"~~".*       { fprintf(yyout,"Single Line Comment\n"); }
"@"[^@]+"@"  { fprintf(yyout,"Multiline Comment\n"); }
[ \t\n]

%%

int main(void)
{
	yyin = fopen("input.txt","r");
	yyout = fopen("OUTPUT.txt","w");
	yyparse();
}
