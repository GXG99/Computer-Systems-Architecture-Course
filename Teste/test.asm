bits 32 

global start        

extern exit              
import exit msvcrt.dll    
                          
segment data use32 class=data


segment code use32 class=code
    start:
        mov eax, 2134h
        push eax
        
        mov ebx, 213h
        mov ecx, 2134h
        add ebx, ecx
        mov eax, ecx
        
        pop ecx
        push    dword 0      
        call    [exit]       
