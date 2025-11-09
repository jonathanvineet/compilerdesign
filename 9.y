%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char *s){ fprintf(stderr,"Error: %s\n",s); }
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
program: /* empty */
       | program line EOL
       ;
line: expression { 
          /* Type correct message already printed in expression rule */
      }
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
    | term { $$ = $1; }
    ;
term:
      INT    { $$ = 0; printf("int "); }
    | DOUBLE { $$ = 1; printf("double "); }
    ;
%%
int main(){ yyparse(); return 0; }
