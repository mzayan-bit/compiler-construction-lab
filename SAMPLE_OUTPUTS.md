# Commands and sample outputs

These outputs were captured by running the programs. Run commands from the compiler_lab folder.

## lab1_ex1_names

```sh
flex lab1/ex1_names.l
gcc lex.yy.c -o names
./names samples/program.c
```

```text
int : line 2
main : line 2
total : line 3
float : line 4
price : line 4
debt : line 5
if : line 8
return : line 11
```

## lab1_ex2_numbers

```sh
flex lab1/ex2_numbers.l
gcc lex.yy.c -o numbers
./numbers samples/program.c
```

```text
123
123.10
-1234
200
1
0
```

## lab1_ex3_counts

```sh
flex lab1/ex3_counts.l
gcc lex.yy.c -o counts
./counts samples/text.txt
```

```text
Characters: 29
Words: 6
Lines: 2
```

## lab1_ex4_tokens

```sh
flex lab1/ex4_tokens.l
gcc lex.yy.c -o tokens
./tokens samples/condition.c
```

```text
<IF><LPAREN><ID><LT><ID><RPAREN>
```

## lab2_ex1_numbers

```sh
flex lab2/ex1_numbers.l
gcc lex.yy.c -o numbers
./numbers samples/program.c
```

```text
123
123.10
-1234
200
1
0
```

## lab2_ex2_identifiers

```sh
flex lab2/ex2_identifiers.l
gcc lex.yy.c -o identifiers
./identifiers samples/Example.java
```

```text
Example : line 2
main : line 3
String : line 3
args : line 3
value : line 4
price : line 5
debt : line 6
```

## lab2_ex3_tokens

```sh
flex lab2/ex3_tokens.l
gcc lex.yy.c -o tokens
./tokens samples/condition.c
```

```text
<IF><LPAREN><ID><LT><ID><RPAREN>
```
