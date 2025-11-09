%{
#include <stdio.h>
int words=0, lines=0, chars=0;
%}
%option noyywrap
%%
\n                 { lines++; chars++; }
[A-Za-z_][A-Za-z0-9_]* { words++; chars += yyleng; }
.                  { chars++; }
%%
int main(){
  printf("Enter text (Ctrl+D to end):\n");
  yylex();
  printf("Words=%d Lines=%d Chars=%d\n", words, lines, chars);
  return 0;
}
