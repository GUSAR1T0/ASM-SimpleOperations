# ASM-SimpleOperations

Assembly - Simple Operations

## Tasks

1. **Matrix**: determine the line numbers, the arithmetic average of elements that are less than the specified value.
2. **String**: replace all zeros with ones in the text, and ones with zeros, starting from the position in which the number of preceding ones exceeds the number of preceding zeros by 1. 

## Launcher

1. NASM for macOS (x64):

```console
$> ./launcher.sh nasm <SCRIPT_NAME>
```

2. C language:

```console
$> ./launcher.sh c <SCRIPT_NAME>
```

3. C++ language:

```console
$> ./launcher.sh cpp <SCRIPT_NAME>
```

4. C# language for macOS w/ Mono Framework:

```console
$> ./launcher.sh csharp <SCRIPT_NAME>
```

## Exmaple of work

```console
$> ./launcher.sh <LAUNGUAGE> matrix
Count of matrix rows: 5
Count of matrix cols: 5

Matrix (size = 5x5, total = 25):
	93	17	57	11	58
	73	86	76	2	18
	55	45	5	38	77
	6	81	10	59	29
	50	19	35	49	33

Row average values:
	1 -> 47
	2 -> 51
	3 -> 44
	4 -> 37
	5 -> 37

Number for average values comparison: 45

Rows comply the condition:
	3 -> 44
	4 -> 37
	5 -> 37

$> ./launcher.sh <LAUNGUAGE> string
Enter the original string:
hf93300--11111

The reworked string:
hf93300--11100
```