	SECTION .data
i dd 0

	SECTION .text
global maior_nasm
maior_nasm:
	push ebp 
	mov ebp, esp

	mov esp, ebp
	pop ebp
	ret		