%{
#include <stdio.h>
int v=0,cnt=0;
%}
%option noyywrap
%%
[aeiouAEIOU]        { v++; }
[b-df-hj-np-tv-zB-DF-HJ-NP-TV-Z] { cnt++; }
\n                  { printf("Vowels=%d Consonants=%d\n", v, cnt); v = cnt = 0; }
.                   { /* ignore other chars */ }
%%
int main(){
  yylex();
  return 0;
}
