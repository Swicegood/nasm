

;file logical.asm tests use of logical operators in assembly

%include "asm_io.inc"

op1 equ 1  ;op1 false
op2 equ 1  ;op2 true

;
; initialized data is put in the .data segment
;
segment .data

;
; These labels refer to strings used for output
;
outmsg1 db    "You entered ", 0
outmsg2 db    " and ", 0
outmsg3 db    ", the logical AND of these is ", 0
outmsg4 db    ", the logical OR of these is ", 0
outmsg5 db    ", the logical XOR of these is ", 0
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

        mov     eax, outmsg1      ; print out message
        call    print_string

	mov	eax, op1
	call 	print_int

        mov     eax, outmsg2      ; print out message
        call    print_string

 	mov     eax, op2
        call    print_int


	mov     eax, outmsg3      ; print out message
        call    print_string


	mov     al, op1     ;  al= byte at op1
        and     al, op2     ; al && byte at op2
	and	eax, 0x00000001      ; clear out highest 31 bits
	call 	print_int
	
;------------------------------------------- now for logical OR

        mov     eax, outmsg4      ; print out message
        call    print_string


	mov     al, op1     ;  al= byte at op1
        or	al, op2     ; al || byte at op2
        and     eax, 0x00000001      ; clear out highest 31 bits
        call    print_int

;------------------------------------------- now for logical XOR
        mov     eax, outmsg5      ; print out message
        call    print_string


	mov     al, op1     ;  al= byte at op1
        xor     al, op2     ; al XOR byte at op2
        and     eax, 0x00000001      ; clear out highest 31 bits
        call    print_int	



        popa
        mov     eax, 0            ; return back to C
        leave                     
        ret


