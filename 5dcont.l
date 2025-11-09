%{
#include "y.tab.h"
%}
%%
for        { return FOR; }
while      { return WHILE; }
if         { return IF; }
else       { return ELSE; }
switch     { return SWITCH; }
case       { return CASE; }
[a-zA-Z_][a-zA-Z0-9_]* { return ID; }
[0-9]+     { return NUMBER; }
"=="       { return EQ; }
"!="       { return NE; }
"<="       { return LE; }
">="       { return GE; }
"&&"       { return AND; }
"||"       { return OR; }
\n         { return '\n'; }
[ \t]      { }
.          { return yytext[0]; }
%%
int yywrap(){ return 1; }
