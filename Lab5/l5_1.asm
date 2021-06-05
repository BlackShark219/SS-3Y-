.686
.model flat, stdcall
option casemap: none
include c:/masm32/include/kernel32.inc
includelib c:/masm32/lib/kernel32.lib
include c:/masm32/include/windows.inc
include c:/masm32/include/user32.inc
includelib c:/masm32/lib/user32.lib

.data
 X1 dd 230 ,140 ,5312 ,321 ,3213 ,315 ,5353 ,854
 LENX1 EQU $ -X1; визначення довжини Х1 (в байтах)
 Y1 db LENX1 DUP(0FFh);занесення одиниць до пам'ятті-приймача
 Y2 dd 8 DUP(0AAAAAAAAh);занесення одиниць до пам'ятті-приймача
 number dd  0
 index dd  0
 
 str_format  DB  "Index = %x , Number = %d", 0
 str_buffer  DB  256 dup (0)

 titlbox db "End of task", 0
 strbox db "Task was completed!", 0
.code
start:
;===================
;Завантаження числа з масиву X1 до масиву Y1
;===================
ACT1 macro
DOLOOP:
 mov eax,[X1+si];завантаження в регістр числа (32 біт) із масиву X1
 mov ah,0;завантаження в регістр 0(8 біт)
 not al;інвертування коду в регістрі (8 біт)
 bsr bx,ax;зворотнє сканування на наявність 1(16 біт)
 mov [Y1+si],bl;завантаження в масив У1 числа (8 біт) з регістру
 inc si;інкрементація лічильника
 loop DOLOOP;зменшення (-1) лічильника і повторення при ECX/=0
 xor ecx, ecx;обнулення регістру ecx
 xor esi, esi;обнулення регістру esi
 xor eax, eax;обнулення регістру eax
 xor edx, edx
 xor ebx, ebx
 endm
;===================
;Завантаження числа з масиву Y1 або X1 до масиву Y2
;===================
 ACT2 macro
 mov cl, LENX1 
DOLOOP2:
 cmp bx, 32;порівняння лічильника si 
 JE EXIT;умовний перехід
 cmp [Y1+bx],6;порівняння елемента масиву 
 JE ADDY2;умовний перехід
 lea esi,[X1+ebx]
 lea edi,[Y2+ebx]
 cld
 movsd 
 mov edx,[X1+ebx];завантаження в регістр числа (32 біт) із масиву X1 
 ;mov [Y2+si],ecx;завантаження в масив У2 числа (32 біт) з регістру
 mov number,edx
 shl number,24;побітовий здвиг вліво на 24 біти
 mov index,ebx
 call WrToMsgBox
 inc bx 
 loop DOLOOP2;зменшення (-1) лічильника і повторення при ECX/=0
ADDY2:
 mov eax,[X1+ebx];завантаження в регістр числа (32 біт) із масиву X1
 not eax;інвертування коду в регістрі (32 біт)
 mov [Y2+ebx],eax;завантаження в масив У2 числа (32 біт) з регістру 
 mov number,eax
 shl number,24;побітовий здвиг вліво на 24 біти
 mov index,ebx
 call WrToMsgBox 
 inc bx
 jmp DOLOOP2;перехід до лейблу
EXIT:
 mov [Y2+32], 0;заповнення нулями 
 ret
endm
 xor ecx, ecx;обнулення регістру ecx
 xor ebx, ebx;обнулення регістру ebx
 mov cl, LENX1;завантаження кількості чисел в регистр-лічильник
 mov esi,0;обнулення регістру esi
 mov eax,0;обнулення регістру eax
 ACT1;виклик процедури ACT1
 ACT2;виклик процедури ACT2
 INVOKE ExitProcess, 0
;===================
;Вивід повідомлення з результатом операції над масивами
;Requires EAX,ECX
;===================
WrToMsgBox PROC 
   push ecx ; зберігаємо ecx в стек
   push eax; зберігаємо eax в стек
   invoke wsprintf, ADDR str_buffer, ADDR str_format,number,index
   invoke MessageBox, 0, addr str_buffer, addr titlbox, MB_OK
   pop eax ; витягуэмо ecx з стеку
   pop ecx;витягуэмо eax з стеку
   ret
WrToMsgBox ENDP
end start