#!/bin/bash

# Prepared data
matrix_args="20\n20\n50"
string_args="000111111010101"

# Prepare for script execution
lang=`echo "$1" | awk '{print tolower($0)}'`
script=`echo "$2" | awk '{print tolower($0)}'`
if ([ "$#" -lt 2 ] || [ "$#" -gt 3 ]) || ([ "$lang" != "nasm" ] && [ "$lang" != "c" ] && [ "$lang" != "cpp" ] && [ "$lang" != "csharp" ]) || ([ "$script" != "matrix" ] && [ "$script" != "string" ]); then
    echo "Incorrect parameters: ./launcher.sh (nasm|c|cpp|csharp) (matrix|string) [-p]"
    exit 1
else
    prepared=$(if [ "$3" = "-p" ]; then echo 1; else echo 0; fi)
fi

# Build application
builders/$lang.sh $script 2>&1
if [ "$?" -ne 0 ]; then
    rm -rf $script.b $script.o
    echo "Failed to build application: $lang - $script"
    exit 2
fi

# Execute application
cmd="../$lang/$script.b"
if [ "$lang" = "csharp" ]; then
    cmd="mono $cmd"
fi
if [ "$prepared" = 1 ]; then
    if [ "$script" = "matrix" ]; then
        cmd="echo -e \"$matrix_args\" | $cmd"
    elif [ "$script" = "string" ]; then
        cmd="echo -e \"$string_args\" | $cmd"
    fi
fi

eval $cmd
