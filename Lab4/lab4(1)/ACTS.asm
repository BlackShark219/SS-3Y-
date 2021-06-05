TITLE <ACTS dll>
.386
.model flat, stdcall
option casemap: none
include C:\masm32\include\kernel32.inc
includelib C:\masm32\lib\kernel32.lib
include C:\masm32\include\windows.inc
include C:\masm32\include\user32.inc
includelib C:\masm32\lib\user32.lib
include D:\3year\2semester\SS\Lab4\lab4(1)\h.inc
includelib D:\3year\2semester\SS\Lab4\lab4(1)\MsgBox.lib
ACT1 PROTO,
:DWORD
ACT2 PROTO,
:DWORD,:BYTE
.data
 number dd  0
 index dd  0
.code
;===================
;Формування вектору Y1
;Input: X1:DWORD
;Returns: BX 
;===================
ACT1 PROC,
 X1:DWORD
 mov eax,X1;завантаження в регістр числа (32 біт) із масиву X1
 mov ah,0;завантаження в регістр 0(8 біт)
 not al;інвертування коду в регістрі (8 біт)
 bsr bx,ax;зворотнє сканування на наявність 1(16 біт)
 ret
ACT1 ENDP
;===================
;Формування вектору Y2
;Input: X1:DWORD,Y1:BYTE
;Returns:EAX
;===================
 ACT2 proc,
 X1:DWORD,Y1:BYTE
 cmp Y1,6;порівняння елемента масиву 
 JE ADDY2;умовний перехід
 mov eax,X1;завантаження в регістр числа (32 біт) із масиву X1 
 mov number,eax
 shl number,24;побітовий здвиг вліво на 24 біти
 mov index,esi
 invoke WrToMsgBox, number, index
 ret
ADDY2:
 mov eax,X1;завантаження в регістр числа (32 біт) із масиву X1
 not eax;інвертування коду в регістрі (32 біт)
 mov number,eax
 shl number,24;побітовий здвиг вліво на 24 біти
 mov index,esi
 invoke WrToMsgBox, number, index
 ret
ACT2 endp

END
