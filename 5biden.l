%{
#include "y.tab.h"
#include <string.h>
%}
%%
[a-zA-Z][a-zA-Z0-9]* { yylval.sval = strdup(yytext); return VARIABLE; }
[0-9][a-zA-Z0-9]*    { printf("Invalid variable\n"); }
[^ \t\n]+            { printf("Invalid variable\n"); }
\n        { return '\n'; }
[ \t]     { }
%%
int yywrap(){ return 1; }
