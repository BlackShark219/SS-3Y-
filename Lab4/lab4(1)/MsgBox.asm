TITLE <MsgBox dll>
.386
.model flat, stdcall
option casemap: none
include C:\masm32\include\kernel32.inc
includelib C:\masm32\lib\kernel32.lib
include C:\masm32\include\windows.inc
include C:\masm32\include\user32.inc
includelib C:\masm32\lib\user32.lib

WrToMsgBox PROTO,
:DWORD, :DWORD
.data
str_format  DB  "Number = %x , Index = %d", 0
str_buffer  DB  256 dup (0)

titlbox db "End of task", 0
strbox db "Task was completed!", 0

.code
;===================
;Формування MessageBox
;Input: number:DWORD, index:DWORD
;===================
WrToMsgBox PROC,
   number:DWORD, index:DWORD
   push ecx ; зберігаємо ecx в стек
   push eax; зберігаємо eax в стек
   invoke wsprintf, ADDR str_buffer, ADDR str_format,number,index
   invoke MessageBox, 0, addr str_buffer, addr titlbox, MB_OK
   pop eax ; витягуэмо ecx з стеку
   pop ecx;витягуэмо eax з стеку
   ret
WrToMsgBox ENDP

END
