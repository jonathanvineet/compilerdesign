%{
#include <stdio.h>
#include <stdlib.h>
char* yylval;
int tmp=0;
int yylex(void);
void yyerror(const char*s){ fprintf(stderr,"err\n"); }
%}
%token ID NUM
%%
S: ID '=' E { printf("%s = t%d\n", $1, tmp-1); }
 ;
E: E '+' T { printf("t%d = t%d + t%d\n", ++tmp, tmp-1, tmp-1); }
 | T { $$ = 0; }
 ;
T: ID { printf("t%d = %s\n", ++tmp, $1); }
 | NUM { printf("t%d = %s\n", ++tmp, $1); }
 ;
%%
int main(){ printf("Enter assignment (e.g., x=y+z):\n"); yyparse(); return 0;}
