
; Before entering Protected Mode we should bootstrap GDT

; GDT is a data structure for Intel x86-family processors
; Which is used to define the characteristics
; Of the various memory areas used durning our kernel executing  

    ; Since we are not going to change our GDT
    ; We'll put it's code to a READ-ONLY SEGMENT
    section .rodata

; Here is the beginning of our GDT32
; (DON'T REMOVE THIS LABELS, THEY ARE USED TO CALCULATE VALUES FOR DESCRIPTOR)
GDT32_start:
    ; First entry, our table should contain is a Null Descriptor
    dq 0x0000000000000000

    ; The next one is a CODE segment
.GDT32_code:
    dq 0x00CF9A000000FFFF

    ; And the last one for now is a DATA segment
.GDT32_data:
    dq 0x00CF92000000FFFF

; After that, we'll also create a label pointing to the end of our GDT
GDT32_end:

; Finally, we should create GDT descriptor
; Which is required to load our GDT 

GDT32_descriptor:
    ; The first field of our descriptor is the size of our table
    dw GDT32_end - GDT32_start - 1

    ; And the second field is the address of location, where our GDT begins
    dd GDT32_start
