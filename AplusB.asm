  segment .data
    A equ 2
    B equ 3

  segment .bss
    res resb 1
 
  segment .text
    global _start

_start: 
    mov eax, A  
    add eax, B
    add eax,'0'
    mov [res], eax
 
    mov eax,4
    mov ebx,1
    mov ecx,res
;    add ecx,'0'
    mov edx,1	
    int 0x80

    mov eax,1
    int 0x80


