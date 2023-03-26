
global _protected_mode_entry

extern handle_cpuid
extern handle_long_mode

extern setup_page_table
extern enable_paging

extern _long_mode_entry

[bits 32]

    section .text
_protected_mode_entry:
    mov esp, stack_top

    call handle_cpuid     ; Check if CPUID is supported by the CPU
    call handle_long_mode ; Check if Long Mode can be used

    call setup_page_table
    call enable_paging

    lgdt [GDT64_descriptor]

    jmp GDT64_start.code_segment:_long_mode_entry

    hlt

GDT64_start:
    dq 0x0000000000000000
.code_segment:
    dq 0x0020980000000000
.data_segment:
    dq 0x0000920000000000
GDT64_end:

GDT64_descriptor:
    dw GDT64_end - GDT64_start - 1
    dd GDT64_start

    section .bss
stack_bottom:
    resb 4096 * 4
stack_top: