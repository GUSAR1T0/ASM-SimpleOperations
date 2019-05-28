# ASM-SimpleOperations

Assembly - Simple Operations

## Tasks

1. **Matrix**: determine the line numbers, the arithmetic average of elements that are less than the specified value.
2. **String**: replace all zeros with ones in the text, and ones with zeros, starting from the position in which the number of preceding ones exceeds the number of preceding zeros by 1. 

## Launcher

### Arguments

```console
$> cd scripts/
$scripts> ./launcher.sh (nasm|c|cpp|csharp) (matrix|string) [-p]
```

- `./launcher.sh` - launcher script in repository root
- `(nasm|c|cpp|csharp)` - available languages
- `(matrix|string)` - implemented tasks
- `[-p]` - optional, using prepared data

### Languages

1. NASM for macOS x64 (gcc)
2. C language (clang/LLVM)
3. C++ language (clang++/LLVM)
4. C# language for macOS w/ Mono Framework (csc)

## Statistics

### Arguments

```console
$> cd scripts/
$scripts> ./stats.sh
```

- `./stats.sh` - statistics script in repository root

### Results of statistics

All results of statistics are located into `scripts/verdicts` folder.

## Example of work

```console
$scripts> ./launcher.sh <LAUNGUAGE> matrix
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

$scripts> ./launcher.sh <LAUNGUAGE> string
Enter the original string:
hf93300--11111

The reworked string:
hf93300--11100

$scripts> ./stats.sh
Processing to verdicts/nasm.matrix.20190529_001355.txt .........
Processing to verdicts/nasm.string.20190529_001355.txt .
Processing to verdicts/c.matrix.20190529_001355.txt .........
Processing to verdicts/c.string.20190529_001355.txt .
Processing to verdicts/cpp.matrix.20190529_001355.txt .........
Processing to verdicts/cpp.string.20190529_001355.txt .
Processing to verdicts/csharp.matrix.20190529_001355.txt .........
Processing to verdicts/csharp.string.20190529_001355.txt .
Done!
```