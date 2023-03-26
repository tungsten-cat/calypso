
global handle_long_mode

[bits 32]

    section .text
handle_long_mode:
    mov eax, 0x80000000
    cpuid
    cmp eax, 0x80000001
    jb .long_mode_error

    mov eax, 0x80000001
    cpuid
    test edx, 1 << 29
    jz .long_mode_error 

    ret

.long_mode_error:
    mov al, 'L'
    mov ah, 0x0F

    mov [0xB800], ax

    hlt