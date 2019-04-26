INCLUDE Irvine32.inc
WriteString PROTO

;Assembly Language

.data
	;target BYTE "0123ABAAABAAAABA789", 0				; "ABCDEFGHIJKLMNOPQRSTUVXYZ"
	;source BYTE "AABA", 0

	msg1 BYTE 10, "It is equal" , 0
	msg2 BYTE 10, "Not found", 0

	msgSource BYTE "Enter source string (the string to search for): ", 0
	msgTarget BYTE "Enter target string (the string to search from): ", 0
	msgResult1 BYTE "Source string found at position ", 0
	msgResult2 BYTE " in Target string (counting from zero).", 0

	counter DWORD ?
	counter2 DWORD ?
	sourceL DWORD ?

	strTarget BYTE 31 DUP (?)
	strSource BYTE 31 DUP (?)

	str1 BYTE ?


.code
main PROC
	mov edx, OFFSET msgSource
	call WriteString

	mov ecx, 30

	mov edx, OFFSET strSource
	call ReadString


	mov edx, OFFSET msgTarget
	call WriteString

	mov ecx, 30

	mov edx, OFFSET strTarget
	call ReadString
	






	mov edx, 0
	mov ebx, 0
	mov esi, 0
	mov eax, LENGTHOF strTarget
	mov ecx, LENGTHOF strSource
	sub eax, ecx
	inc eax
	inc eax
	mov counter2, eax

	mov ecx, LENGTHOF strSource
	dec ecx
	dec ecx
	mov sourceL, ecx
	mov counter, ecx

	L2:
	mov esi, counter
	sub esi, sourceL
	cmp esi, counter2
	je L3

	mov ecx, LENGTHOF strSource
	dec ecx
	mov edi, 0

	L1:
		mov al, strTarget[esi]
		mov str1[edi], al
		inc esi
		inc edi

	loop L1
	
	mov counter, esi


	mov eax, 0
	mov esi, OFFSET str1
	mov edi, OFFSET strSource

	call CompareStr

	
	jne L2

	mov edx, OFFSET msgResult1
	call WriteString

	mov esi, counter
	sub esi, sourceL
	dec esi
	mov eax, esi
	call WriteDec

	mov edx, OFFSET msgResult2
	call WriteString

	invoke ExitProcess,0

	L3:
	mov edx, OFFSET msg2
	call WriteString

	invoke ExitProcess,0
main endp


CompareStr PROC
	
	L1:

	mov al, [esi]
	mov dl, [edi]

	cmp al, 0
	jne L2

	cmp dl, 0
	jne L2

	jmp L3

	L2:

	inc esi
	inc edi
	cmp al, dl
	je L1

	L3:

	ret
	
CompareStr endp

end main
