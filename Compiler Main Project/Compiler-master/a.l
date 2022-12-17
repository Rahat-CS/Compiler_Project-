%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "a.tab.h"
%}

%%
"int" { return INT; }
"float" { return FLOAT; }
"double" { return DOUBLE; }
[0-9]+  {   yylval = atoi(yytext);
        return NUM_INT;}

"l_paren" {
    return LP;
}
"call" {
    return CALL;
}

"from" {
    return FROM;
}

"to"    {
    return TO;
}

"step" {
    return STEP;
}

"r_paren" {
    return RP;
}

"eol" {
    return EOL;
}

"=" {
    return OP_ASSIGN;
}

"leapyear" {
    return LEAPYEAR;
}

"prime" {
    return PRIME;
}

"main" {
    return MAIN;
}

"l_curly" {
    return LC;
}

"r_curly" {
    return RC;
}


"," {
    return COMMA;
}

"+" {
    return PLUS;
}

"func" {
    return FUNC;
}
"-" {
    return MINUS;
}

"*" {
    return MULT;
}

"/" {
    return DIV;
}
"case" {
    return CASE;
}

"break" {
    return BREAK;
}


"**" {
    return POWR;
}

";" {
    return SEM;
}


"if" {
    return IF;
}

"else" {
    return ELSE;
}

"||" {
    return OP_LOGICAL_OR;
}

"&&" {
    return OP_LOGICAL_AND;
}

"for" {
    return FOR;
}

"switch" {
    return SWITCH;
}
"==" {
    return EQ;
}

"!=" {
    return NEQ;
}

">" {
    return GT;
}

"<" {
    return LT;
}


">=" {
    return GE;
}
":" {
    return COLON;
}

"default" {
    return DEFAULT;
}
"<=" {
    return LE;
}
[a-zA-Z][a-zA-Z0-9]* {
    char * ptr = (char*)(calloc(strlen(yytext)+1,sizeof(char)));
    strcpy(ptr,yytext);
    yylval = ptr;
    return ID;
}

[ \t\n]*	{;}
.   {}
%%

int main(){
    yyin = freopen("in.txt","r",stdin);
    yyout = freopen("out.txt","w",stdout);

    yyparse();
}
