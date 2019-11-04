bits 32 

global start        

extern exit              
import exit msvcrt.dll    
             
    ; a - word; b,c - byte; e - doubleword; x - qword
segment data use32 class=data
    a dw 120
    b db 5
    c db 42
    e dd 1200
    x dq 42000
    
    ;30. a*b-(100-c)/(b*b)+e+x
segment code use32 class=code
    start:
        ; Calculam 100 - c
        mov al, 100
        sub al, [c]     ; AL = 100 - c
        mov bl, al      ; BL = AL = 100 - c
        
        ; Calculam (b*b)
        mov al, [b]
        mov dl, [b]
        imul dl         ; AH:AL(AX) = b*b
        mov cx, ax      ; CX = b*b
        
        mov al, bl      ; AL = 100 - c
        cbw
        cwd             ; DX:AX = 100 - c
        
        ; Calculam (100-c)/(b*b)
        idiv cx         ; AX = cat / DX = rest (100-c)/(b*b)
        
        mov bx, ax      ; BX = (100-c)/(b*b) (catul)
        
        ; Calculam a*b
        mov al, [b]
        cbw             ; AX = b
        mov cx, [a]
        imul cx         ; DX:AX = a*b
        
        push dx
        push ax
        pop ecx         ; ECX = a*b
        
        ; Calculam a*b-(100-c)/(b*b)
        mov ax, bx
        cwde            ; EAX = (100-c)/b*b
        sub ecx, eax
        add ecx, [e]
        
        mov eax, ecx
        cdq             ; EDX:EAX = a*b-(100-c)/(b*b)+e
        
        ; Calculam a*b-(100-c)/(b*b)+e+x
        add eax, [x]
        adc edx, [x+4]

        push    dword 0      
        call    [exit]       
