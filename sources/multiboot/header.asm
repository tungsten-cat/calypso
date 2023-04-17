
MAGIC_NUMBER equ 0xE85250D6
ARCHITECTURE equ 0x00000000

HEADER_LENGTH equ (header_end - header_start)

CHECKSUM equ -(MAGIC_NUMBER + ARCHITECTURE + HEADER_LENGTH)

    section .multiboot

header_start:
    dd MAGIC_NUMBER
    dd ARCHITECTURE

    dd HEADER_LENGTH

    dd 0x100000000 + CHECKSUM

    dw 0x0000
    dw 0x0000
    
    dd 0x00000008
header_end: