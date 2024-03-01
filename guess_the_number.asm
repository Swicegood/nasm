

;
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
prompt db    "Guess a number between 1 and 10: ", 0       ; don't forget nul terminator
outmsg db    "You guessed correctly!", 0
num db 5           ;secreet number 
guess db 1		;initialize guess


;
; uninitialized data is put in the .bss segment
;
segment .bss
;
; These labels refer to double words used to store the inputs
;

 

;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha
l1:
        mov     eax, prompt      ; print out prompt
        call    print_string

        call    read_int          ; read integer
	cmp	eax,5        
	je 	end	
	loop l1

end:
        mov     eax, outmsg
        call    print_string      ; print out third message

        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


