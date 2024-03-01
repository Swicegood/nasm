  segment .data
   msg1 db "Enter first number:",0xA,0xD
   len1 equ $- msg1
   msg2 db "Enter number to add to first number:",0xA,0xD
   len2 equ $- msg2
   msgOutput db "The result is:",0xA
   lenOutput equ $- msgOutput


  segment .bss
    num1 resb 2
    num2 resb 2
    res resb 1
 
  segment .text
    global _start

_start: 

    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,len1
    int 0x80

    mov eax,3
    mov ebx,0
    mov ecx,[num1]
    mov edx,2
    int 0x80


    mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,len2
    int 0x80

    mov eax,3
    mov ebx,0
    mov ecx,[num2]
    mov edx,2
    int 0x80
   
    mov eax,4
    mov ebx,1
    mov ecx,msgOutput
    mov edx,lenOutput
    int 0x80

    mov eax,num1
    add eax,num2
    add eax,'0'
    mov [res],eax

    mov eax,4
    mov ebx,1
    mov ecx,[res]
    mov edx,4
    int 0x80

    mov eax,1
    int 0x80



