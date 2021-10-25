print:
    ;val to work on is in [dx]
    ;mask irrelevant bits to get our target 4 bit val
    ;we need to convert this 4 bit val to 8 bit ascii
    ;shr to make isolate this nibble
    ;convert to ascii
    ;val is 
    pusha
    mov ax, 3 ;the shifting position of starting nibble
    loop:
        call isolate_nibble ;return nibble in cx
        call to_ascii ; return ascii char in bx
        mov ax, hex
        call save_to_mem
        cmp ax, 0x00
        je end
        jmp loop
    end:
        popa
        ret

isolate_nibble:
    pusha
    ;example if dx == 0x1f32
    mov cx, dx
    and cx, 0xf000 ; dx now 0x1000
    shr dx, ax ;shift 0xf000 3 places right to get 0x000f




hex:
    db "0x0000", 0