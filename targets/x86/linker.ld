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
    .text
    {
        *(.text)
    }
}