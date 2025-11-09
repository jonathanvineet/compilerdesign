%{
#include <stdio.h>
%}
%option noyywrap
%%
[A-Za-z][A-Za-z0-9]*  { printf("Valid Identifier: %s\n", yytext); }
[0-9A-Za-z_]+         { printf("Invalid Identifier: %s\n", yytext); }
[ \t\n]+              { /* skip */ }
.                     { /* ignore */ }
%%
int main(){ yylex(); return 0; }
