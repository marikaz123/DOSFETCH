; GetCPU:PROC * REV. C
; Based on a program written by Ben Lunt (Forever Young Software)

GetCPU        PROC
              LOCALS
              mov di,OFFSET d_cpu
              ;8086
              mov cx,0121h
              shl ch,cl
              jnz @@p_186
              mov si,OFFSET @@8086
              jmp @@eop
@@p_186:
              push sp
              pop ax
              cmp ax,sp
              je @@p_286
              mov si,OFFSET @@186
              jmp @@eop
@@p_286:
              mov ax,7000h
              push ax
              popf
              pushf
              pop ax
              and ax,7000h
              cmp ax,7000h
              je @@p_386
              mov si,OFFSET @@286
              jmp @@eop
@@p_386:
              .386
              push bp
              mov bp,sp
              and sp,0FFFCh
              pushfd
              cli
              pushfd
              pop eax
              mov ebx,eax
              xor eax,40000h
              push eax
              popfd
              pushfd
              pop eax
              popfd
              mov sp,bp
              pop bp
              cmp eax,ebx
              jne @@p_486
              mov si,OFFSET @@386
              jmp @@eop
@@p_486:
              pushfd
              cli
              pushfd
              pop eax
              xor eax,200000h
              push eax
              popfd
              pushfd
              pop ebx
              popfd
              cmp eax,ebx
              je @@p_586
              mov si,OFFSET @@486
              jmp @@eop
@@p_586:
              mov  si,offset @@586
@@eop:
              call CopyStr
              ret

@@8086 DB '8068',0
@@186  DB '80186',0
@@286  DB '80286',0
@@386  DB '80386',0
@@486  DB '80486',0
@@586  DB 'Pentium or better',0

GetCPU        ENDP
