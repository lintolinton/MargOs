print_hex:
    ;val to work on is in [dx]
    ;mask irrelevant bits to get our target 4 bit val
    ;we need to convert this 4 bit val to 8 bit ascii
    ;shr to make isolate this nibble
    ;convert to ascii
    ;val is 
    pusha
    mov ax, 3 ;the shifting position of starting nibble
    ;dx == hex value to print
    next_char:
        call isolate_nibble ;return nibble in cx stack
        pop cx
        call to_ascii ; return ascii char in cx
        mov bx, hex
        call save_to_mem
        sub ax, 1
        cmp ax, 0x00
        je end_next_char
        jmp next_char
    end_next_char:
        popa
        ret

to_ascii:
    cmp cx, 0x0a
    jl digits
    add cx, 0x51
    jmp end_to_ascii
    digits:
        add cx, 0x30
    end_to_ascii:
        push cx
        ret
save_to_mem:
    pusha
    
    mov dx, 0x05
    sub bx, dx, ax 
    mov [bx], cx
    ret


isolate_nibble:
    pusha
    ;example if dx == 0x1f32
    mov cx, dx
    cmp ax, 3
    jl test_ax_2
    mov bx, 0xf000
    isolate:
        and cx, bx
        shr cx, ax
        jmp end_isolate_nibble
    test_ax_2:
        cmp ax, 2
        jl test_ax_1
        mov bx, 0x0f00
        jmp isolate
    test_ax_1:
        cmp ax, 1
        jl test_ax_0
        mov bx, 0x00f0
        jmp isolate
    
    test_ax_0:
        cmp ax, 0
        jl error
        mov bx, 0x000f
        jmp isolate
    error:
        mov bx, error_ax_val
        call print
    end_isolate_nibble:
        pop ax
        pop dx
        push cx
        ret


error_ax_val:
    db "AX can't be 0"

hex:
    db "0x0000", 0