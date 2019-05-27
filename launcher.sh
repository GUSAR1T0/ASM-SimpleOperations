#!/bin/bash

# Prepared data
matrix_args="20\n20\n50"
string_args="000111111010101"

# Functional part
lang=`echo "$1" | awk '{print tolower($0)}'`
script=`echo "$2" | awk '{print tolower($0)}'`
if ([ "$#" -lt 2 ] || [ "$#" -gt 3 ]) || ([ "$lang" != "nasm" ] && [ "$lang" != "c" ] && [ "$lang" != "cpp" ] && [ "$lang" != "csharp" ]) || ([ "$script" != "matrix" ] && [ "$script" != "string" ]); then
    echo "Incorrect parameters: ./launcher.sh (nasm|c|cpp|csharp) (matrix|string) [-p]"
    exit 1
else
    prepared=$(if [ "$3" = "-p" ]; then echo true; else echo false; fi)
fi

cd $lang
if [ "$?" -ne 0 ]; then
    exit 1
fi

if [ "$lang" = "nasm" ]; then
    compilation_cpu_usage_before=$(top -l 1 | grep -E "^CPU")
    compilation_basetime=$(gdate +%s%N)
    cmd=`eval nasm -f macho64 $script.asm && gcc -o $script.b $script.o`
    es=$?
    compilation_endtime=$(gdate +%s%N)
    compilation_cpu_usage_after=$(top -l 1 | grep -E "^CPU")
    language="NASM for macOS x64 (gcc)"
elif [ "$lang" = "c" ]; then
    compilation_cpu_usage_before=$(top -l 1 | grep -E "^CPU")
    compilation_basetime=$(gdate +%s%N)
    cmd=`eval clang -std=c99 $script.c -o $script.b`
    es=$?
    compilation_endtime=$(gdate +%s%N)
    compilation_cpu_usage_after=$(top -l 1 | grep -E "^CPU")
    language="C language (clang/LLVM)"
elif [ "$lang" = "cpp" ]; then
    compilation_cpu_usage_before=$(top -l 1 | grep -E "^CPU")
    compilation_basetime=$(gdate +%s%N)
    cmd=`eval clang++ -std=c++14 $script.cpp -o $script.b`
    es=$?
    compilation_endtime=$(gdate +%s%N)
    compilation_cpu_usage_after=$(top -l 1 | grep -E "^CPU")
    language="C++ language (clang++/LLVM)"
elif [ "$lang" = "csharp" ]; then
    compilation_cpu_usage_before=$(top -l 1 | grep -E "^CPU")
    compilation_basetime=$(gdate +%s%N)
    cmd=`eval csc /t:exe /out:$script.b $script.cs utils.cs`
    es=$?
    compilation_endtime=$(gdate +%s%N)
    compilation_cpu_usage_after=$(top -l 1 | grep -E "^CPU")
    language="C# language w/ Mono framework (csc)"
fi

if [ "$es" -ne 0 ]; then
    rm -rf $script.b $script.o
    cd ..
    exit 2
fi

if [ "$?" -eq 0 ]; then
    if [ "$lang" != "csharp" ]; then
        if [ "$script" = "matrix" ]; then
            if [ "$prepared" = false ]; then
                execution_cpu_usage_before=$(top -l 1 | grep -E "^CPU")
                execution_basetime=$(gdate +%s%N)
                eval ./$script.b
                execution_endtime=$(gdate +%s%N)
                execution_cpu_usage_after=$(top -l 1 | grep -E "^CPU")
            else
                execution_cpu_usage_before=$(top -l 1 | grep -E "^CPU")
                execution_basetime=$(gdate +%s%N)
                echo -e "$matrix_args" | eval ./$script.b
                execution_endtime=$(gdate +%s%N)
                execution_cpu_usage_after=$(top -l 1 | grep -E "^CPU")
            fi
        else
            if [ "$prepared" = false ]; then
                execution_cpu_usage_before=$(top -l 1 | grep -E "^CPU")
                execution_basetime=$(gdate +%s%N)
                eval ./$script.b
                execution_endtime=$(gdate +%s%N)
                execution_cpu_usage_after=$(top -l 1 | grep -E "^CPU")
            else
                execution_cpu_usage_before=$(top -l 1 | grep -E "^CPU")
                execution_basetime=$(gdate +%s%N)
                echo -e "$string_args" | eval ./$script.b
                execution_endtime=$(gdate +%s%N)
                execution_cpu_usage_after=$(top -l 1 | grep -E "^CPU")
            fi
        fi
    else
        if [ "$script" = "matrix" ]; then
            if [ "$prepared" = false ]; then
                execution_cpu_usage_before=$(top -l 1 | grep -E "^CPU")
                execution_basetime=$(gdate +%s%N)
                eval mono ./$script.b
                execution_endtime=$(gdate +%s%N)
                execution_cpu_usage_after=$(top -l 1 | grep -E "^CPU")
            else
                execution_cpu_usage_before=$(top -l 1 | grep -E "^CPU")
                execution_basetime=$(gdate +%s%N)
                echo -e "$matrix_args" | eval mono $script.b
                execution_endtime=$(gdate +%s%N)
                execution_cpu_usage_after=$(top -l 1 | grep -E "^CPU")
            fi
        else
            if [ "$prepared" = false ]; then
                execution_cpu_usage_before=$(top -l 1 | grep -E "^CPU")
                execution_basetime=$(gdate +%s%N)
                eval mono ./$script.b
                execution_endtime=$(gdate +%s%N)
                execution_cpu_usage_after=$(top -l 1 | grep -E "^CPU")
            else
                execution_cpu_usage_before=$(top -l 1 | grep -E "^CPU")
                execution_basetime=$(gdate +%s%N)
                echo -e "$string_args" | eval mono $script.b
                execution_endtime=$(gdate +%s%N)
                execution_cpu_usage_after=$(top -l 1 | grep -E "^CPU")
            fi
        fi
    fi
else
    rm -rf $script.b $script.o
fi

script=`echo "$script" | awk '{print toupper($0)}'`
binary_file_size=`stat -f%z $script.b`
compilation_time=$(echo "scale=6;(${compilation_endtime}-${compilation_basetime})/(1*10^09)" | bc)
execution_time=$(echo "scale=6;(${execution_endtime}-${execution_basetime})/(1*10^09)" | bc)
compilation_cpu_usage_before=$(echo $compilation_cpu_usage_before | sed 's/CPU usage: //g')
compilation_cpu_usage_after=$(echo $compilation_cpu_usage_after | sed 's/CPU usage: //g')
execution_cpu_usage_before=$(echo $execution_cpu_usage_before | sed 's/CPU usage: //g')
execution_cpu_usage_after=$(echo $execution_cpu_usage_after | sed 's/CPU usage: //g')
echo
echo "--------------------------------  VERDICT  --------------------------------"
echo
echo " GENERAL:"
echo "   * task                  - $script"
echo "   * language              - $language"
echo "   * prepared data         - $prepared"
echo
echo " COMPILATION:"
echo "   * compilation time      - $compilation_time seconds"
echo "   * CPU usage before      - $compilation_cpu_usage_before"
echo "   * CPU usage after       - $compilation_cpu_usage_after"
echo "   * binary file size      - $binary_file_size bytes"
echo
echo " EXECUTION:"
echo "   * execution time        - $execution_time seconds"
echo "   * CPU usage before      - $execution_cpu_usage_before"
echo "   * CPU usage after       - $execution_cpu_usage_after"
echo
echo "--------------------------------  VERDICT  --------------------------------"

cd ..
