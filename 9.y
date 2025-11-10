%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s){ }
%}
%union { 
    int ival; 
    double dval; 
    int type; /* 0=int, 1=double */
}
%token <ival> INT
%token <dval> DOUBLE
%token ADD SUB EOL
%type <type> expression term
%%
line: expression EOL
    ;
expression:
      expression ADD term { 
          if($1 != $3) {
              printf("Type mismatch: cannot add int and double\n");
          } else {
              printf("Type correct\n");
          }
          $$ = ($1 == 1 || $3 == 1) ? 1 : 0;
      }
    | expression SUB term { 
          if($1 != $3) {
              printf("Type mismatch: cannot subtract int and double\n");
          } else {
              printf("Type correct\n");
          }
          $$ = ($1 == 1 || $3 == 1) ? 1 : 0;
      }
    | term { $$ = $1; }
    ;
term:
      INT    { $$ = 0; }
    | DOUBLE { $$ = 1; }
    ;
%%
int main(){ yyparse(); return 0; }