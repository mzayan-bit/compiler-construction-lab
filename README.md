# Compiler Construction — Labs 1 and 2

These solutions follow the first two labs in `CS424-L Manual.pdf`:

- Lab 1, printed pages 1–7: Flex file structure, regular expressions, `yytext`, `yyleng`, `yyin`, counters, and returning tokens.
- Lab 2, printed pages 1–3: the same Flex approach, with `yylex()` in a loop and a `switch` to display tokens.

The programs use Flex and basic C. There is no Bison, parser, C++ library, or separate framework. Each `.l` file is complete on its own. Repeated exercises have separate files so either lab can be used independently.

## Setup

The existing macOS tools were checked: Flex 2.6.4 and Apple Clang 21. A small Flex program was compiled and run successfully. No extra software installation was needed.

Open a terminal in this folder:

```sh
cd /Users/zayan/Documents/compiler_lab
```

Build one exercise at a time, exactly as shown in the manual:

```sh
flex lab1/ex1_names.l
gcc lex.yy.c -o names
./names samples/program.c
```

`%option noyywrap` is used exactly as in the manual, so no extra Flex library is needed when linking.

## Exercises

| Exercise | Source | Input file |
| --- | --- | --- |
| Lab 1, 1: names and first line | `lab1/ex1_names.l` | `samples/program.c` |
| Lab 1, 2: numerical constants | `lab1/ex2_numbers.l` | `samples/program.c` |
| Lab 1, 3: characters, words, lines | `lab1/ex3_counts.l` | `samples/text.txt` |
| Lab 1, 4: C tokens | `lab1/ex4_tokens.l` | `samples/condition.c` |
| Lab 2, 1: numerical constants | `lab2/ex1_numbers.l` | `samples/program.c` |
| Lab 2, 2: identifiers and first line | `lab2/ex2_identifiers.l` | `samples/Example.java` |
| Lab 2, 3: C tokens | `lab2/ex3_tokens.l` | `samples/condition.c` |

Replace the sample path with your own file path. Put quotes around paths containing spaces.

The manual asks for commands and displayed output. Actual runs for all seven exercises are recorded in [SAMPLE_OUTPUTS.md](SAMPLE_OUTPUTS.md).

## How the code works

### Flex structure

Each file has three sections, separated by `%%`. The first contains C declarations inside `%{ ... %}`. The second contains pattern/action rules. The third contains `main()`.

`main()` opens the file using `fopen`, assigns it to `yyin`, and calls `yylex()`. `yytext` holds the matched text and `yyleng` holds its length. Empty actions `{}` ignore a match.

Flex chooses the longest matching text. If two rules match the same length, the earlier rule wins. That is why keyword rules come before the identifier rule.

### Names and identifiers

`[a-zA-Z_][a-zA-Z0-9_]*` matches a letter or underscore followed by letters, digits, or underscores. A simple array remembers previously printed names. A loop with `strcmp` checks whether a name has already appeared; `strcpy` stores a new name.

The line counter starts at 1 and increases on each newline. Newlines inside block comments are counted too. Comments and quoted text are skipped.

Lab 1 includes keywords such as `int` and `if`, as requested. For Lab 2, identifiers are interpreted as names excluding C and Java keywords. `String` is included because it is a class name. Skipping whitespace does not join adjacent names or change the original line numbers.

The array holds 1,000 distinct names, each up to 255 characters. The program reports an error if this limit is exceeded.

### Numerical constants

The number rule matches decimal integers and fractions, an optional exponent, and an optional leading minus. Examples: `123`, `123.10`, `-1234`, `.5`, `5.`, and `1e-3`. Every occurrence is printed. Comments, strings, character literals, and names such as `item12` are skipped.

This is a basic pattern exercise: a minus immediately followed by digits is included in the match. For example, `a-12` prints `-12`. Distinguishing subtraction from a negative expression would require more context. Hexadecimal/binary literals and numeric suffixes are outside these basic number rules.

### Characters, words, and lines

A word is a nonempty sequence of non-whitespace characters. `yyleng` adds the matched length to the character count, including spaces and newlines. Each newline increases the line count. A final line without a newline is counted too; an empty file has zero lines.

For the plain ASCII text used in the lab, each byte is one character. This program counts bytes for UTF-8 text as well.

### Token stream

The token programs follow the manual's return-and-switch example. Each rule returns a `#define` token number. `main()` repeatedly calls `yylex()` and prints the matching label. End of input returns 0 and stops the loop.

They handle the 32 traditional C keywords, identifiers, decimal numbers, strings, character literals, punctuation, arithmetic/comparison/logical/bitwise operators, assignments, shifts, increment/decrement, `->`, and `...`. Whitespace, `//` comments, and `/* ... */` comments are ignored. Unrecognized characters produce `<OTHER>`.

A minus is its own token here: `-1234` becomes `<MINUS><NUM>`. These programs tokenize input; they do not preprocess directives or check whether a C program is valid. Newer language extensions and full C/Java literal syntax are outside the scope of these introductory solutions.

For the manual's example:

```sh
flex lab1/ex4_tokens.l
gcc lex.yy.c -o tokens
./tokens samples/condition.c
```

```text
<IF><LPAREN><ID><LT><ID><RPAREN>
```
