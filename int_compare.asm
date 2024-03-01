

;
; file: int_compare.asm
; First assembly program. This program asks for two integers as
; input and prints out their magnitude relationship..
;
; To create executable:
; Using djgpp:
; nasm -f coff first.asm
; gcc -o first first.o driver.c asm_io.o
;
; Using Linux and gcc:
; nasm -f elf first.asm
; gcc -o first first.o driver.c asm_io.o
;
; Using Borland C/C++
; nasm -f obj first.asm
; bcc32 first.obj driver.c asm_io.obj
;
; Using MS C/C++
; nasm -f win32 first.asm
; cl first.obj driver.c asm_io.obj
;
; Using Open Watcom
; nasm -f obj first.asm
; wcl386 first.obj driver.c asm_io.obj

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
;
; These labels refer to strings used for output
;
prompt1 db    "Enter a number: ", 0       ; don't forget nul terminator
prompt2 db    "Enter another number: ", 0
outmsg1 db    "The first number is less than the second.", 0
outmsg2 db    "The first number is equal to the second.", 0
outmsg3 db    "The first number is greater than the second.", 0


;
; uninitialized data is put in the .bss segment
;
segment .bss
;
; These labels refer to double words used to store the inputs
;
input1  resd 1
input2  resd 1

 

;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

        mov     eax, prompt1      ; print out prompt
        call    print_string

        call    read_int          ; read integer
        mov     [input1], eax     ; store into input1

        mov     eax, prompt2      ; print out prompt
        call    print_string

        call    read_int          ; read integer
        mov     [input2], eax     ; store into input2

        mov     eax,[input1]
	mov 	ebx,[input2]
	cmp     eax,ebx          ; compare the two values
	jb	ifbelow
else:
        mov     eax,[input1]
        mov     ebx,[input2]
        cmp     eax,ebx          ; compare the two values	
	je      ifequal

else2:

        mov     eax,[input1]
        mov     ebx,[input2]
        cmp     eax,ebx          ; compare the two values
	ja 	ifabove
	jmp end

ifabove:
	mov     eax, outmsg3
        call    print_string      ; print out third message
        call    print_nl          ; print new-line

end:
        popa
        mov     eax, 0            ; return back to C
        leave
        ret
;next print out result message as series of steps
;

ifbelow:
        mov     eax, outmsg1
        call    print_string      ; print out first message
	jmp else        

ifequal:
	mov     eax, outmsg2
        call    print_string      ; print out second message
	jmp else2        



