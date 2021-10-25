print:
    pusha
    ;base address of string is in bx
    ;cp first char to al
    print_char:
        mov al, [bx] ;cp char in mem to al
        mov ah, 0x0e ;cp 0x0e to ah
        int 0x10 ;int 0x10 to print
        add bx, 1 ;increment dx 
        mov ax, [bx]
        cmp al, 0x00 
        ;cmp value in mem location dx to 00
        je end
        jmp print_char
    end:
        popa ;if not 0 print next char
        ret ;else end

        
        
        
        

