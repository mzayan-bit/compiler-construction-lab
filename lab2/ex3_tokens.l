%option noyywrap
%{
#include <stdio.h>

#define AUTO 1
#define BREAK 2
#define CASE 3
#define CHAR 4
#define CONST 5
#define CONTINUE 6
#define DEFAULT 7
#define DO 8
#define DOUBLE 9
#define ELSE 10
#define ENUM 11
#define EXTERN 12
#define FLOAT 13
#define FOR 14
#define GOTO 15
#define IF 16
#define INT 17
#define LONG 18
#define REGISTER 19
#define RETURN 20
#define SHORT 21
#define SIGNED 22
#define SIZEOF 23
#define STATIC 24
#define STRUCT 25
#define SWITCH 26
#define TYPEDEF 27
#define UNION 28
#define UNSIGNED 29
#define VOID 30
#define VOLATILE 31
#define WHILE 32
#define STRING 33
#define CHAR_LITERAL 34
#define NUM 35
#define ID 36
#define LSHIFT_ASSIGN 37
#define RSHIFT_ASSIGN 38
#define INC 39
#define DEC 40
#define ARROW 41
#define LE 42
#define GE 43
#define EQ 44
#define NE 45
#define AND 46
#define OR 47
#define LSHIFT 48
#define RSHIFT 49
#define PLUS_ASSIGN 50
#define MINUS_ASSIGN 51
#define MUL_ASSIGN 52
#define DIV_ASSIGN 53
#define MOD_ASSIGN 54
#define AND_ASSIGN 55
#define OR_ASSIGN 56
#define XOR_ASSIGN 57
#define ELLIPSIS 58
#define LPAREN 59
#define RPAREN 60
#define LBRACE 61
#define RBRACE 62
#define LBRACKET 63
#define RBRACKET 64
#define LT 65
#define GT 66
#define ASSIGN 67
#define PLUS 68
#define MINUS 69
#define MUL 70
#define DIV 71
#define MOD 72
#define NOT 73
#define BITAND 74
#define BITOR 75
#define XOR 76
#define BITNOT 77
#define SEMICOLON 78
#define COMMA 79
#define DOT 80
#define COLON 81
#define QUESTION 82
#define HASHHASH 83
#define HASH 84
#define OTHER 85
%}
%%
[ \t\r\n\f\v]+ {}
"//"[^\n]* {}
\/\*([^*]|\*+[^*/])*\*+\/ {}
"auto" { return AUTO; }
"break" { return BREAK; }
"case" { return CASE; }
"char" { return CHAR; }
"const" { return CONST; }
"continue" { return CONTINUE; }
"default" { return DEFAULT; }
"do" { return DO; }
"double" { return DOUBLE; }
"else" { return ELSE; }
"enum" { return ENUM; }
"extern" { return EXTERN; }
"float" { return FLOAT; }
"for" { return FOR; }
"goto" { return GOTO; }
"if" { return IF; }
"int" { return INT; }
"long" { return LONG; }
"register" { return REGISTER; }
"return" { return RETURN; }
"short" { return SHORT; }
"signed" { return SIGNED; }
"sizeof" { return SIZEOF; }
"static" { return STATIC; }
"struct" { return STRUCT; }
"switch" { return SWITCH; }
"typedef" { return TYPEDEF; }
"union" { return UNION; }
"unsigned" { return UNSIGNED; }
"void" { return VOID; }
"volatile" { return VOLATILE; }
"while" { return WHILE; }
\"([^\"\\\n]|\\.)*\" { return STRING; }
\'([^\'\\\n]|\\.)*\' { return CHAR_LITERAL; }
([0-9]+(\.[0-9]*)?|\.[0-9]+)([eE][+-]?[0-9]+)? { return NUM; }
[a-zA-Z_][a-zA-Z0-9_]* { return ID; }
"<<=" { return LSHIFT_ASSIGN; }
">>=" { return RSHIFT_ASSIGN; }
"++" { return INC; }
"--" { return DEC; }
"->" { return ARROW; }
"<=" { return LE; }
">=" { return GE; }
"==" { return EQ; }
"!=" { return NE; }
"&&" { return AND; }
"||" { return OR; }
"<<" { return LSHIFT; }
">>" { return RSHIFT; }
"+=" { return PLUS_ASSIGN; }
"-=" { return MINUS_ASSIGN; }
"*=" { return MUL_ASSIGN; }
"/=" { return DIV_ASSIGN; }
"%=" { return MOD_ASSIGN; }
"&=" { return AND_ASSIGN; }
"|=" { return OR_ASSIGN; }
"^=" { return XOR_ASSIGN; }
"..." { return ELLIPSIS; }
"(" { return LPAREN; }
")" { return RPAREN; }
"{" { return LBRACE; }
"}" { return RBRACE; }
"[" { return LBRACKET; }
"]" { return RBRACKET; }
"<" { return LT; }
">" { return GT; }
"=" { return ASSIGN; }
"+" { return PLUS; }
"-" { return MINUS; }
"*" { return MUL; }
"/" { return DIV; }
"%" { return MOD; }
"!" { return NOT; }
"&" { return BITAND; }
"|" { return BITOR; }
"^" { return XOR; }
"~" { return BITNOT; }
";" { return SEMICOLON; }
"," { return COMMA; }
"." { return DOT; }
":" { return COLON; }
"?" { return QUESTION; }
"##" { return HASHHASH; }
"#" { return HASH; }
. { return OTHER; }
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
    int token;
    while ((token = yylex()) != 0) {
        switch (token) {
            case AUTO: printf("<AUTO>"); break;
            case BREAK: printf("<BREAK>"); break;
            case CASE: printf("<CASE>"); break;
            case CHAR: printf("<CHAR>"); break;
            case CONST: printf("<CONST>"); break;
            case CONTINUE: printf("<CONTINUE>"); break;
            case DEFAULT: printf("<DEFAULT>"); break;
            case DO: printf("<DO>"); break;
            case DOUBLE: printf("<DOUBLE>"); break;
            case ELSE: printf("<ELSE>"); break;
            case ENUM: printf("<ENUM>"); break;
            case EXTERN: printf("<EXTERN>"); break;
            case FLOAT: printf("<FLOAT>"); break;
            case FOR: printf("<FOR>"); break;
            case GOTO: printf("<GOTO>"); break;
            case IF: printf("<IF>"); break;
            case INT: printf("<INT>"); break;
            case LONG: printf("<LONG>"); break;
            case REGISTER: printf("<REGISTER>"); break;
            case RETURN: printf("<RETURN>"); break;
            case SHORT: printf("<SHORT>"); break;
            case SIGNED: printf("<SIGNED>"); break;
            case SIZEOF: printf("<SIZEOF>"); break;
            case STATIC: printf("<STATIC>"); break;
            case STRUCT: printf("<STRUCT>"); break;
            case SWITCH: printf("<SWITCH>"); break;
            case TYPEDEF: printf("<TYPEDEF>"); break;
            case UNION: printf("<UNION>"); break;
            case UNSIGNED: printf("<UNSIGNED>"); break;
            case VOID: printf("<VOID>"); break;
            case VOLATILE: printf("<VOLATILE>"); break;
            case WHILE: printf("<WHILE>"); break;
            case STRING: printf("<STRING>"); break;
            case CHAR_LITERAL: printf("<CHAR_LITERAL>"); break;
            case NUM: printf("<NUM>"); break;
            case ID: printf("<ID>"); break;
            case LSHIFT_ASSIGN: printf("<LSHIFT_ASSIGN>"); break;
            case RSHIFT_ASSIGN: printf("<RSHIFT_ASSIGN>"); break;
            case INC: printf("<INC>"); break;
            case DEC: printf("<DEC>"); break;
            case ARROW: printf("<ARROW>"); break;
            case LE: printf("<LE>"); break;
            case GE: printf("<GE>"); break;
            case EQ: printf("<EQ>"); break;
            case NE: printf("<NE>"); break;
            case AND: printf("<AND>"); break;
            case OR: printf("<OR>"); break;
            case LSHIFT: printf("<LSHIFT>"); break;
            case RSHIFT: printf("<RSHIFT>"); break;
            case PLUS_ASSIGN: printf("<PLUS_ASSIGN>"); break;
            case MINUS_ASSIGN: printf("<MINUS_ASSIGN>"); break;
            case MUL_ASSIGN: printf("<MUL_ASSIGN>"); break;
            case DIV_ASSIGN: printf("<DIV_ASSIGN>"); break;
            case MOD_ASSIGN: printf("<MOD_ASSIGN>"); break;
            case AND_ASSIGN: printf("<AND_ASSIGN>"); break;
            case OR_ASSIGN: printf("<OR_ASSIGN>"); break;
            case XOR_ASSIGN: printf("<XOR_ASSIGN>"); break;
            case ELLIPSIS: printf("<ELLIPSIS>"); break;
            case LPAREN: printf("<LPAREN>"); break;
            case RPAREN: printf("<RPAREN>"); break;
            case LBRACE: printf("<LBRACE>"); break;
            case RBRACE: printf("<RBRACE>"); break;
            case LBRACKET: printf("<LBRACKET>"); break;
            case RBRACKET: printf("<RBRACKET>"); break;
            case LT: printf("<LT>"); break;
            case GT: printf("<GT>"); break;
            case ASSIGN: printf("<ASSIGN>"); break;
            case PLUS: printf("<PLUS>"); break;
            case MINUS: printf("<MINUS>"); break;
            case MUL: printf("<MUL>"); break;
            case DIV: printf("<DIV>"); break;
            case MOD: printf("<MOD>"); break;
            case NOT: printf("<NOT>"); break;
            case BITAND: printf("<BITAND>"); break;
            case BITOR: printf("<BITOR>"); break;
            case XOR: printf("<XOR>"); break;
            case BITNOT: printf("<BITNOT>"); break;
            case SEMICOLON: printf("<SEMICOLON>"); break;
            case COMMA: printf("<COMMA>"); break;
            case DOT: printf("<DOT>"); break;
            case COLON: printf("<COLON>"); break;
            case QUESTION: printf("<QUESTION>"); break;
            case HASHHASH: printf("<HASHHASH>"); break;
            case HASH: printf("<HASH>"); break;
            case OTHER: printf("<OTHER>"); break;
        }
    }
    printf("\n");
    fclose(yyin);
    return 0;
}
