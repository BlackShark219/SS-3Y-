TITLE <Main Lab1>
.386
.model flat, stdcall
option casemap: none
include c:/masm32/include/kernel32.inc
includelib c:/masm32/lib/kernel32.lib
include c:/masm32/include/windows.inc
include c:/masm32/include/user32.inc
includelib c:/masm32/lib/user32.lib
include D:\3year\2semester\SS\Lab4\lab4(1)\h.inc
includelib D:\3year\2semester\SS\Lab4\lab4(1)\MsgBox.lib
includelib D:\3year\2semester\SS\Lab4\lab4(1)\ACTS.lib
.data
 X1 dd 230 ,140 ,5312 ,321 ,3213 ,315 ,5353 ,854
 LENX1 EQU $ -X1; визначення довжини Х1 (в байтах)
 Y1 db LENX1 DUP(0FFh);занесення одиниць до пам'ятті-приймача
 Y2 dd 8 DUP(0AAAAAAAAh);занесення одиниць до пам'ятті-приймача
 number dd  0
 index dd  0
 
.code
start:
 xor ecx, ecx;обнулення регістру ecx
 xor ebx, ebx;обнулення регістру ebx
 mov cl, LENX1;завантаження кількості чисел в регистр-лічильник
 mov esi,0;обнулення регістру esi
 mov eax,0;обнулення регістру eax
 DOLOOP:
 invoke ACT1,X1[esi];виклик процедури ACT1
 mov Y1[si],bl
 inc si;інкрементація лічильника
 loop DOLOOP;зменшення (-1) лічильника і повторення при ECX/=0
 xor ecx, ecx;обнулення регістру ecx
 xor esi, esi;обнулення регістру esi
 xor eax, eax;обнулення регістру eax
 DOLOOP2: 
 cmp si, 32;порівняння лічильника si 
 JE EXIT;умовний перехід
 invoke ACT2, X1[esi],Y1[si];виклик процедури ACT2 з передачею аргументів
 mov Y2[si],eax;завантаження в масив У2 числа (32 біт) з регістру
 inc si;інкрементація лічильника
 loop DOLOOP2;зменшення (-1) лічильника і повторення при ECX/=0
 EXIT:
 mov [Y2+32], 0;заповнення нулями 
 ret
 INVOKE ExitProcess, 0
end start
