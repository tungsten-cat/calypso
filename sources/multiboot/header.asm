
; Defining "magic" fields

; This constant contains "magic" number
; Identifying the header for Multiboot2
MB2_MAGIC_NUMBER equ 0xE85250D6
; This constant specifies CPU ISA
; Where 0 means 32-bit mode of i386
MB2_ARCHITECTURE equ 0x00000000

; This field specifies the length of 
; Multiboot2 header in bytes including "magic" fields
HEADER_LENGTH equ (header_end - header_start)

; Checksum is a 32-bit unsigned value which, when added 
; To the other "maigc" fields, must have 0 as a sum result
HEADER_CHECKSUM equ -(MB2_MAGIC_NUMBER + MB2_ARCHITECTURE + HEADER_LENGTH)

    ; Declaring MULTIBOOT section, which will contain
    ; Identifying header for Multiboot2-compatible bootloader
    section .multiboot

; This label points to the start of Multiboot2 header

; WARNING: DO NOT REMOVE THIS LABEL
; AS IT REQUIRED TO CALCULATE HEADER LENGTH
header_start:
    ; First of all, declare a "magic" number field
    dd MB2_MAGIC_NUMBER
    ; Next, declare field, containing CPU ISA field
    dd MB2_ARCHITECTURE

    ; After that, declare field containing length
    ; Of this Multiboot2 header
    dd HEADER_LENGTH

    ; Next, decalre checksum, this field must be equal to 0
    dd 0x100000000 + HEADER_CHECKSUM

    ; And finally, decalring required end tag
    ; Which contains 3 fields by default

    ; The first field is a "type" field
    dw 0x0000
    ; The second is a "flags" field which
    ; If set to 0 tells bootloader to ignore this tag
    dw 0x0000
    
    ; And the last one is a size, which is a HEX
    ; Size of this tag, including header fields
    dd 0x00000008

; This label points to the end of Multiboot2 header

; WARNING: DO NOT REMOVE THIS LABEL
; AS IT REQUIRED TO CALCULATE HEADER LENGTH
header_end: