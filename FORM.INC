;Part of DOSFETCH

s_p      DB 'Present',NUL
s_nop    DB 'Not found',NUL
s_na     DB 'N/A',NUL

form:
          DB 'DOS: '
d_os      DB 29 DUP (SPACE),NUL
          DB 'Reported ver.: '
d_ver     DB 16 DUP (SPACE),NUL
          DB 'Shell: '
d_shell   DB 26 DUP (SPACE),NUL
          DB 'CPU: '
d_cpu     DB 28 DUP (SPACE),NUL
          DB 'FPU: '
d_fpu     DB 28 DUP (SPACE),NUL
          DB 'Base memory: '
d_basemem DB 20 DUP (SPACE),NUL
          DB 'Ext. memory: '
d_extmem  DB 20 DUP (SPACE),NUL
          DB 'Disk C: '
d_disk    DB 27 DUP (SPACE),NUL
          DB 'Floppy: '
d_floppy  DB 25 DUP (SPACE),NUL
          DB 'Code Page: '
d_cp      DB 22 DUP (SPACE),NUL
          DB NUL,NUL
          DB TRM

clp_DOS: ;default
clp_MS_DOS:
DW TRM
DB 17,RED,11,MAG,16,YEL,TRM,TRM
DB 14,RED,11,MAG,19,YEL,TRM,TRM
DB 12,RED,11,MAG,20,YEL,TRM,TRM
DB 11,RED,8,MAG,5,RED,6,YEL,7,MAG,7,YEL,TRM,TRM
DB 11,RED,6,MAG,7,RED,6,YEL,14,MAG,TRM,TRM
DB 10,RED,7,MAG,7,RED,6,YEL,14,MAG,TRM,TRM
DB 10,RED,7,MAG,9,RED,4,YEL,7,MAG,7,YEL,TRM,TRM
DB 10,RED,6,MAG,14,RED,7,MAG,7,YEL,TRM,TRM
DB 11,RED,5,MAG,14,RED,8,MAG,6,YEL,TRM,TRM
DB 11,RED,4,MAG,8,RED,7,YEL,9,MAG,5,YEL,TRM,TRM
DB 21,RED,3,MAG,20,YEL,TRM,TRM
DB 19,RED,6,MAG,19,YEL,TRM,TRM
DB 18,RED,11,MAG,15,YEL,TRM,TRM

logoDOS: ;default
logoMS_DOS:
DB NUL
DB ' =+++**##%%#+:   =%@@@@@@@+ -%@@@@@@@+       ',NUL
DB ' @@@@@@@@@@@@.+@@@@@@@@@+=@@@@@@@@@@@@@@#    ',NUL
DB ' @@@@@@@@@@#-@@@@@@%-   *@@@@@+    -@@@@@@-  ',NUL
DB ' @@@@%     .@@@@@+ #%   @@@@* @@@@%  .@@@@%  ',NUL
DB ' @@@@@     @@@@@+=@@@%  @@@@@.#@@@@*         ',NUL
DB ' @@@@@    =@@@@@ @@@@@: :@@@@#=@@@@@         ',NUL
DB ' @@@@@    +@@@@# @@@@@-   -#@#.@@@@@ %@@#-   ',NUL
DB ' @@@@@    =@@@@=:@@@@@:       :@@@@@ @@@@@@. ',NUL
DB ' @@@@@     @@@@.%@@@@%        #@@@@+  #@@@@% ',NUL
DB ' @@@@@     .@#.#@@@@@  #@@@@* %@@@%    @@@@@ ',NUL
DB ' @@@@@@@%%%%%@@@@@@# += %@@@@@#:    :#@@@@@- ',NUL
DB ' @@@@@@@@@@@@@@@@* -@@@@==@@@@@@@@@@@@@@@%   ',NUL
DB ' -=++*##%@@%*:    *@@@@@@@#  +@@@@@@@%-      ',NUL
DB TRM

COMMENT #

logoDOSBox:
DB NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB '                  DOSBox'NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL

logoFreeDOS:
DB NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB '                   FreeDOS',NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL

logoDR_DOS:
DB NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB '                   DR-DOS',NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL

logoIBM_DOS:
DB NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB '                   IBM DOS',NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL
DB 44 DUP (?),NUL

#