;GegHDDFreeSpace:PROC * REV. B

GetHDDFreeSpace PROC
                LOCALS
                mov di,OFFSET d_disk
                mov ah,36h
                mov dl,3     ;drive C:
                int 21h
                cmp ax,-1
                je @@na
                cmp cx,200h   ;200h = 512 bytes per sector
                jne @@na      ;if cx != 200h -> unknown format
                mul bx        ;if cx == 200h -> free space = ax*bx/2
                shr dx,1      ;.
                rcr ax,1      ;  . DX:AX div 2
                call Long2dec
                mov si,di
                add si,13 ; sep
                sub si,ax
                mov cx,ax
                rep movsb
                mov si,OFFSET @@s_kb
                call CopyStr
                call FillWithSpaces
                ret
          @@na:
                mov si,OFFSET s_na
                call CopyStr
                ret
@@s_kb  DB 'K free',NUL
GetHDDFreeSpace ENDP
