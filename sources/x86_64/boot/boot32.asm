
global _protected_mode_entry

extern handle_cpuid

[bits 32]

    section .text
_protected_mode_entry:
    mov esp, stack_top

    hlt

    section .bss
stack_bottom:
    resb 4096 * 4
stack_top: