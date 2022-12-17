%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    char variable_names[100][10000];
    int type[100];
    int values[100];
    int sz = 0;
%}

%token INT NUM_INT DOUBLE FLOAT RP LP EOL OP_ASSIGN MAIN LC RC ID COMMA PLUS MINUS
%token MULT DIV POWR IF ELSE GT GE LT LE EQ NEQ FOR SEM OP_LOGICAL_OR OP_LOGICAL_AND
%token SWITCH BREAK CASE COLON DEFAULT FUNC CALL FROM TO STEP LEAPYEAR PRIME
%left OP_ASSIGN
%left OP_LOGICAL_OR
%left OP_LOGICAL_AND
%left EQ NEQ
%left GT LT GE LE
%left PLUS MINUS
%left MULT DIV
%left POWR
%%
    program:            INT MAIN LP RP LC cstatement RC function_defs
                        {
                            printf("\n\nCompilation Successful\n");
                        }

    cstatement:         /* Empty */
                        |
                        cstatement statement
                        |
                        function_call
                        ;

    statement:          EOL
                        {
                            printf("Empty statement\n");
                        }
                        |
                        new_expression EOL
                        {
                            $$ = $1;
                            printf("Value of the expression: %d\n",$$);
                        }
                        |
                        IF LP new_expression RP LC cstatement RC
                        {
                            printf("Simple if found\n");
                        }
                        |
                        IF LP new_expression RP LC cstatement RC ELSE LC cstatement RC
                        {
                            printf("If else found\n");
                        }
                        |
                        IF LP new_expression RP LC cstatement RC else_if_block ELSE LC cstatement RC
                        {
                            printf("Else if ladder found\n");
                        }
                        |
                        IF LP new_expression RP LC cstatement RC else_if_block
                        {
                            printf("Else if ladder found\n");
                        }
                        |
                        for_loop
                        {
                            printf("For loop detected\n");
                        }
                        |
                        switch_case
                        {
                            printf("Switch case block detected\n");
                        }
                        
						| LEAPYEAR LP NUM_INT RP EOL
      {
	  printf("Leap Year declaration \n");
      if(($3%400==0)|| ($3%100!=0 && $3%4==0)){
         printf("%d is a Leap Year",$3);}
     else
         {printf("%d is not a Leap Year",$3);}
		 printf("\n\n");
      }
      | PRIME LP NUM_INT RP EOL {  
                                    printf("Prime Number Detection\n");    
                                    int i,j,k;
                                    int p = 0;
                                    for(i=2;i<=$3-1;i++)
                                       {
                                          j = $3 % i;
                                          if (j == 0)
                                              {
                                                p=1;
                                                break;
                                              }
                                       }
                                    k=$3;
                                    if( k == 1){
                                                 printf("1 is neither prime nor composite.\n");
                                                } 
                                    else{
                                             if(p == 0){
                                                printf("%d is prime.\n",$3);
                                                }
                                             else{
                                                  printf("%d is not prime.\n",$3);
                                                 }
                                         } 
                                  printf("\n\n");
                              }

                        | cdeclaration EOL
                        |
                        for_loop2
                        ;

     switch_case:       SWITCH LP ID RP LC case_block RC
                        {
                            char * ptr = $3;
                            int idx = match(ptr);

                            if(idx == -1){
                                printf("Variable named %s not found\n",ptr);
                            }
                            else{
                                printf("Switch id has value: %d\n",values[idx]);
                            }
                        }
                        ;

    case_block:	        case_block2 case_block
                        |
                        default_block
                        ;

    default_block:      /* Empty */
                        |
                        DEFAULT COLON cstatement
                        ;

    case_block2:        CASE NUM_INT COLON cstatement BREAK
		                ;

    for_loop:           FOR LP for_init SEM new_expression SEM new_expression RP LC cstatement RC
                        {
                            char * ptr = $3;
                            if(match(ptr) == -1){
                                printf("Variable not declared\n");
                            }
                            else{
                                printf("For loop found\n");
                            }
                        }
                        ;

    for_loop2:          FOR FROM new_expression TO new_expression STEP new_expression LC cstatement RC
                        {
                            int start_value = $3;
                            int end_value = $5;
                            int step = $7;
                            int count = 0;
                            int j;
                            for(j = start_value; j < end_value; j += step){
                                count++;

                            }

                            printf("Loop runs %d times\n",count);
                        }

    for_init    :       /*empty*/
                        |
                        for_init2 ID OP_ASSIGN NUM_INT
                        |
                        ID OP_ASSIGN NUM_INT
                        ;

    for_init2:          ID OP_ASSIGN NUM_INT COMMA
                        ;

    else_if_block:      ELSE IF LP new_expression RP LC cstatement RC
                        |
                        else_if_block ELSE IF LP new_expression RP LC cstatement RC
                        ;

    new_expression:     ID OP_ASSIGN new_expression
                        {
                            char * ptr = $1;
                            int idx = match(ptr);

                            if(idx == -1){
                                printf("variable was not declared\n");
                                $$=-110000000;
                            }
                            else{
                                values[idx] = $3;
                                $$=$3;
                            }
                        }
                        |
                        new_expression OP_LOGICAL_OR new_expression
                        {
                            $$=$1 && $3;
                        }
                        |
                        new_expression OP_LOGICAL_AND new_expression
                        {
                            $$=$1 || $3;
                        }
                        |
                        new_expression EQ new_expression
                        {
                            $$=$1 == $3;
                        }
                        |
                        new_expression NEQ new_expression
                        {
                            $$=$1 != $3;
                        }
                        |
                        new_expression GE new_expression
                        {
                            $$=$1 >= $3;
                        }
                        |
                        new_expression LE new_expression
                        {
                            $$=$1 <= $3;
                        }
                        |
                        new_expression GT new_expression
                        {
                            $$=$1 > $3;
                        }
                        |
                        new_expression LT new_expression
                        {
                            $$ = $1 < $3;
                        }
                        |
                        new_expression PLUS new_expression
                        {
                            $$=$1+$3;
                        }
                        |
                        new_expression MINUS new_expression
                        {
                            $$=$1-$3;
                        }
                        |
                        new_expression DIV new_expression
                        {
                            $$=$1/$3;
                        }
                        |
                        new_expression MULT new_expression
                        {
                            $$=$1*$3;
                        }
                        |
                        new_expression POWR new_expression
                        {
                            int base = $1;
                            int powr = $3;
                            $$=1;

                            for(int i = 0; i < powr; i++){
                                $$ = $$ * base;
                            }
                        }
                        |
                        ID
                        {
                            char *ptr = $1;
                            int idx = match(ptr);

                            if(idx == -1){
                                printf("Variable not declared\n");
                                $$=-1000000000;
                            }
                            else{
                                $$=values[idx];
                            }
                        }
                        |
                        NUM_INT
                        {
                            $$=$1;
                        }
                        |
                        LP new_expression RP
                        {
                            $$=$2;
                        }
                        ;

    cdeclaration:       type declaration_r
                        ;

    declaration_r:      declaration_r COMMA ID
                        {
                            char * ptr = $3;
                            int len = strlen(ptr);
                            int idx = match(ptr);
                            if(idx == -1){
                                printf("variable name: %s\n",ptr);
                                insert(ptr);
                                int idx2 = match(ptr);
                                type[idx2] = 1;
                            }
                            else{
                                printf("variable already declared\n");
                            }
                        }
                        |
                        ID
                        {
                            char * ptr = $1;
                            int len = strlen(ptr);
                            int idx = match(ptr);
                            if(idx == -1){
                                printf("variable name: %s\n",ptr);
                                insert(ptr);
                                int idx2 = match(ptr);
                                type[idx2] = 1;
                            }
                            else{
                                printf("variable already declared\n");
                            }
                        }
                        ;

    type:               INT
                        |
                        DOUBLE
                        |
                        FLOAT
                        ;

    function_defs:      /* Empty */
                        |
                        function_defs function_def
                        ;

    function_def:       FUNC ID LP RP LC cstatement RC
                        {
                            char * ptr = $2;

                            int idx = match(ptr);

                            if(idx == -1){
                                printf("Function declared : %s\n",ptr);
                                insert(ptr);
                                int idx2 = match(ptr);
                                type[idx2] = 2;
                            }
                            else{
                                printf("Identifier taken\n");
                            }
                        }
                        ;
    function_call:      CALL
                        {
                            printf("Function call found\n");
                        }
                        ;

%%

int match(char * in){
    int i;
    int idx = -1;
    for(i = 0; i < sz; i++){
        if(strcmp(in,variable_names[i]) == 0){
            idx = i;
            break;
        }
    }
    return idx;
}

void insert(char * in){
    strcpy(variable_names[sz],in);
    sz++;
}
int yywrap(){
    return 1;
}

void yyerror(char * s){
    printf(" %s",s);
}
