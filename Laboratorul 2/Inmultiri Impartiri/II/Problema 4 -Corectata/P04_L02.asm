bits 32 

global start        

extern exit              
import exit msvcrt.dll    

; a,b,c - byte, d - word                      
segment data use32 class=data
    a db 5
    b db 3
    c db 10
    d dw 7

; 2. d*(d+2*a)/(b*c) = 7*(7+2*5) / 30 CAT: 3 REST: 29
segment code use32 class=code
    start:
        ;Calculam (b*c)
        mov al, byte[b]
        mov dl, byte[c]
        mul dl          ;AH:AL(AX) = (b*c) = 10 * 3
        mov bx, ax      ;Rezultatul il salvam in BX
        
        ;Calculam d+2*a in AX
        mov ax, 0
        mov al, [a]
        mov dl, 2
        mul dl          ;AX = 2 * a
        add ax, [d]     ;AX = d+2*a
        
        ;Calculam d*(d+2*a)
        mov dx, [d]
        mul dx          ;DX:AX =  DX * AX = d*(d+2*a) 
        div bx          ;DX:AX / BX = d*(d+2*a) / (b*c)
        
        push    dword 0      
        call    [exit]       
