%{
#include <stdio.h>
#include <stdlib.h>
int tmp=0;
int yylex(void);
void yyerror(const char*s){ /* silent */ }
%}
%union {
    char *sval;
    int tnum;
}
%token <sval> ID NUM
%type <tnum> S E T
%%
S: ID '=' E '\n' { printf("%s = t%d\n", $1, $3); free($1); }
 ;
E: E '+' T { printf("t%d = t%d + t%d\n", ++tmp, $1, $3); $$ = tmp; }
 | E '-' T { printf("t%d = t%d - t%d\n", ++tmp, $1, $3); $$ = tmp; }
 | T { $$ = $1; }
 ;
T: ID { printf("t%d = %s\n", ++tmp, $1); free($1); $$ = tmp; }
 | NUM { printf("t%d = %s\n", ++tmp, $1); free($1); $$ = tmp; }
 ;
%%
int main(){ printf("Enter assignment (e.g., x=y+z):\n"); yyparse(); return 0;}