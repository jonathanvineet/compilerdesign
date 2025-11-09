%{
#include <stdio.h>
%}
%option noyywrap
%%
[+-]?[0-9]+\.[0-9]+([eE][+-]?[0-9]+)?  { printf("Floating/Exponent: %s\n", yytext); }
[0-9]+                                  { printf("Integer: %s\n", yytext); }
\.[0-9]+                                { printf("Fraction: %s\n", yytext); }
[ \t\n]+                                { /* skip */ }
.                                       { /* ignore */ }
%%
int main(){ yylex(); return 0; }
