
    ; This code will be running in Protected Mode (32-bit)
    [bits 32]

    %include "gdt/gdt64.asm"

    ; Declaring TEXT section, where we will put our instructions
    section .text

    ; Making entry point of our bootloader available for linker
    ; This is the point where booting process will start executing
    global _bootloader_entry

; After that we can create our start label
; Where our code will begin executing
_bootloader_entry:
    ; Before we start, we have to bootstrap our stack
    ; By setting ESP register to the top of the stack
    mov esp, stack_top

    call long_mode.handle_multiboot2
    call long_mode.handle_cpuid
    call long_mode.handle_long_mode

    ; And the next step is to run our main function
    ; This function is declared under sources/kernel/main.c
    extern kernel_entry
    call kernel_entry

    ; This instruction halts our CPU
    ; To prevent executing undefined code
    hlt

long_mode.handle_multiboot2:
    cmp eax, 0x36D76289
    jne long_mode.multiboot2_failed
    ret

long_mode.handle_cpuid:
    pushfd
    pushfd
    xor dword [esp], 1 << 21
    popfd
    pushfd
    pop eax
    xor eax, [esp]
    popfd 
    and eax, 1 << 21
    jz long_mode.cpuid_failed
    ret

long_mode.handle_long_mode:
    mov eax, 0x80000000
    cpuid
    cmp eax, 0x80000001
    jb long_mode.long_mode_failed

    mov eax, 0x80000001
    cpuid
    test edx, 1 << 29
    jz long_mode.long_mode_failed

    ret


long_mode.multiboot2_failed:
    mov bl, "M"
    jmp long_mode.print_error

long_mode.cpuid_failed:
    mov bl, "C"
    jmp long_mode.print_error

long_mode.long_mode_failed:
    mov bl, "L"
    jmp long_mode.print_error


long_mode.print_error:
    mov al, "E"
    mov ah, 0x0f

    mov [0xB8000], ax

    mov al, "r"
    mov ah, 0x0f

    mov [0xB8002], ax
    mov [0xB8004], ax

    mov al, "o"
    mov ah, 0x0f

    mov [0xB8006], ax

    mov al, "r"
    mov ah, 0x0f

    mov [0xB8008], ax

    mov al, ":"
    mov ah, 0x0f

    mov [0xB8010], ax
    mov [0xB8014], bx

    hlt

    ; Declaring BSS section for uninitialized data
    section .bss

    ; This code will be aligned on 16-byte boundary
    align 16

    ; Since the multiboot standart doesn't define the value of the ESP register
    ; We'll provide the stack for the kernel manually
    
; This label points to the bottom of the stack
stack_bottom:
    ; Here we'll reserve 16 KiB of memory
    resb 16384
; This label points to the top of the stack
stack_top: