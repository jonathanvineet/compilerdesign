%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s){ }
%}
%union {
    char *sval;
}
%token <sval> VARIABLE
%%
line: VARIABLE '\n' { printf("Valid variable: %s\n", $1); free($1); }
    ;
%%
int main(){ 
    printf("Enter variable:\n"); 
    yyparse(); 
    return 0; 
}
