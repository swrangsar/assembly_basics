; nasm -f elf64 hello.asm
; ld -s -o hello hello.o


global      _start



section     .data

msg db `Hello, world!\n`,0
len equ $ - msg

n1  dq  0x0807060504030201
n2  dq  0x3030303030303030




section     .bss
res resb    8




section     .text

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
    
    xor rbx, rbx
    add rbx, 0x30
    call .nextnum

    mov     rax,60
    mov     rdi,0
    syscall


.nextnum:
    mov [res], rbx
    call printnum
    inc rbx
    cmp rbx, 0x39
    jna .nextnum
    ret


printnum:
    mov rax, 1
    mov rdi, 1
    mov [res+1], byte 10
    mov [res+2], byte 0
    mov rsi, res
    mov rdx, 3
    syscall
    ret
