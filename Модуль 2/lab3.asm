.686
.model flat, stdcall
option casemap: none
.data
x1 real8 0.0
x2 real8 123.53
.code
start:
finit   
   fld x1
   fldpi
   fmul
   fchs
   fild x2
   fdiv
   fxam
 ret
 end start