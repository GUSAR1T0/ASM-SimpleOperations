if [ "$#" -ne 1 ]; then
    echo "Incorrect count of parameters: ./builder.sh <script_name>"
    exit 1
fi

# Works w/o C-extern code: eval nasm -f macho64 $1.asm && ld -e _main -macosx_version_min 10.14.0 -no_pie -static -o $1.b $1.o && ./$1.b
cl=`eval nasm -f macho64 $1.asm && gcc -o $1.b $1.o utils.c`