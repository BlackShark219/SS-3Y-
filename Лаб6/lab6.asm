TITLE <a/d + e^4 – 2с>
.686P
.model flat,stdcall
option casemap:none

.CONST
 vectLength = 5
 elemWidth = 2
 
.DATA
 VectA real8 123.53, 5.32, 38.24, -23.93, 9.15
 VectD real8 38.41, 0.35, 59.31, 17.23, 94.92
 VectE real8 -4.93, -0.86, 2.39, 5.71, -6.47
 VectC real8 -95.21, 2.41, -76.65, 81.72, -32.76
 Sum real8 vectLength DUP(1.0)
 
.CODE
START:
 mov ecx, vectLength
 finit
 
DoLoop:
 dec ecx
 
 fld VectA[ecx * type real8]	; a/d
 fdiv VectD[ecx * type real8] 
 
 fld VectE[ecx * type real8]	; e^4
 fmul st(0), st(0)
 fmul st(0), st(0)
 
 fld1							; 1.0
 fadd st(0), st(0)				; 2.0
 fchs							; -2.0
 fmul VectC[ecx * type real8]	; -2c
 
 faddp st(1), st(0)				; e^4 - 2c
 faddp st(1), st(0)				; a/d + e^4 - 2c
 
 fstp Sum[ecx * type real8]
 
 inc ecx
 loop DoLoop
 
 ret

END START
