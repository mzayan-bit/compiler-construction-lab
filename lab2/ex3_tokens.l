%option noyywrap
%{
#include <stdio.h>
%}
%%
[ \t\r\n]+              { /* skip spaces */ }
"//"[^\n]*               { /* skip comment */ }
\/\*([^*]|\*+[^*/])*\*+\/ { /* skip comment */ }
"if"                     { printf("<IF>"); }
"else"                   { printf("<ELSE>"); }
"while"                  { printf("<WHILE>"); }
"for"                    { printf("<FOR>"); }
"do"                     { printf("<DO>"); }
"int"                    { printf("<INT>"); }
"float"                  { printf("<FLOAT>"); }
"double"                 { printf("<DOUBLE>"); }
"char"                   { printf("<CHAR>"); }
"void"                   { printf("<VOID>"); }
"return"                 { printf("<RETURN>"); }
"break"                  { printf("<BREAK>"); }
"continue"               { printf("<CONTINUE>"); }
"switch"                 { printf("<SWITCH>"); }
"case"                   { printf("<CASE>"); }
"default"                { printf("<DEFAULT>"); }
\"([^\"\\\n]|\\.)*\"     { printf("<STRING>"); }
\'([^\'\\\n]|\\.)*\'     { printf("<CHAR_VALUE>"); }
([0-9]+(\.[0-9]*)?|\.[0-9]+) { printf("<NUM>"); }
[a-zA-Z_][a-zA-Z0-9_]*   { printf("<ID>"); }
"<<="                   { printf("<LSHIFT_ASSIGN>"); }
">>="                   { printf("<RSHIFT_ASSIGN>"); }
"++"                     { printf("<INC>"); }
"--"                     { printf("<DEC>"); }
"->"                     { printf("<ARROW>"); }
"<="                     { printf("<LE>"); }
">="                     { printf("<GE>"); }
"=="                     { printf("<EQ>"); }
"!="                     { printf("<NE>"); }
"&&"                     { printf("<AND>"); }
"||"                     { printf("<OR>"); }
"<<"                     { printf("<LSHIFT>"); }
">>"                     { printf("<RSHIFT>"); }
"+="                     { printf("<PLUS_ASSIGN>"); }
"-="                     { printf("<MINUS_ASSIGN>"); }
"*="                     { printf("<MUL_ASSIGN>"); }
"/="                     { printf("<DIV_ASSIGN>"); }
"("                      { printf("<LPAREN>"); }
")"                      { printf("<RPAREN>"); }
"{"                      { printf("<LBRACE>"); }
"}"                      { printf("<RBRACE>"); }
"["                      { printf("<LBRACKET>"); }
"]"                      { printf("<RBRACKET>"); }
"<"                      { printf("<LT>"); }
">"                      { printf("<GT>"); }
"="                      { printf("<ASSIGN>"); }
"+"                      { printf("<PLUS>"); }
"-"                      { printf("<MINUS>"); }
"*"                      { printf("<MUL>"); }
"/"                      { printf("<DIV>"); }
"%"                      { printf("<MOD>"); }
"!"                      { printf("<NOT>"); }
"&"                      { printf("<BITAND>"); }
"|"                      { printf("<BITOR>"); }
";"                      { printf("<SEMICOLON>"); }
","                      { printf("<COMMA>"); }
"."                      { printf("<DOT>"); }
":"                      { printf("<COLON>"); }
"?"                      { printf("<QUESTION>"); }
.                        { printf("<OTHER>"); }
%%
int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("use: %s file\n", argv[0]);
        return 1;
    }
    yyin = fopen(argv[1], "r");
    if (yyin == NULL) {
        printf("file not found\n");
        return 1;
    }
    yylex();
    printf("\n");
    fclose(yyin);
    return 0;
}
