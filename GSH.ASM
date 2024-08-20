;GetShell:PROC * REV. A

GetShell        PROC
                LOCALS
                push ds
                mov ax,WORD PTR ds:[2ch]
                mov ds,ax
                mov si,0
        @@find:
                cmp si,241
                ja @@na
                mov cx,8
                mov di,OFFSET @@s_comspec
                repe cmpsb
                jnz @@find
                lea di,d_shell
                call CopyStr
                pop ds
                ret
          @@na:
                pop ds
                mov si,OFFSET s_na
                mov di,OFFSET d_shell
                call CopyStr
                ret
@@s_comspec DB 'COMSPEC='
GetShell        ENDP
