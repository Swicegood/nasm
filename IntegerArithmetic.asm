section .text
	global _start
 
   _print:
	mov ebx, 1
	mov eax, 4
	int 0x80
	ret
 
   _get_input:
	mov edx, 4
	mov ebx, 0
	mov eax, 3
	int 0x80
	ret
 
   _start:
	mov edx, in_val_len
	mov ecx, in_val_msg
	call _print
	mov ecx, a
	call _get_input
			;make 'a' an actual number rather than a char.
	sub dword [a], 0x30
	mov edx, in_val_len
	mov ecx, in_val_msg
	call _print
	mov ecx, b
	call _get_input
			;calc real number for 'b'
	sub dword [b], 0x30
	mov eax, dword [a]
	mov ebx, dword [b]
	add eax, ebx
			;get the character for our sum.
	add eax, 0x30
	mov dword [sum], eax
	mov edx, out_val_len
	mov ecx, out_val_msg
	call _print
	mov [sum+1], dword 0xa
	mov edx, 4
	mov ecx, sum
	call _print
			;Prepare for next phase--subtracing
        mov eax, dword [a]
        mov ebx, dword [b]
        sub eax, ebx
                        ;get the character for our sum.
        add eax, 0x30
        mov dword [diff], eax
        mov edx, out_val_len2
        mov ecx, out_val_msg2
        call _print
        mov [diff+1], dword 0xa
        mov edx, 4
        mov ecx, diff 
        call _print

                        ;Prepare for next phase--multiflying
        mov eax, dword [a]
        mov ebx, dword [b]
        mul ebx
                        ;get the character for our sum.
        add eax, 0x30
        mov dword [prod], eax
        mov edx, out_val_len3
        mov ecx, out_val_msg3
        call _print
        mov [prod+1], dword 0xa
        mov edx, 4
        mov ecx, prod
        call _print

                        ;Prepare for next phase--division  
	mov al, byte [a]
        mov bl, byte [b]
        xor edx, edx
	div ebx
                        ;get the character for our sum.
        add eax, 0x30
	add edx, 0x30
        mov dword [quo], eax
        mov dword [rmd], edx
	mov edx, out_val_len4
        mov ecx, out_val_msg4
        call _print
        mov edx, 4
        mov ecx, quo
        call _print

 	mov edx, out_val_len5
        mov ecx, out_val_msg5
        call _print
        mov [rmd+1], dword 0xa
        mov edx, 4
        mov ecx, rmd
        call _print

	push 0x1
	mov eax, 1
	push eax
	int 0x80
	ret
 
section .data
	in_val_msg db "Please input an integer:",0
	in_val_len equ $-in_val_msg
	out_val_msg db "The sum of a+b is: ",0
	out_val_len equ $-out_val_msg 
        out_val_msg2 db "The result of a-b is: ",0
        out_val_len2 equ $-out_val_msg2
 	out_val_msg3 db "The result of a*b is: ",0
        out_val_len3 equ $-out_val_msg3 
        out_val_msg4 db "The quotient of a/b is: ",0
        out_val_len4 equ $-out_val_msg4
        out_val_msg5 db "The remainder of a/b is: ",0
        out_val_len5 equ $-out_val_msg5

section .bss
	a    resd 1
	b	resd 1
	sum	resd 1
	diff	resd 1
	prod	resd 1
	quo	resd 1
	rmd	resd 1
