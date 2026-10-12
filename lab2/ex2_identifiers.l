%option noyywrap
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int line = 1;
char names[1000][256] = {{0}};
int count = 0;
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
"auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"int"|"long"|"register"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"|"abstract"|"assert"|"boolean"|"byte"|"catch"|"class"|"extends"|"final"|"finally"|"implements"|"import"|"instanceof"|"interface"|"native"|"new"|"package"|"private"|"protected"|"public"|"strictfp"|"super"|"synchronized"|"this"|"throw"|"throws"|"transient"|"try"|"true"|"false"|"null" {}
[a-zA-Z_][a-zA-Z0-9_]* {
    int i;
    int found = 0;
    for (i = 0; i < count; i++) {
        if (strcmp(names[i], yytext) == 0) {
            found = 1;
            break;
        }
    }
    if (!found) {
        if (count == 1000 || yyleng >= 256) {
            fprintf(stderr, "Name storage limit exceeded.\n");
            exit(1);
        }
        strcpy(names[count], yytext);
        count++;
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
