TITLE <ACT dll>
.386
.model flat, stdcall
option casemap: none
include C:\masm32\include\kernel32.inc
includelib C:\masm32\lib\kernel32.lib
include C:\masm32\include\windows.inc
include C:\masm32\include\user32.inc
includelib C:\masm32\lib\user32.lib
include D:\3year\2semester\SS\Lab4\lab4(2)\h.inc
includelib D:\3year\2semester\SS\Lab4\lab4(2)\MsgB.lib
ACT1 PROTO,
:WORD,:WORD,:WORD,:WORD
.data
result dd  0
MsgTitle db "Overflow warning",0
MsgText db "Overflow happend",0
MsgBoxCaption db "Error handling",0
MsgBoxText db "Dividing by zero, change b",0
.code
;===================
;Підрахунок виразу
;Input: sbAval:WORD,sbBval:WORD,sbCval:WORD,sbEval:WORD
;===================
ACT1 proc,
sbAval:WORD,sbBval:WORD,sbCval:WORD,sbEval:WORD
cmp sbBval,0;check if b==0
JE  DBZ;if b==0
xor eax,eax;обнулення регістру eax
xor ebx,ebx;обнулення регістру ebx
xor ecx,ecx;обнулення регістру ecx
mov ax, 32
imul sbCval;32*c
JO OF;overflow check
mov result,eax
mov bx,ax
invoke WrToMsgBox,result
mov ax, sbBval;fill ax with sbBval n-ths
imul sbBval;b^2
JO OF;overflow check
mov result,eax
invoke WrToMsgBox,result
imul sbEval;b^2*e
JO OF;overflow check
mov result,eax
invoke WrToMsgBox,result
sub bx,ax;32*c-(b^2)*e
JO OF;overflow check
mov result,ebx
invoke WrToMsgBox,result
mov ax, 4
imul sbAval;4*a
JO OF;overflow check
mov result,eax
invoke WrToMsgBox,result
cwd
idiv sbBval;4*a/b
mov result,eax
invoke WrToMsgBox,result
add bx,ax;32*c-(b^2)*e+4*a/b
JO OF;overflow check
mov result,ebx
invoke WrToMsgBox,result
ret
DBZ:;divide by zero exception
invoke MessageBox, NULL, addr MsgBoxText, addr MsgBoxCaption, MB_OK
ret
OF:;overflow exception
invoke MessageBox, NULL, addr MsgText, addr MsgTitle, MB_OK
ret
ACT1 endp
END