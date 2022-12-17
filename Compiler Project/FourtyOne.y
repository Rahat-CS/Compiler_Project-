%{
    #include<stdio.h>
	#include<string.h>
	#include<stdlib.h>
	#include<math.h>
	#define PI 3.14159265
	extern FILE *yyin;
	extern FILE *yyout;
	int checked[26],flag=0,m_flag=0;
	float arr[1000];
%}

%union { 
  int itype;
  double dtype;   
}

%token <dtype> NUM
%token <itype> VAR
%type <dtype> TERM
%type <dtype> FACTOR
%type <dtype> G
%type <dtype> EXPRESSION
%type <dtype> STATEMENT
%type <dtype> LOOP
%type <dtype> SWITCH_CASE
%type <dtype> multiple_case
%type <dtype> IF_ELSE
%type <dtype> stmt

%token MAIN_FUNC INT FLOAT READ WRITE ADD SUB MUL DIV EXPONEN SQR SQRT CUBE SINE COSINE TANGENT LN EQUALS LT GT LE GE NE COMA SEMI COLON LPAR RPAR SLPAR SRPAR FACTORIAL Leap_Year PRIME Divisors EVEN_ODD SUMMATION IF ELSE FOR IN RANGE WHILE SWITCH CASE DEFAULT
%nonassoc IFX
%nonassoc ELSE
%left LT GT LE GE
%left ADD SUB
%left MUL DIV
%left SQRT SQR CUBE
%left SINE COSINE TANGENT

%%
program:
    | MAIN_FUNC SLPAR STATEMENTS SRPAR { fprintf(yyout,"Execution Done!\n"); }
    ; 
