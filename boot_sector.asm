[bits 16]
[org 0x7c00]

mov bx, init_msg
call print

loop:
    jmp loop

mov dx, 0x01f3
call print_hex

%include "includes/print.asm"
%include "includes/print_hex.asm"

init_msg:
    db "Welcome to MargOS", 0

exit_msg:
    db "Bye", 0


times 510 - ($ - $$) db 0

dw 0xaa55