;GetCodePage:PROC * REV. A

GetCodePage     PROC
                LOCALS
                mov di,OFFSET d_cp
                cmp BYTE PTR [ver],3
                ja @@skpMin
                cmp BYTE PTR [ver+1],3
                jb @@na
      @@skpMin:
                mov ax,6601h     ;DOS: get code page
                int 21h
                jc @@na
                mov ax,bx
                mov dx,0
                call Long2dec
                mov si,di
                add si,10
                sub si,ax
                mov cx,ax
                rep movsb
                call FillWithSpaces
                ret
          @@na:
                mov si,OFFSET s_na
                call CopyStr
                ret
GetCodePage     ENDP
