%{
#include "y.tab.h"
%}
%%
[0-9]+\.[0-9]+  { yylval.dval = atof(yytext); return DOUBLE; }
[0-9]+          { yylval.ival = atoi(yytext); return INT; }
\+              { return ADD; }
-               { return SUB; }
[ \t]           { }
\n              { return EOL; }
.               { return yytext[0]; }
%%
int yywrap(){ return 1; }
