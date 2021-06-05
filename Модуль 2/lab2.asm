.686
.model flat, stdcall
option casemap: none
;--------------
fld4 MACRO fpval
 LOCAL name
 .data
   name real4 fpval
   align 4
 .code
   fld name
ENDM
;--------------
abg MACRO a, b, g
  fld a
  fld b
  fadd
  fld4 7.0
  fdiv
  frndint
  fst g
ENDM
;--------------
chctrlword MACRO corrctrlWord
  fstcw ctrlWord
  and ctrlWord, 0F0FFh
  or ctrlWord, corrctrlWord
  fldcw ctrlWord
ENDM
;--------------
.data
alpha dword -24.хххх
beta dword хххх
gamma0 real4 ?
gamma1 real4 ?
gamma2 real4 ?
gamma3 real4 ?
ctrlWord word ?
;--------------
.code
start:
  finit   
;--------------
  chctrlword 0000h
  abg alpha, beta, gamma0 
;--------------
  chctrlword ххххh
  abg alpha, beta, gamma1 
;--------------
  chctrlword ххххh
  abg alpha, beta, gamma2 
;--------------
  chctrlword ххххh
  abg alpha, beta, gamma3 
;--------------
 ret
 end start