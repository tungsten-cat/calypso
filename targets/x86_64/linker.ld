ENTRY(_bootloader_entry)

SECTIONS
{
    . = 1M;

    .text :
    {
        *(.text)
    }
}