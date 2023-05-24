
    ; This code will be running in Protected Mode (32-bit)
    [bits 32]

    ; Making entry point of our bootloader available for linker
    ; This is the point where booting process will start executing
    global _bootloader_entry

    ; Declaring TEXT section, where we will put our instructions
    section .text

; After that we can create our start label
; Where our code will begin executing
_bootloader_entry:
    ; Before we start, we have to bootstrap our stack
    ; By setting ESP register to the top of the stack
    mov esp, stack_top

    ; And the next step is to run our main function
    ; This function is declared under sources/kernel/main.c
    extern kernel_entry
    call kernel_entry

    ; This instruction halts our CPU
    ; To prevent executing undefined code
    jmp $

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