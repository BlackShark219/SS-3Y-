Title<Main Lab2>
.686
.model flat, stdcall
option casemap: none
include c:/masm32/include/kernel32.inc
includelib c:/masm32/lib/kernel32.lib
include c:/masm32/include/windows.inc
include c:/masm32/include/user32.inc
includelib c:/masm32/lib/user32.lib
include D:\3year\2semester\SS\Lab4\lab4(2)\h.inc
includelib D:\3year\2semester\SS\Lab4\lab4(2)\MsgB.lib
includelib D:\3year\2semester\SS\Lab4\lab4(2)\ACT.lib
.data
sbAval SWORD 20,-118,10,-40,-122
sbBval SWORD 39,10,-26,0,14
sbCval SWORD 415,19,-27,34,30000
sbEval SWORD 13,-18,14,92,6
sbYval SWORD 5 DUP (0AAAAh)
.code
start:
xor eax, eax ;обнулення регістру eax
xor edx, edx ;обнулення регістру edx
xor esi, esi ;обнулення регістру esi
m1:
INVOKE ACT1,sbAval[esi],sbBval[esi],sbCval[esi],sbEval[esi] ;виклик процедури ACT1 з передачею аргументів
add esi,2
cmp esi,10
jne m1
ret
INVOKE ExitProcess, 0
end start
