
segment .text
   global _start   ;must be declared for linker (ld)

_start:

   mov eax,3      ;number bytes to be displayed
   mov ecx,x       ;the address of x
;                   dec eax         ;knock off one to start the counting right

_top:
   push eax
   call _convert
   call _display
   pop eax
   dec eax           ;decrement counter
   jnz _top

;end: Here is a big fork inthe road

   mov  eax, 1     ;system call number (sys_exit)
   int  0x80       ;call kernel


_display:

   mov  edx,1      ;message length
   mov  ebx, 1     ;file descriptor (stdout)
   mov  eax, 4     ;system call number (sys_write)
   int  0x80       ;call kernel
   add  ecx,1 
   ret

_convert:
   mov ebx,[ecx]     ;convert to ASCII
   add ebx, '0'
   mov [ecx],ebx
   ret


segment .data
global x
x:    
   db  2
   db  4
   db  3

num db 0
