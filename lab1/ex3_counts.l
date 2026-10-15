%option noyywrap
%{
#include <stdio.h>

int ch = 0;
int word = 0;
int line = 0;
int last = 1;
%}
%%
[^ \t\r\n\f\v]+ { word++; ch += yyleng; last = 0; }
\n { line++; ch++; last = 1; }
[ \t\r\f\v]+ { ch += yyleng; last = 0; }
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
    /* count last line */
    if (ch > 0 && !last) line++;
    printf("characters: %d\nwords: %d\nlines: %d\n", ch, word, line);
    fclose(yyin);
    return 0;
}
