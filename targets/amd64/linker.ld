
/* Setting entry point of bootloader executable file
 * _bootloader_entry is defined in boot.asm for current architecture */
ENTRY(_bootloader_entry)

SECTIONS
{
    /* This is the offset, where out bootloader will load the kernel
     * such hexadecimal value can be iterpreted as 1M offset */
    . = 0x00100000;

    .boot BLOCK(4K): ALIGN(4K)
    {
        KEEP(*(.multiboot))
    }

    /* Text section collects all code instructions from every source file */
    .text BLOCK(4K) : ALIGN(4K)
    {
        *(.text)
    }

    /* Next section that'll be linked is RODATA, which contains read-only data */
    .rodata BLOCK(4K): ALIGN(4K)
    {
        *(.rodata)
    }
}