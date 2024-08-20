;----------------------------------------------------------------------------
;  DOSFETCH v1.0
;                                                                    marikaz
;----------------------------------------------------------------------------

BLK   = 0      ;BLACK
BLU   = 1      ;BLUE
GRE   = 2      ;GREEN
CYA   = 3      ;CYAN
RED   = 4      ;RED
MAG   = 5      ;MAGENTA
BRO   = 6      ;BROWN
GRE   = 7      ;GREY
DGRE  = 8      ;DARKGREY
LBLU  = 9      ;LIGHTBLUE
LGRE  = 0ah    ;LIGHTGREEN
LCYA  = 0bh    ;LIGHTCYAN
LRED  = 0ch    ;LIGHTRED
LMAG  = 0dh    ;LIGHTMAGENTA
YEL   = 0eh    ;YELLOW
WHI   = 0fh    ;WHITE

CR    = 0dh
LF    = 0ah
NUL   = 0
SPACE = 20h
EOS   = '$'
TRM   = -1
DTA   = 80h

;INFO FORM
HEADC = WHI ;heading color
TEXTC = GRE ;text color

EQREC RECORD drv:2,vid:2,ram:2,n:1,d:1

;----------------------------------------------------------- PROG -----------
.MODEL TINY
.CODE

.8086
JUMPS

ORG 100h
Main            PROC
                mov si,DTA
                cmp BYTE PTR [si],0
                jz chkVer
                mov dx,OFFSET infMsg
                mov ah,9
                int 21h
                ret
chkVer:
                mov ax,3000h
                int 21h
                cmp al,3
                jae sVer
                mov dx,OFFSET verMsg
                mov ah,9
                int 21h
                ret
sVer:
                mov ver,ax
                mov oem,bh

                int 11h
                mov eqList,al
                and al,MASK vid
                mov cl,vid
                shr al,cl
                cmp al,10b
                je begin
                mov dx,OFFSET vidMsg
                mov ah,9
                int 21h
                ret
begin:
                mov ax,3
                int 10h
                ;Get cursor pos.
                mov ah,3
                mov bh,0
                int 10h
                mov cPos,dx
                ;OFFSET = (DH*80+DL)*2
                mov dx,cPos
                xor ax,ax
                mov al,dh
                shl ax,4      ;.
                mov bx,ax     ; .
                shl ax,2      ;  .  mul 80d
                add ax,bx     ;.
                xor dh,dh
                add ax,dx
                shl ax,1
                mov lPos,ax

                add ax,(80+46)*2
                mov iPos,ax

                cld
                call GetDOSversion
                call GetCPU
                call GetFPU
                call GetFloppy
                call GetHDDFreeSpace
                call GetBaseMemory
                call GetExtMemory
                call GetShell
                call GetCodePage

                mov ax,0b800h
                mov es,ax

                mov di,lPos
                mov si,oColor
                call LogoColors

                mov di,lPos
                mov si,oLogo
                call PrintBlock

                mov di,iPos
                mov si,OFFSET form
                call PrintBlock

                call DisplayPalette

                mov di,iPos
                call AccentColor

                mov di,iPos
                call TextColor

                mov dx,cPos
                add dh,14
                mov bh,0
                mov ah,2
                int 10h
                ret
Main            ENDP

DisplayPalette  PROC
                LOCALS
                mov cx,8
                push di
                mov ax,0dbh   ;color: black, char: full block
        @@dpf8:
                stosw
                stosw
                stosw
                inc ah        ;next color
                loop @@dpf8

                mov cx,8
                pop di
                add di,160
        @@dps8:
                stosw
                stosw
                stosw
                inc ah
                loop @@dps8
                ret
DisplayPalette  ENDP

FillWithSpaces  PROC
                LOCALS
                mov al,SPACE
         @@psp:
                cmp BYTE PTR [di],NUL
                je @@eop
                stosb
                jmp @@psp
         @@eop:
                ret
