
    ; Making entry point of our bootloader available for linker
    ; This is the point where booting process will start executing
    global _bootloader_entry

    ; Declaring TEXT section, where we will put our instructions
    section .text

    ; This code will be running in Protected Mode (32-bit)
    [bits 32]

; After that we can create our start label
; Where our code will begin executing
_bootloader_entry:
    jmp _bootloader_entry

