section .text
        global _start

   _print:
        mov ebx, 1
        mov eax, 4
        int 0x80
        ret

  
   _start:     ;tell compiler or linker entry point

	mov eax, 0x0000ffff  ;number to be factored
	mov ebx,0	
 	
   _factor:	;find factors of number
	xor edx,edx		;clear edx
	inc ebx
	div ebx			;divide by a number to see if it is a factor
	cmp edx,0		;is it a factor?
	jz ConvertNumber        ;if it is then coverti it to decimal
	
    _factor2:
	mov eax, 0x0000ffff			;restore eax to original number
	cmp ebx, eax    ;compare counter with original number
	jne _factor

	mov eax,1
	int 0x80

; ConvertNumber
;   Input:
;     ax = Number to be converted
;     bx = Base
;   
;   Output:
;     si = Start of NUL-terminated buffer
;          containing the converted number
;          in ASCII represention.

ConvertNumber:
    push eax            ; Save modified registers
    push ebx
    push edx
    mov eax, ebx
    mov esi, ASCII+8  ; Start at the end
.convert:
    xor edx, edx         ; Clear dx for division
    mov ebx, 10
    div ebx             ; Divide by base
    add dl, '0'        ; Convert to printable char
    cmp dl, '9'        ; Hex digit?
    jbe .store         ; No. Store it
    add dl, 'A'-'0'-10 ; Adjust hex digit
.store:
    dec esi             ; Move back one position
    mov [esi], dl     ; Store converted digit
    and eax, eax         ; Division result 0?
    jnz .convert       ; No. Still digits to convert
    mov ecx, esi    ;put adress of buffer where string is here to prepare for printing
    call _print
    pop edx             ; Restore modified registers
    pop ebx
    pop eax
    jmp _factor2

section .data

 ASCII DB "00000000",0xA,"$" ; buffer for ASCII string


