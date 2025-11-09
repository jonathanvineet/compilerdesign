%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char *s){ fprintf(stderr,"err: %s\n",s); }
%}
%token NUMBER
%left '+' '-'
%left '*' '/'
%%
input: /* empty */
    | input line
    ;
line: expr '\n' { printf("Result: %d\n", $1); }
    ;
expr: expr '+' expr { $$ = $1 + $3; }
    | expr '-' expr { $$ = $1 - $3; }
    | expr '*' expr { $$ = $1 * $3; }
    | expr '/' expr { if ($3==0){ yyerror("div by zero"); $$=0;} else $$=$1/$3; }
    | '(' expr ')'  { $$ = $2; }
    | NUMBER        { $$ = $1; }
    ;
%%
int main(){ printf("Enter expressions (Ctrl+D to exit):\n"); yyparse(); return 0; }
