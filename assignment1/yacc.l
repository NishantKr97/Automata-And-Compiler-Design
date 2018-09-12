%{
#include <stdlib.h>
#include "y.tab.h"
extern void yyerror(char *);
%}

%%

"if"            return IF;
"=="            return EQ;
"<="            return L;
">="            return G;
"!="            return N;
"print"         return PRINT;
["][\\]n["]            return NEWLINE;
["].*["]          return STRING;   
"then"          return THEN;
"else"          return ELSE;
"endif"         return ENDIF;    


[a-zA-Z]+ {  return ID;}

[0-9]+ {  return INT; }

[><=+*;\(\)/\-] { return *yytext; }

[ \t\n]+        ;       /* ignore whitespace */

.               yyerror("Unknown character");
%%
int yywrap(void) {
    return 1;
}
