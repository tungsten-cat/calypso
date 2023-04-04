
    ; Making entry point of our bootloader available for linker
    ; This is the point where booting process will start executing
    global _bootloader_entry

    ; Also we should decalare _protected_mode_entry as extern label
    ; As it defined in different file
    extern _protected_mode_entry

    ; Our bootloader will be loaded by BIOS
    ; At the address 0x7C00, so we should tell NASM about it
    [org 0x7c00]

    ; Declaring TEXT section, where we will put our instructions
    section .text

    ; This code will be running in Real Mode (16-bit)
    [bits 16]

; After that we can create our start label
; Where our code will begin executing
_bootloader_entry:
    ; Firstly we should disable interrupts
    ; Because it might break processing our code
    cli
    
    ; Next we should load GDT
    lgdt [GDT32_descriptor]

    ; After that we can swtich to 32-bit mode 
    ; By setting 32-bit mode in CR0 register
    mov eax, cr0
    or  eax, 0x1
    mov cr0, eax

    ; To change our CS register we should perform a far jump
    jmp GDT32_start.GDT32_code:_protected_mode_entry

; Also we should include file with our GDT32
%include "gdt/gdt32.asm"

; Before compiling we should check if our bootloader code
; Is not longer than 512 bytes so it can fit boot segment
%if ($ - $$) > 510
    %fatal "Bootloader code exceed 512 bytes!"
%endif

; Due the fact that boot sector should be 512 bytes long
; We're putting zeros to remaining bytes of it
times 510 - ($-$$) db 0

; To make our bootloader identied by BIOS
; We should put the MBR signature at the end of boot sector 
db 0x55, 0xAA