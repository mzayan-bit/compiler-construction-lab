%option noyywrap
%{
#include <stdio.h>
%}
%%
"//"[^\n]* {}
\/\*([^*]|\*+[^*/])*\*+\/ {}
\"([^\"\\\n]|\\.)*\" {}
\'([^\'\\\n]|\\.)*\' {}
[a-zA-Z_][a-zA-Z0-9_]* {}
-?([0-9]+(\.[0-9]*)?|\.[0-9]+)([eE][+-]?[0-9]+)? { printf("%s\n", yytext); }
[ \t\r\n]+ {}
. {}
%%
int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Usage: %s input_file\n", argv[0]);
        return 1;
    }
    yyin = fopen(argv[1], "r");
    if (yyin == NULL) {
        perror(argv[1]);
        return 1;
    }
    yylex();
    fclose(yyin);
    return 0;
}
