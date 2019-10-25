bits 32 

global start        

extern exit              
import exit msvcrt.dll    
                          
segment data use32 class=data
    a db 20 ; 1 byte, 8 bits
    b dw 120 ; 2 bytes, 16 bits
    c dd 8128 ; 4 bytes, 32 bits
    d dq 58974 ; 8 bytes, 64 bits

segment code use32 class=code
    start:
    
        ; d-b+a-(b+c) = 58974 - 120 + 10 - (120 + 8128) = 50616
        
        ;mutam in ax, b
        mov ax, [b]
        mov dx, 0
        
        ;punem in stiva
        
        
        push    dword 0      
        call    [exit]       
