includelib kernel32.lib
include <console.inc>

extern WriteConsoleA: proc
extern GetStdHandle: proc
extern SetConsoleTextAttribute: proc
extern ExitProcess: proc

.data
	msg db "Hola Mundo", 0b
.code
	main proc
		sub rsp, 32
			mov rcx, console
			call GetStdHandle
			mov stdout, rax
		add rsp, 32

		sub rsp, 32
			mov rcx, stdout
			lea rdx, msg
			mov r8, lengthof msg
			lea r9, nBytesWritten
			call WriteConsoleA
		add rsp, 32
		
		mov rcx, programEnd
		call ExitProcess
	main endp
end