STATEMENTS:
    | STATEMENTS STATEMENT 
	| STATEMENTS BUILT_IN_FUNCTIONS
	| STATEMENTS LOOP
	| STATEMENTS SWITCH_CASE
    | STATEMENTS IF_ELSE    { 
	                            if($2) 
								{  
								    fprintf(yyout,"Value of Expression in Valid Condition: %.2f\n",$2); 
								}
								else
								{
								   fprintf(yyout,"Condition false\n");
								}
						    //
    | STATEMENTS DECLARATION
    ;

STATEMENT:
     EXPRESSION SEMI        { 
                                $$ = $1;	
                                fprintf(yyout,"Value of expression : %.2f\n",$1);
                            }
    | VAR EQUALS EXPRESSION SEMI
                  	        {															
                                if(checked[$1] == 1)
                                {
                                    arr[$1] = $3;
									$$ = arr[$1];
                                    fprintf(yyout,"%c assigned %.2f\n",$1+97,$3);
                                }
								else
                                  fprintf(yyout,"%c not declared\n",$1+97);
						    }

    | READ VAR SEMI         {
                                printf("User Input for %c\n",$2+97);
                                if(checked[$2] == 1) 
                                { 
                                    fprintf(yyout,"Value taken from user for %c\n",$2+97);
                                    float a;
                                    scanf("%f",&a);
                                    arr[$2] = a;
								}
								else
                                    fprintf(yyout,"%c not declared\n",$2+97);
                            }
    | WRITE LPAR VAR RPAR SEMI 
	                        { 
                                if(checked[$3] == 1) 
                                    fprintf(yyout,"Value of %c is %.2f\n",$3+97,arr[$3]);
								else
                                    fprintf(yyout,"%c not declared\n",$3+97);

                            }
	;
BUILT_IN_FUNCTIONS:
      Leap_Year stmt SEMI   {
	                            int n = (int)$2;
                                if(((n%4 == 0) && (n%100 != 0)) || (n%400 == 0))
                                    fprintf(yyout,"%d leap year\n",n);
                                else
                                    fprintf(yyout,"%d not leap year\n",n);
                            } 
    | PRIME stmt SEMI       {
	                            int n = (int)$2;
                                int i,cnt=0;
                                for(i=2;i<n;i++)
                                {
                                    if(n%i == 0)
                                    {
                                        cnt=cnt+1;
                                        break;
                                    }
                                }
                                if(cnt==0 && $2 != 1)
                                    fprintf(yyout,"Yes! %d prime\n",n);
                                else
                                    fprintf(yyout,"No! %d not prime\n",n);
                            } 
    | Divisors stmt SEMI    {
                                int j;
								int n = (int)$2;
                                fprintf(yyout,"All the divisors of %d are -> ",n);
                                for(j=1;j<=n;j++)
                                {
                                    if(n%j==0)
                                       fprintf(yyout,"%d ",j);
							    }
                                fprintf(yyout,"\n");
                            }
    | SUMMATION stmt SEMI   {
	                            int n = (int)$2;
								int sum = n*(n+1)/2;
								fprintf(yyout,"Summation of 1st %d numbers is %d\n",n,sum);
	                        }
    | EVEN_ODD stmt SEMI    {
	                            int n = (int)$2;
	                            if(n %2 == 0)
								    fprintf(yyout,"%d Even Number\n",n);
								else
								    fprintf(yyout,"%d Odd Number\n",n);
	                        }
    ;
LOOP:
      FOR VAR IN RANGE LPAR NUM COMA NUM COMA NUM RPAR COLON stmt SEMI
	                        {
							    if(checked[$2] == 1)
                                {
								    fprintf(yyout,"For loop Found\n");
								    if($6 <= $8)
                                    {
									    for(arr[$2] = $6; arr[$2] <= $8; arr[$2] += $10)
                                            fprintf(yyout,"Value in for loop %.2f\n",$13);
									}
									else
									{
									    for(arr[$2] = $6; arr[$2] > $8; arr[$2] -= $10)
                                            fprintf(yyout,"Value in for loop: %.2f\n",$13);
									}
                                }
								else
                                  fprintf(yyout,"%c not declared\n",$2+97);	
							}
	| WHILE VAR LE NUM COLON stmt SEMI
                            {
							    float a = arr[$2];
								float b = $4;
								$$ = $6;
								if((checked[$2] == 1) && (a <= b))
								{
								    fprintf(yyout,"While loop found & it works properly!\n");
                                    while(a <= b)
                                    {
                                        fprintf(yyout,"Value in while loop: %.2f\n",$$);
                                        a += 1;
									    if(a > b) break;
                                    }
								    arr[$2] = a;
								}
								else
								    fprintf(yyout,"While loop found but either condition false or variable undeclared!\n");
                            }
	| WHILE VAR GE NUM COLON stmt SEMI
                            {
							    float a = arr[$2];
								float b = $4;
								$$ = $6;
								if((checked[$2] == 1) && (a >= b))
								{
								    fprintf(yyout,"While loop found & it works properly!\n");
                                    while(a >= b)
                                    {
                                        fprintf(yyout,"Value in while loop: %.2f\n",$$);
                                        a -= 1;
									    if(a < b) break;
                                    }
								    arr[$2] = a;
								}
								else
								    fprintf(yyout,"While loop found but either condition false or variable undeclared!\n");
                            }
    ;
SWITCH_CASE:
     SWITCH LPAR VAR RPAR SLPAR multiple_case DEFAULT COLON stmt SEMI SRPAR
	                        {
							    if(checked[$3] == 1)
								{    
									if(m_flag == 1)
									   fprintf(yyout,"Multiple case switch statement found!\n");
									else if(m_flag == 0)
									   fprintf(yyout,"Single case switch statement found!\n");
								}
						    }
	;
multiple_case:
    multiple_case CASE NUM COLON stmt SEMI { m_flag = 1; }
    | CASE NUM COLON stmt SEMI             { m_flag = 0; }
    ;
IF_ELSE:
    IF EXPRESSION SLPAR stmt SEMI SRPAR
	                        {
								if($2) 
								{
								    $$ = $4;
								}
								else
								{
								    $$ = 0;
								}
							}
    | IF EXPRESSION SLPAR stmt SEMI SRPAR ELSE SLPAR stmt SEMI SRPAR 
	                        {
								if($2)
								{
									$$ = $4;
							    }
							    else
							    {
									$$ = $9;
								}
							}
    | IF EXPRESSION SLPAR IF_ELSE SRPAR ELSE SLPAR IF_ELSE SRPAR 
                            {
                                if($2) { $$ = $4; }
                                else   { $$ = $8; }
                            }   
    ;
stmt:
    EXPRESSION  { $$ = $1; }
	;
DECLARATION:
    TYPE VARIABLE SEMI  { if(flag!=0) 
	                        fprintf(yyout,"Variable declared\n");
						}
	;
TYPE:
    FLOAT
	| INT
	;
VARIABLE:
    VARIABLE COMA VAR   {
	                        if(checked[$3] == 1)
                            {
							    fprintf(yyout,"%c already declared\n",$3+97);
								flag =0;
								return 0;
							}
                            else
							{   checked[$3] = 1;
							    flag=1;
							}
                        }
    | VAR	            {
                            if(checked[$1] == 1)
                            {
							    fprintf(yyout,"%c already declared\n",$1+97);
								flag = 0;
								return 0;
							}
                            else
							{
							    checked[$1] = 1;
								flag = 1;
							}
                        }								
	;
EXPRESSION:
      EXPRESSION ADD TERM { $$ = $1 + $3; }
    | EXPRESSION SUB TERM { $$ = $1 - $3; }
	| TERM                { $$ = $1; }
	;
TERM:
     TERM MUL FACTOR      { $$ = $1 * $3; }
    | TERM DIV FACTOR     {
                             if($3) 
                                $$ = $1 / $3;
                             else 
                             { 
                                $$ = 0; 
                                fprintf(yyout,"Division by zero\n"); 
                             }
                          }
    | FACTOR              { $$ = $1; }
	;
FACTOR:	
      G EXPONEN FACTOR    { $$ = powl($1,$3); }
	| G LT FACTOR         { $$ = $1 < $3; }
    | G GT FACTOR         { $$ = $1 > $3; }
    | G LE FACTOR         { $$ = $1 <= $3; }
    | G GE FACTOR         { $$ = $1 >= $3; }
	| G NE FACTOR         { $$ = $1 != $3; }
	| SQR G               { $$ = $2*$2; }
	| CUBE G              { $$ = $2*$2*$2; }
    | SQRT G              { $$ = sqrt($2); }
	| SINE G              { 
	                         double x = $2;
	                         double val = PI / 180;
                             double res = sin(x*val);
							 $$ = res;
						  }
	| COSINE G            { 
	                         double x = $2;
							 double val = PI / 180;
                             double res = cos(x*val);
							 $$ = res;
						  }
	| TANGENT G           { 
	                         double x = $2;
	                         double val = PI / 180;
                             double res = tan(x*val);
							 $$ = res;
						  }
	| LN G                { $$ =log($2); }
	| FACTORIAL G         {
                               int i,res = 1;
                               for(i=1;i<=$2;i++)
                                  res *= i;
                               $$ = res;
                          }
    | G                   { $$ = $1; }
	;
G:  
    NUM                   { $$ = $1; }
    | VAR                 { 
                               if(checked[$1] == 1) 
                                  $$ = arr[$1];
						  }
    |LPAR EXPRESSION RPAR { $$ = $2; }
    ;	
%%

int yywrap()
{
    return 1;
}
int yyerror(char *s) 
{
	fprintf(yyout,"%s\n",s);
	return(0);
}