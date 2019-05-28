#!/bin/bash
cd ../nasm/
eval nasm -f macho64 $1.asm && gcc -o $1.b $1.o