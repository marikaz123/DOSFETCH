;GetDOSVersion:PROC * REV. A

GetDOSVersion         PROC
                      LOCALS
                      push dx
                      mov di,OFFSET d_os
                      mov ax,ver
                      mov bh,oem  ;OEM flag
                      cmp bh,0
                      je @@pc_dos
                      cmp bh,0edh
                      je @@dr_dos
                      cmp bh,0eeh
                      je @@dr_dos
                      cmp bh,0efh
                      je @@novell_dos
                      cmp bh,0fdh
                      je @@free_dos
                      cmp bh,0ffh
                      je @@ms_dos
                      jmp @@other_dos
            @@pc_dos:
                      mov dx,OFFSET logoDOS
                      mov oLogo,dx
                      mov dx,OFFSET clp_DOS
                      mov oColor,dx
                      mov si,OFFSET @@_ibm
                      call CopyStr
                      call PrintVersion
                      jmp @@eop
            @@dr_dos:
                      mov dx,OFFSET logoDOS
                      mov oLogo,dx
                      mov dx,OFFSET clp_DOS
                      mov oColor,dx
                      mov si,OFFSET @@_drdos
                      call CopyStr
                      call PrintVersion
                      jmp @@eop
        @@novell_dos:
                      mov dx,OFFSET logoDOS
                      mov oLogo,dx
                      mov dx,OFFSET clp_DOS
                      mov oColor,dx
                      mov si,OFFSET @@_novell
                      call CopyStr
                      call PrintVersion
                      jmp @@eop
          @@free_dos:
                      mov dx,OFFSET logoDOS
                      mov oLogo,dx
                      mov dx,OFFSET clp_DOS
                      mov oColor,dx
                      mov si,OFFSET @@_freedos
                      call CopyStr
                      call PrintVersion
                      jmp @@eop
            @@ms_dos:
                      call @CheckDOSBox
                      jc @@dosbox
                      mov dx,OFFSET logoDOS
                      mov oLogo,dx
                      mov dx,OFFSET clp_DOS
                      mov oColor,dx
                      mov si,OFFSET @@_msdos
                      call CopyStr
                      call PrintVersion
                      jmp @@eop
         @@other_dos:
                      mov dx,OFFSET logoDOS
                      mov oLogo,dx
                      mov dx,OFFSET clp_DOS
                      mov oColor,dx
                      mov si,OFFSET @@_other
                      call CopyStr
                      call PrintVersion
                      jmp @@eop
            @@dosbox:
                      mov dx,OFFSET logoDOS
                      mov oLogo,dx
                      mov dx,OFFSET clp_DOS
                      mov oColor,dx
                      mov si,OFFSET @@_dosbox
                      call CopyStr
                      call PrintVersion
               @@eop:
                      pop dx
                      ret
;OEM
@@_ibm     DB 'IBM PC-DOS ',NUL      ;00
@@_drdos   DB 'DR DOS ',NUL          ;EE
@@_novell  DB 'Novell DOS ',NUL      ;EF
@@_freedos DB 'FreeDOS ',NUL         ;FD
@@_msdos   DB 'MS-DOS ',NUL          ;FF
@@_dosbox  DB 'DOSBox or clone ',NUL
@@_other   DB 'MS-DOS clone ',NUL

GetDOSVersion         ENDP

PrintVersion          PROC
                      LOCALS
                      or ax,ax
                      jz @@na
                      mov di,OFFSET d_ver
                      push bx
                      push ax ;al=major, ah=minor
                      xor ah,ah
                      cmp al,9
                      ja @@2ma
                      add al,'0'
                      stosb
                      jmp @@min
               @@2ma:
                      mov bx,10
                      div bl
                      add al,'0'
                      stosb
                      xchg ah,al
                      add al,'0'
                      stosb
               @@min:
                      mov al,'.'
                      stosb
                      pop ax
                      xchg ah,al
                      xor ah,ah
                      cmp al,9
                      ja @@2mi
                      add al,'0'
                      stosb
                      jmp @@eop
               @@2mi:
                      mov bx,10
                      div bl
                      add al,'0'
                      stosb
                      xchg ah,al
                      add al,'0'
                      stosb
               @@eop:
                      pop bx
                      ret
                @@na:
                      mov si,OFFSET s_na
                      call CopyStr
                      ret
PrintVersion          ENDP

@CheckDOSBox          PROC
                      LOCALS
                      push ax
                      mov ah,4eh
                      mov dx,OFFSET @@fdbox
                      mov cx,0
                      int 21h
                      jc @@nbox
                      cmp WORD PTR cs:[DTA+1ah],30 ;? dosbox 20, dodbox-x 21
                      ;jne @@nbox
                      ja @@nbox
                      pop ax
                      stc
                      ret
              @@nbox:
                      pop ax
                      clc
                      ret
@@fdbox DB 'Z:\COMMAND.COM',NUL
@CheckDOSBox          ENDP
