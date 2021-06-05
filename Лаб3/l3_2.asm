TITLE <32*c – (b^2)*e + 4*a/b>
.686
.model flat, stdcall
option casemap: none
include c:/masm32/include/kernel32.inc
includelib c:/masm32/lib/kernel32.lib
include c:/masm32/include/windows.inc
include c:/masm32/include/user32.inc
includelib c:/masm32/lib/user32.lib
.data
 titlbox db "End of task", 0
 strbox db "Task was completed!", 0
 result dw  0
 str_format  DB  "result = %x", 0
 str_buffer  DB  256 dup (0)
MsgTitle db "Overflow warning",0
MsgText db "Overflow happend",0
MsgBoxCaption db "Error handling",0
MsgBoxText db "Dividing by zero, change b",0
sbAval SWORD 20,-118,10,-40,-122
sbBval SWORD 39,10,-26,0,14
sbCval SWORD 30002,19,-27,34,30000
sbEval SWORD 13,-18,14,92,6
sbYval SWORD 5 DUP (0AAAAh)
.code
;===================
;Підрахунок проміжних рез-тів виразу та кінцевого рез-ту
;===================
ACT1 proc 
m1:
cmp [sbBval+esi],0;check if b==0
JE  DBZ;if b==0
xor eax,eax;обнулення регістру eax
xor ebx,ebx;обнулення регістру ebx
mov ax, 32
imul [sbCval+esi];32*c 1)896
JO OF;overflow check
mov result,ax
mov bx,ax
call WrToMsgBox
mov [sbYval+esi], bx;fill sbYval n-th with 32*c
mov ax, [sbBval+esi];fill ax with sbBval n-ths
imul [sbBval+esi];b^2 1)1 521
JO OF;overflow check
xor ebx,ebx
mov bx,ax
mov result,bx
call WrToMsgBox
mov ax,bx
imul [sbEval+esi];b^2*e
JO OF;overflow check
xor ebx,ebx
mov bx,ax
mov result,bx
call WrToMsgBox
mov ax,bx
sub [sbYval+esi],ax;32*c-(b^2)*e
JO OF;overflow check
mov bx,[sbYval+esi]
mov result,bx
call WrToMsgBox
mov ax, 4
imul [sbAval+esi];4*a
JO OF;overflow check
xor ebx,ebx
mov bx,ax
mov result,bx
call WrToMsgBox
mov ax,bx
cwd
idiv [sbBval+esi];4*a/b
xor ebx,ebx
mov bx,ax
mov result,ax
call WrToMsgBox
mov ax,bx
add [sbYval+esi],ax;32*c-(b^2)*e+4*a/b
JO OF;overflow check
mov bx,[sbYval+esi]
mov result,bx
call WrToMsgBox
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
ACT1 ENDP
;===================
;Вивід повідомлення з результатом операції
;Requires ECX
;===================
WrToMsgBox PROC uses ecx
	xor ecx,ecx
	mov cx,result
   invoke wsprintf, ADDR str_buffer, ADDR str_format,ecx
   invoke MessageBox, 0, addr str_buffer, addr titlbox, MB_OK
   ret
WrToMsgBox ENDP
start:
prlab2:
xor eax, eax
xor edx, edx
xor esi, esi
call ACT1
INVOKE ExitProcess, 0
end prlab2