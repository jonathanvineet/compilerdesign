%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s){ /* suppress default error */ }
%}
%union {
  char *sval;
}
%token <sval> VARIABLE
%%
start: /* empty */
     | start VARIABLE { printf("Valid variable: %s\n", $2); free($2); }
     ;
%%
int main(){ printf("Enter variable:\n"); yyparse(); return 0; }
