%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"

int line_no = 1;
%}

%option noyywrap

DIGIT   [0-9]
ID      [A-Za-z_][A-Za-z0-9_]*

%%

[ \t\r]+            ;
"//".*              ;
\n                  { line_no++; }

"LOAD"              { return LOAD; }
"PRINT"             { return PRINT; }
"ADD"               { yylval.ival = '+'; return OPNAME; }
"SUB"               { yylval.ival = '-'; return OPNAME; }
"MUL"               { yylval.ival = '*'; return OPNAME; }
"DIV"               { yylval.ival = '/'; return OPNAME; }
"MOD"               { yylval.ival = '%'; return OPNAME; }

"+"                 { yylval.ival = '+'; return OPSYM; }
"-"                 { yylval.ival = '-'; return OPSYM; }
"*"                 { yylval.ival = '*'; return OPSYM; }
"/"                 { yylval.ival = '/'; return OPSYM; }
"%"                 { yylval.ival = '%'; return OPSYM; }

"("                 { return LPAREN; }
")"                 { return RPAREN; }
","                 { return COMMA; }
";"                 { return SEMI; }

{DIGIT}+            { yylval.ival = atoi(yytext); return NUMBER; }
{ID}                { yylval.sval = strdup(yytext); return IDENT; }

.                   { fprintf(stderr, "Line %d: unknown character '%s'\n", line_no, yytext); }

%%
