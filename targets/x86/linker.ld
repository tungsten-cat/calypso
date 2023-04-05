/* First of all we'll set output format for our linked kernel */
OUTPUT_FORMAT(elf64-x86_64)

/* Setting entry point of bootloader executable file
 * _bootloader_entry is defined in boot.asm for current architecture */
ENTRY(_bootloader_entry)

/* Setting executable file sections */
SECTIONS
{
    /* This is the offset, where out bootloader will load the kernel
     * such hexadecimal value can be iterpreted as 1M offset */
    . = 0x00100000;

    /* Text section collects all code instructions from every source file */
    .text BLOCK(4K) : ALIGN(4K)
    {
        *(.text)
    }
    
    /* Next section contains READ-ONLY data */
    .rodata BLOCK(4K) : ALIGN(4K)
    {
        *(.rodata)
    }

    /* After that we'll put BSS section
     * which is also a data section, but it contains uninitialized data  */
    .bss BLOCK(4K) : ALIGN(4K)
    {
        *(.bss)
    }
}