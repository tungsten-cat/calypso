
global _bootloader_entry

[bits 16]

    section .text
_bootloader_entry:
    cli                     ; Disable all interrupts
    lgdt [GDT32_descriptor] ; Load General Descriptor Table

    ; Switching the CPU to the 32-bit mode
    ; We can't change the value of this register directly
    ; So we'll set it to the value of another register
    mov eax, cr0 
    or  eax, 1   ; Change the last bit of EAX to 1
    mov cr0, eax ; Since this moment the CPU is running in 32-bit mode

    ; Performing a far jump to alter the value of CS register
    jmp GDT32_start.code_segment:_protected_mode_entry

    hlt

GDT32_start:
    dq 0x0000000000000000 ; Null Descriptor
.code_segment: equ $ - GDT32_start
    dq 0x00CF9A000000FFFF
.data_segment: equ $ - GDT32_start
    dq 0x00CF92000000FFFF
GDT32_end:

GDT32_descriptor:
    dw GDT32_end - GDT32_start - 1 ; The size of the GDT
    dd GDT32_start                 ; Pointer to the beggining of the GDT

[bits 32]

_protected_mode_entry:
    mov al, 'P'
    mov ah, 0x0F

    mov dword [0xB8000], ax

times 510 - ($-$$) db 0

dw 0xAA55 ; MBR signature