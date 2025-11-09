%{
#include "y.tab.h"
%}
%%
[a-zA-Z]+ { yylval = strdup(yytext); return ID; }
[0-9]+    { yylval = strdup(yytext); return NUM; }
[ \t]     { }
\n        { return 0; }
.         { return yytext[0]; }
%%
int yywrap(){ return 1; }
