%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s){ printf("Invalid expression\n"); }
%}
%token NUMBER
%left '+' '-'
%left '*' '/'
%%
line: expr '\n' { printf("Valid expression\n"); }
    ;
expr: expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | '(' expr ')'
    | NUMBER
    ;
%%
int main(){ 
    printf("Enter arithmetic expression:\n"); 
    yyparse(); 
    return 0; 
}
