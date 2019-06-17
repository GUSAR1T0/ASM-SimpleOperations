#!/bin/bash

# Specific configuration for script
IFS=

declare -a langs=("nasm" "c" "cpp" "csharp")
declare -a languages=("NASM for macOS x64 (gcc)" "C language (clang/LLVM)" "C++ language (clang++/LLVM)" "C# language w/ Mono framework (csc)")
declare -a scripts=("matrix" "string")
declare -a matrix_args=("100\n100\n0" "100\n100\n50" "100\n100\n101" "500\n500\n0" "500\n500\n50" "500\n500\n101" "1000\n1000\n0" "1000\n1000\n50" "1000\n1000\n101")
declare -a string_args=("piacsondcsd;pcnasdc"
                        "ASKNCLAAKSCAJKCA01CAKJSBCKABSCKBASC01CAKCAKSCAKSJCAKB1"
                        "11I1OHIUI1I1I1I11YV1IG1I1O11010101001001010100101010100101"
                        "BPQ92D0HDX90N1E-01UE20Y1EXU01E X10YEB0NX1E2Ewcwocnw wiwcNCOSCNWNO"
                        "cnaosaca0canaosca0SCNlasjnaosaLSN11NCONAOA0CNAJ11111KCC0AS00CA0SNCJA1010101lkscjdcnslkdcsc01mkcajnksnalkx10m ,a, cs clasxjlkanscna01"
                        "000111111010101000010101001010111111100101010101010011111101010101010010101010101001001001010100110100101010010101100101010000101010101010101010101010101010101001010101000101010011101010101011"
                        "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
                        "111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
                        ";xmq,cmqm0wd0c21001c00101c0c1010 [pzp1mpz01010010¡xn1mp10010 z10z10z100x10100101 x00x10x 10mlxmpzkl1z l 1mkjM1oz101xmkjlj1mxljlxmlk1m101mkl1j;x,jamdja;01c,;q01010101011o11j l1lx1lj1l1l110100mc2c0102e012939102390101001m0192903120 9m3,912039120301239102910001 0 ¡2912z23m9,13z, 2381030z23102303285m1040110802111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111")
langs_count=4
scripts_count=2
matrix_count=9
string_count=9

# Functions
function mkd() { [ -d "verdicts" ] || mkdir "verdicts"; }
function cst() { echo $(gdate +%s%N); }
function cpu() { echo $(top -l 1 | grep -E "^CPU" | sed 's/CPU usage: //g'); }
function st() { echo $(echo "scale=6;($2-$1)/(1*10^09)" | bc); }
function ftp() { echo $(echo $1 | tail -14 | sed $'s/^/              /g'); }
# function fop() { echo $(echo $1 | tail -r | tail -n +16 | tail -r | sed $'s/^/              /g'); }

# Main
mkd

current_datetime=$(gdate +%Y%m%d_%H%M%S)
for ((i=0;i<langs_count;i++)) do
    for ((j=0;j<scripts_count;j++)) do
        file="verdicts/${langs[$i]}.${scripts[$j]}.$current_datetime.txt"

        echo -e $'\r'"\033[2KProcessing to $file "

        echo "--------------------------------  VERDICT  --------------------------------" > $file
        echo >> $file

        echo "  GENERAL:" >> $file
        echo "    * language              - ${languages[$i]}" >> $file
        echo "    * task                  - ${scripts[$j]}" >> $file
        echo >> $file

        echo -ne $'\r'"\033[2K -> Compilation"

        compilation_cpu_usage_before=$(cpu)
        compilation_basetime=$(cst)
        compilation_time_profile=$(/usr/bin/time -l builders/${langs[$i]}.sh ${scripts[$j]} 2>&1)
        compilation_endtime=$(cst)
        compilation_cpu_usage_after=$(cpu)
        compilation_time=$(st $compilation_basetime $compilation_endtime)
        binary_file_size=$(stat -f%z ../${langs[$i]}/${scripts[$j]}.b)
        compilation_profile=$(ftp $compilation_time_profile)

        echo "  COMPILATION:" >> $file
        echo "    * compilation time      - $compilation_time seconds" >> $file
        echo "    * CPU usage before      - $compilation_cpu_usage_before" >> $file
        echo "    * CPU usage after       - $compilation_cpu_usage_after" >> $file
        echo "    * binary file size      - $binary_file_size bytes" >> $file
        echo "    * OS result profile:" >> $file
        echo $compilation_profile >> $file
        echo >> $file

        if [ "${scripts[$j]}" = "matrix" ]; then
            count=$matrix_count
            declare -a args=("${matrix_args[@]}")
        elif [ "${scripts[$j]}" = "string" ]; then
            count=$string_count
            declare -a args=("${string_args[@]}")
        fi

        if [ "${langs[$i]}" = "csharp" ]; then
            fw="mono"
        else
            fw=""
        fi

        for ((k=0;k<count;k++)) do
            for ((l=0;l<30;l++)) do
                echo -ne $'\r'"\033[2K -> Execution #$(($k + 1)).$(($l + 1))"

                execution_cpu_usage_before=$(cpu)
                execution_basetime=$(cst)
                execution_time_profile=$(/usr/bin/time -l ./executor.sh ${langs[$i]} ${scripts[$j]} ${args[$k]} $fw 2>&1)
                execution_endtime=$(cst)
                execution_cpu_usage_after=$(cpu)
                execution_time=$(st $execution_basetime $execution_endtime)
                execution_profile=$(ftp $execution_time_profile)

                echo "  EXECUTION #$(($k + 1)).$(($l + 1)):" >> $file
                echo "    * executable argument   - \"${args[$k]}\"" >> $file
                echo "    * execution time        - $execution_time seconds" >> $file
                echo "    * CPU usage before      - $execution_cpu_usage_before" >> $file
                echo "    * CPU usage after       - $execution_cpu_usage_after" >> $file
                echo "    * OS result profile:" >> $file
                echo $execution_profile >> $file
                echo >> $file
            done
        done

        echo "--------------------------------  VERDICT  --------------------------------" >> $file
    done
done

echo -ne $'\r'"\033[2KDone!"
echo
