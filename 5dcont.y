%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s){ fprintf(stderr, "Error: %s\n", s); }
%}
%token FOR WHILE IF ELSE SWITCH CASE ID NUMBER EQ NE LE GE AND OR
%%
line: stmt '\n' { printf("Valid control structure\n"); }
    ;
stmt: IF '(' condition ')' block
    | IF '(' condition ')' block ELSE block
    | WHILE '(' condition ')' block
    | FOR '(' expr ';' condition ';' expr ')' block
    | SWITCH '(' expr ')' '{' cases '}'
    ;
block: '{' '}'
     | '{' stmt '}'
     | stmt
     ;
cases: CASE NUMBER ':' 
     | cases CASE NUMBER ':'
     ;
condition: expr relop expr
         | condition AND condition
         | condition OR condition
         | '(' condition ')'
         ;
relop: '<' | '>' | EQ | NE | LE | GE
     ;
expr: ID
    | NUMBER
    | expr '+' expr
    | expr '-' expr
    | '(' expr ')'
    ;
%%
int main(){ 
    printf("Enter control structure:\n"); 
    yyparse(); 
    return 0; 
}
