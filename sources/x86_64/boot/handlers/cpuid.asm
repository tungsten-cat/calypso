
global handle_cpuid

[bits 32]

    section .text
handle_cpuid:
    ; PUSHFD - push the current contents of the EFLAGS register
    ; onto the top of the stack

    ; POPFD - pop the current contents from the top of the stack 
    ; and stores the value in the EFLAGS register
    
    pushfd ; Save original EFLAGS 
    pushfd ; Store EFLAGS for comparing

    xor dword [esp], 1 << 21 ; Invert the ID bit in stored EFLAGS

    popfd  ; Load stored EFLAGS with ID bit inverted
    pushfd ; Store EFLAGS again, ID bit may or may not be inverted

    pop eax        ; Store modified EFLAGS to the EAX register
    xor eax, [esp] ; In the EAX register stored bits that were changed

    popfd ; Restore original EFLAGS

    ; If ID bit can't be changed, 0 will be stored in the EAX
    ; Otherwise, will be stored non-zero value 
    and eax, 1 << 21

    ret

.cpuid_not_supported: