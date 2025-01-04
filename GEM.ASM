; GetExtMemory:PROC * REV. A
;GetBaseMemory:PROC * REV. A

GetBaseMemory   PROC
                LOCALS
                mov di,OFFSET d_basemem
                mov al,16h
                out 70h,al
                jmp $+2
                in al,71h
                mov ah,al
                mov al,15h
                out 70h,al
                jmp $+2
                in al,71h
                or ax,ax
                jnz @@yBM
                mov si,OFFSET s_nop
                call CopyStr
         @@yBM:
                mov dx,0
                call Long2dec
                mov si,di
                add si,13 ;sep.
                sub si,ax
                mov cx,ax
                rep movsb
                mov ax,'K'
                stosb
                call FillWithSpaces
                ret
GetBaseMemory   ENDP

GetExtMemory    PROC
                LOCALS
                mov di,OFFSET d_extmem
                mov al,18h
                out 70h,al
                jmp $+2
                in al,71h
                mov ah,al
                mov al,17h
                out 70h,al
                jmp $+2
                in al,71h
                or ax,ax
                jnz @@yExtM
                mov si,OFFSET s_nop
                call CopyStr
                ret
       @@yExtM:
                mov dx,0
                call Long2dec
                mov si,di
                add si,13
                sub si,ax
                mov cx,ax
                rep movsb
                mov ax,'K'
                stosb
                call FillWithSpaces
                ret
GetExtMemory    ENDP
