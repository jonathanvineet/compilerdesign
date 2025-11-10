%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s){ }
%}
%token NUMBER
%left '+' '-'
%left '*' '/'
%%
line: expr '\n' { printf("Result: %d\n", $1); }
    ;
expr: expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { $$ = $3 ? $1/$3 : 0; }
    | '(' expr ')'  { $$ = $2; }
    | NUMBER        { $$ = $1; }
    ;
%%
int main(){ 
    printf("Enter expression:\n"); 
    yyparse(); 
    return 0; 
}
