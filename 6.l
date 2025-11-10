%{
#include "y.tab.h"
%}
%%
[a-zA-Z][a-zA-Z0-9]* { yylval.sval = strdup(yytext); return ID; }
[0-9]+               { yylval.sval = strdup(yytext); return NUM; }
[=+\-\n]             { return yytext[0]; }
[ \t]                { }
.                    { }
%%
int yywrap(){ return 1; }