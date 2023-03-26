ENTRY(_bootloader_entry)

SECTIONS
{
    . = 40K;

    .text :
    {
        *(.text)
    }
}