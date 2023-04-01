
    ; Making entry point of our bootloader available for linker
    ; This is the point where booting process will start executing
    global _bootloader_entry

    ; Declaring TEXT section, where we will put our instructions
    section .text

; After that we can create our start label
; Where our code will begin executing
_bootloader_entry:
    jmp _bootloader_entry

; Due the fact that boot sector should be 512 bytes long
; We're putting zeros to remaining bytes of it
times 510 - ($-$$) db 0

; To make our bootloader identied by BIOS
; We should put the MBR signature at the end of boot sector 
db 0x55, 0xAA