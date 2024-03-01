#!/bin/bash

SOURCE=factor
EXECUTABLE=factor

nasm -f elf "$SOURCE.asm"

ld -m elf_i386 -s -o $EXECUTABLE "$SOURCE.o"

rm "$SOURCE.o"

exit 0
