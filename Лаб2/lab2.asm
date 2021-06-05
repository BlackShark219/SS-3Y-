TITLE <32*c – (b^2)*e + 4*a/b>
.686
.model flat, stdcall
option casemap: none
include C:\masm32\include\windows.inc
include C:\masm32\include\user32.inc
includelib C:\masm32\lib\user32.lib
.data
MsgTitle db "Overflow warning",0
MsgText db "Overflow happend",0
MsgBoxCaption db "Error handling",0
MsgBoxText db "Dividing by zero, change b",0
sbAval SWORD 44,-118,10,-40,-122
sbBval SWORD 39,10,-26,0,14
sbCval SWORD 28,19,-27,34,30000
sbEval SWORD 13,-18,14,92,6
sbYval SWORD 5 DUP (0AAAAh)
.code
start:
prlab2:
xor eax, eax
xor edx, edx
xor esi, esi
m1:
cmp [sbBval+esi],0;check if b==0
JE  DBZ;if b==0
mov ax, 32
imul [sbCval+esi];32*c
JO OF;overflow check
mov [sbYval+esi], ax;fill sbYval n-th with 32*c
mov ax, [sbBval+esi];fill ax with sbBval n-th
imul [sbBval+esi];b^2
JO OF;overflow check
imul [sbEval+esi];b^2*e
JO OF;overflow check
sub [sbYval+esi],ax;32*c-(b^2)*e
JO OF;overflow check
mov ax, 4
imul [sbAval+esi];4*a
JO OF;overflow check
cwd
idiv [sbBval+esi];4*a/b
add [sbYval+esi],ax;32*c-(b^2)*e+4*a/b
JO OF;overflow check
CONT:
add esi,2
cmp esi,10
jne m1
ret
DBZ:;divide by zero exception
invoke MessageBox, NULL, addr MsgBoxText, addr MsgBoxCaption, MB_OK
jmp CONT
OF:;overflow exception
invoke MessageBox, NULL, addr MsgText, addr MsgTitle, MB_OK
jmp CONT
end prlab2