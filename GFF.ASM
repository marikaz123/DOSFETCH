;   GetFPU:PROC * REV. A1
;GetFloppy:PROC * REV. A1

GetFPU          PROC
                LOCALS
                mov di,OFFSET d_fpu
                test eqList,MASK n
                jz @@noFPU
                mov si,OFFSET s_p
                call CopyStr
                ret
       @@noFpu:
                mov si,OFFSET s_nop
                call CopyStr
                ret
GetFPU          ENDP

GetFloppy       PROC
                LOCALS
                mov di,OFFSET d_Floppy
                test eqList,MASK d
                jz @@noFloppy

                mov al,10h
                out 70h,al
                jmp $+2
                in al,71h

                mov ah,al    ;pop
                and al,0fh
                shr ah,4
                or ah,ah
                jz @@chkDB
                mov @@dm,1    ;disk A:
                mov si,OFFSET @@da
                call CopyStr
                push ax
                mov al,ah
                call @SelDisk
                call CopyStr
                pop ax
       @@chkDB:
                or al,al
                jz @@eop
                cmp @@dm,1
                jne @@noComma
                mov WORD PTR [di],' ,'
                add di,2
     @@noComma:
                add @@dm,1
                mov si,OFFSET @@db
                call CopyStr
                call @SelDisk
                call CopyStr
         @@eop:
                cmp @@dm,0
                je @@noFloppy  ;?!
                ret
    @@noFloppy:
                mov si,OFFSET s_nop
                call CopyStr
                ret

@@da DB 'A: ',NUL
@@db DB 'B: ',NUL
@@dm DB 0

GetFloppy       ENDP

@SelDisk        PROC
                LOCALS
                cmp al,1
                jne @@M12
                mov si,OFFSET @@d1
                ret
        @@M12:
                cmp al,10b
                jne @@K720
                mov si,OFFSET @@d2
                ret
        @@K720:
                cmp al,11b
                jne @@M144
                mov si,OFFSET @@d3
                ret
        @@M144:
                cmp al,100b
                jne @@un
                mov si,OFFSET @@d4
                ret
          @@un:
                mov si,OFFSET s_na
                ret

@@d1 DB '(360K)',NUL
@@d2 DB '(1.2M)',NUL
@@d3 DB '(720K)',NUL
@@d4 DB '(1.44M)',NUL
@SelDisk        ENDP