%option noyywrap
%{
#include <stdio.h>

int chars = 0;
int words = 0;
int lines = 0;
int last_newline = 1;
%}
%%
[^ \t\r\n\f\v]+ { words++; chars += yyleng; last_newline = 0; }
\n { lines++; chars++; last_newline = 1; }
[ \t\r\f\v]+ { chars += yyleng; last_newline = 0; }
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
    if (chars > 0 && !last_newline) lines++;
    printf("Characters: %d\nWords: %d\nLines: %d\n", chars, words, lines);
    fclose(yyin);
    return 0;
}
