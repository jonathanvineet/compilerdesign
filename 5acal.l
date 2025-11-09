%{
#include "y.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}
%%
[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[ \t]+      { /* skip whitespace */ }
\n          { return '\n'; }
.           { return yytext[0]; }
%%
int yywrap(void){ return 1; }
