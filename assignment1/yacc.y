%{
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
int yylex(void);
void yyerror(char *s);
%}
%token IF PRINT EQ INT ID N G L STRING NEWLINE THEN ELSE ENDIF

%%
program:
        stmt_list    { printf("Rule 1\n"); } 
        ;

stmt_list:
         stmt_list stmt      {printf("Rule 2-1\n");}
         | stmt                { printf("Rule 2-2\n");}
        ;

stmt:
        assign_stmt    {printf("Rule 3-1\n");}
        | print_stmt   {printf("Rule 3-2\n");}
        | if_stmt      {printf("Rule 3-3\n");}
        ;
        
assign_stmt:
        ID '=' expr ';' {printf("Rule 4\n");}
        ;
print_stmt:
        PRINT expr ';'      {printf("Rule 5-1\n");}
        | PRINT STRING ';' {printf("Rule 5-2\n");}
        | PRINT NEWLINE ';' {printf("Rule 5-3\n");}
        ;
if_stmt:
        IF expr THEN stmt_list ENDIF   {printf("Rule 6-1\n");}
        | IF expr THEN stmt_list ELSE stmt_list ENDIF  {printf("Rule 6-2\n");}
        ;
expr:
        '(' expr ')'          {printf("Rule 7-1\n");}
        | expr '+' expr       {printf("Rule 7-2\n");}
        | expr '-' expr        {printf("Rule 7-3\n");} 
        | expr '*' expr        {printf("Rule 7-4\n");} 
        | expr '/' expr        {printf("Rule 7-5\n");}     
        | expr '<' expr        {printf("Rule 7-6\n");} 
        | expr '>' expr        {printf("Rule 7-7\n");}     
        | expr L expr           {printf("Rule 7-8\n");}
        | expr G expr           {printf("Rule 7-9\n");}    
        | expr EQ expr        {printf("Rule 7-10\n");}
        | expr N expr          {printf("Rule 7-11\n");} 
        | INT                   {printf("Rule 7-12\n");}            
        | ID                    {printf("Rule 7-13\n");}
        ;
%%

void yyerror(char *s) {
    extern char* yytext;
    extern int yylineno;
    fprintf(stdout, "%s\nLine No: %d\nAt char: %c\n", s, yylineno,*yytext);
    return ;
}
int main(void) {
    yyparse();
    return 0;
}
