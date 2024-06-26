.386
.model flat, stdcall
.stack 4096
option casemap:none

; Import System Library kernel32
includelib kernel32.lib


; Declare extern function prototypes
GetStdHandle proto :DWORD
WriteConsoleA proto :DWORD, :PTR BYTE, :DWORD, :PTR DWORD, :PTR DWORD
ExitProcess proto :DWORD

.data
    hConsoleOutput dd ?
    msg db "Hello, World!", 0
    msgLength dd $ - offset msg

.code
main proc
    ; Get the handle to the console output
    invoke GetStdHandle, -11
    mov hConsoleOutput, eax

    ; Write message to console
    invoke WriteConsoleA, hConsoleOutput, addr msg, msgLength, 0, 0

    ; Exit the process
    invoke ExitProcess, 0
    ret
main endp

end main
