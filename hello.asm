; nasm -f elf64 hello.asm
; ld -s -o hello hello.o

section     .text
global      _start

_start:
    mov     rax,1
    mov     rdi,1
    mov     rsi,msg
    mov     rdx,len
    syscall

    
    mov rax, [n1] 
    mov rbx, [n2]
    add rax, rbx
    mov [res], rax
    mov rax, 1
    mov rdi, 1
    mov rsi, res
    mov [res+8], byte 0xa
    mov rdx, 9
    syscall

    mov     rax,60
    mov     rdi,0
    syscall

section     .data

msg db `Hello, world!\n`,0
len equ $ - msg

n1  dq  0x0807060504030201
n2  dq  0x3030303030303030

section     .bss
res resb    8
