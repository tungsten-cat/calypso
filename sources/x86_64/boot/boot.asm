
global _bootloader_entry

mov ah, 0x0E

mov al, 'T'
int 0x10

mov al, 'E'
int 0x10

mov al, 'S'
int 0x10

mov al, 'T'
int 0x10

_bootloader_entry:
    jmp _bootloader_entry

times 510 - ($-$$) db 0

dw 0xAA55