; nasm -f elf64 hello.asm
; ld -s -o hello hello.o





section     .data

msg db `Hello, world!\n`,0
len equ $ - msg

n1  dq  0x0807060504030201
n2  dq  0x3030303030303030




section     .bss
res resb    8




section     .text

global  _start
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
    call .nextnum

    mov     rax,60
    mov     rdi,0
    syscall


.nextnum:
    push rbx
    call printnum
    pop rbx
    inc rbx
    cmp rbx, 36 
    jl .nextnum
    ret


printnum:
    cmp rbx, 0xa
    jl .isdecimal
    add rbx, 0x57
    jmp .endif
.isdecimal:
    add rbx, 0x30
.endif:
    mov rax, 1
    mov rdi, 1
    mov [res], rbx
    mov [res+1], byte 10
    mov [res+2], byte 0
    mov rsi, res
    mov rdx, 3
    syscall
    ret
