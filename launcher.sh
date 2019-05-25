#!/bin/bash

lang=`echo "$1" | awk '{print tolower($0)}'`
if [ "$#" -ne 2 ] || [ "$lang" != "nasm" ] && [ "$lang" != "c" ] && [ "$lang" != "cpp" ]; then
    echo "Incorrect parameters: ./launcher.sh (nasm|c|cpp) <script_name>"
    exit 1
fi

cd $lang
if [ "$?" -ne 0 ]; then
    exit 1
fi

cl=`eval ./builder.sh $2`
if [ "$?" -ne 0 ]; then
    cd ..
    exit 2
fi

if [ "$?" -eq 0 ]; then
    eval ./$2.b
else
    rm -rf $2.b $2.o
fi

cd ..
