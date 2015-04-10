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
    cmp rbx, 0xa
    jl .isdigit
    add rbx, 0x57       ; 0x57 = 0x61 - 0xa
    mov [res], rbx
    sub rbx, 0x57
    jmp .endif
.isdigit:
    add rbx, 0x30
    mov [res], rbx
    sub rbx, 0x30
.endif:
    call printnum
    inc rbx
    cmp rbx, 36 
    jl .nextnum
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
