%{
#include <stdio.h>
%}
%option noyywrap
%%
"/*"([^*]|\*+[^*/])*\*+ "/"   { printf("Comment: %s\n", yytext); }
"//".*                        { printf("Comment: %s\n", yytext); }
if|else|while|for|return|int|float|char|void { printf("Keyword: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*        { printf("Identifier: %s\n", yytext); }
[0-9]+(\.[0-9]+)?             { printf("Number: %s\n", yytext); }
[+\-*/=<>!&|]+                { printf("Operator: %s\n", yytext); }
[ \t\n]+                      { /* skip */ }
.                             { printf("Unknown: %s\n", yytext); }
%%
int main(){ yylex(); return 0;}
