%option noyywrap
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int line = 1;
char name[200][100];
int n = 0;
%}
%%
"//"[^\n]* {}
\/\*([^*]|\*+[^*/])*\*+\/ {
    int i;
    for (i = 0; i < yyleng; i++) {
        if (yytext[i] == '\n') line++;
    }
}
\"([^\"\\\n]|\\.)*\" {}
\'([^\'\\\n]|\\.)*\' {}
([0-9]+(\.[0-9]*)?|\.[0-9]+)([eE][+-]?[0-9]+)? {}
[a-zA-Z_][a-zA-Z0-9_]* {
    int i;
    int old = 0;
    for (i = 0; i < n; i++) {
        if (strcmp(name[i], yytext) == 0) {
            old = 1;
            break;
        }
    }
    if (!old) {
        if (n == 200 || yyleng >= 100) {
            printf("too many names\n");
            exit(1);
        }
        /* save new name */
        strcpy(name[n], yytext);
        n++;
        printf("%s : line %d\n", yytext, line);
    }
}
\n { line++; }
[ \t\r\f\v]+ {}
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
