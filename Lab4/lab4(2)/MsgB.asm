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
:DWORD
.data
 titlbox db "End of task", 0
 strbox db "Task was completed!", 0
 str_format  DB  "result = %x", 0
 str_buffer  DB  256 dup (0)
.code
;===================
;Формування MessageBox з результатом операції
;Input: result:DWORD
;===================
   WrToMsgBox PROC uses eax ebx,
   result:DWORD
   invoke wsprintf, ADDR str_buffer, ADDR str_format, result
   invoke MessageBox, 0, addr str_buffer, addr titlbox, MB_OK
   ret
   WrToMsgBox ENDP
END
