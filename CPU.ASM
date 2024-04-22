; GetCPU:PROC * REV. B
; BASED ON AN EXAMPLE FROM BORLAND TASM 5.0 PACKAGE

GetCPU        PROC
              LOCALS
              mov di,OFFSET d_cpu
              ;8086 bits 12-15 are always set
              pushf
              pop bx
              mov ax,0fffh
              and ax,bx
              push ax
              popf
              pushf
              pop ax
              and ax,0f000h
              cmp ax,0f000h
              mov si,OFFSET @@8086
              je @@eop
              ;80286 bits 12-15 are always cleared
              or bx, 0f000h
              push bx
              popf
              pushf
              pop ax
              and ax, 0f000h
              mov si,OFFSET @@286
              jz @@eop
.386
              pushfd
              pop eax
              mov ecx,eax
              xor eax,40000h
              push eax
              popfd
              pushfd
              pop eax
              xor eax,ecx
              mov si,OFFSET @@386
              je @@eop
;486
              mov si,OFFSET @@486
              pushfd
              pop eax
              mov ecx,eax
              or eax,200000h
              push eax
              popfd
              pushfd
              pop eax
              xor eax,ecx
              je @@eop
              mov si,OFFSET @@586
@@eop:
              call CopyStr
              ret

@@8086 DB '8068',0
@@286  DB '80286',0
@@386  DB 'i386',0
@@486  DB 'i486',0
@@586  DB 'Pentium or better',0

GetCPU        ENDP
