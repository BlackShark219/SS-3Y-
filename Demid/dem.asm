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
X1 dd 9, 3, 4, 5, 1, 8, 3, 2, 4, 1
.code
;===================
;Підрахунок проміжних рез-тів виразу та кінцевого рез-ту
;===================
ACT1 proc 
m1:
 xor eax, eax
 xor ebx, ebx
 xor ecx, ecx
 xor edx, edx
 xor esi, esi
 xor edi, edi 
 xor esp, esp
 xor ebp, ebp ;чистка регістрів
 
 mov esi, 36 ;для виокремлення елементу вектору
 mov bl, 1 ;значення, що вказує на біт
 mov cx, 10 ;стільки раз буде виконаний цикл
 mov al, 2 ;значення, потрібне для множення
 PIDOR:
 mov esp, [ X1 + esi] ;до регистру esp додаємо значення елементу вектору
 mov edi, esp ;значення до зсуву біту (біт зсуваємо для того, щоб знайти біт 1"
 mov ebp, ecx ;у ebp кладемо ecx, щоб зберегти значення кількості ітерацій циклу
 mov cl, bl ;у сl кладемо значення поточної ітерації циклу
 shr esp, cl ;зсуваємо біт
 mul esp ;помножуємо esp на 2 щоб перевірити, закінчюється на 1 чи на 0
 cmp edi, eax ;порівнюємо помножене esp із його значення до зсуву біту
jne m1
ret
DBZ:;divide by zero exception
invoke MessageBox, NULL, addr MsgBoxText, addr MsgBoxCaption, MB_OK
OF:;overflow exception
invoke MessageBox, NULL, addr MsgText, addr MsgTitle, MB_OK
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