FillWithSpaces  ENDP

CopyStr         PROC
                LOCALS
                push ax
         @@cps:
                lodsb
                or al,al
                jz @@eop
                stosb
                jmp @@cps
         @@eop:
                pop ax
                ret
CopyStr         ENDP

PrintLine       PROC
                LOCALS
                push ax
         @@cps:
                lodsb
                or al,al
                jz @@eop
                stosb
                inc di
                jmp @@cps
         @@eop:
                pop ax
                ret
PrintLine       ENDP

PrintBlock      PROC
                LOCALS
                push di
         @@prb:
                call PrintLine
                cmp BYTE PTR [si],TRM
                je @@eop
                pop di
                add di,160
                push di
                jmp @@prb
         @@eop:
                pop di
                ret
PrintBlock      ENDP

Long2dec        PROC
                LOCALS
                push bx
                push cx
                push di
                add di,9
                push di
          @@do:
                mov cx,ax
                mov ax,dx
                xor dx,dx
                push bx
                mov bx,10
                div bx
                pop bx
                mov bx,ax
                mov ax,cx
                push bx
                mov bx,10
                div bx
                pop bx
                or dl,30h
                mov [di],dl
                mov dx,bx
                dec di
                or dx,dx
                jne @@do
                or ax,ax
                jne @@do
                pop ax
                sub ax,di
                pop di
                pop cx
                pop bx
                ret
Long2dec        ENDP

AccentColor     PROC
                LOCALS
                mov cx,10
                push di
          @@pc:
                cmp BYTE PTR es:[di-2],':'
                je @@eol
                and BYTE PTR es:[di+1],0f0h
                or BYTE PTR es:[di+1],HEADC
                inc di
                inc di
                jmp @@pc
         @@eol:
                pop di
                add di,160
                push di
                loop @@pc
                pop di
                ret
AccentColor     ENDP

LogoColors      PROC
                LOCALS
                mov cx,14
       @@xLine:
                push di
                push cx
       @@cLine:
                lodsw
                cmp ax,TRM
                je @@nLine
                mov cl,al
       @@cChar:
                and BYTE PTR es:[di+1],0f0h
                or BYTE PTR es:[di+1],ah
                inc di
                inc di
                loop @@cChar
                jmp @@cLine
       @@nline:
                pop cx
                pop di
                add di,160
                loop @@xLine
                ret
LogoColors      ENDP

TextColor       PROC
                LOCALS
                mov cx,10
       @@xLine:
                push di
                push cx
                mov cx,34*2
                mov al,':'
                repne scasb
                shr cx,1     ;(!)
       @@cLine:
                inc di        ;next char.
                inc di
                and BYTE PTR es:[di],0f0h
                or BYTE PTR es:[di],TEXTC
                loop @@cLine
                pop cx
                pop di
                add di,160
                loop @@xLine
                ret
TextColor       ENDP

                INCLUDE cpu.asm
                INCLUDE gcp.asm
                INCLUDE gdv.asm
                INCLUDE gem.asm
                INCLUDE gff.asm
                INCLUDE ghs.asm
                INCLUDE gsh.asm

                INCLUDE form.inc

vidMsg   DB 'DOSFETCH needs 80-column color video adaptor.',CR,LF,EOS
verMsg   DB 'DOSFETCH requires DOS version 3.0 or later.',CR,LF,EOS
infMsg   DB "DOSFETCH v1.0 ** marikaz **",CR,LF
         DB 'Determining the correct OEM name and version of the system is very complicated,',CR,LF
         DB "so the information provided in the 'DOS' field may be incorrect.",CR,LF,EOS

eqList   EQREC <?,?,?,?,?>
oem      DB ?
ver      DW ?
oLogo    DW ?
oColor   DW ?
cPos     DW ?
lPos     DW ?
iPos     DW ?

                END Main
