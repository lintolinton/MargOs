print_hex:
    ;dx == 0x1f67 the val to print
    ;for int val, isolate it from the rest
    pusha
    mov ax, 0xf000
    mov cx, 0x03
    isolate:
        mov bx, dx
        and bx, cx
        shr bx, cl
        sub ax, 0x01
        cmp ax, 0x00
        jne isolate
        jmp end_isolate
    end_isolate:
        popa
        ret

hex:
    db "0x0000", 0