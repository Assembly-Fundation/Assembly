.386 ; Indicate 32-bit mode
.model flat, stdcall ; Indicate flat memory model and stdcall calling convention
.stack 4096 ; Optional indication for the stack space
option casemap:none ; Disable case sensitivity for symbols

; Import System Library kernel32
includelib kernel32.lib

; Declare extern function prototypes
GetStdHandle proto : DWORD ; Retrieves a handle for a standard input or output device (STDIN, STDOUT, STDERR).
WriteConsoleA proto : DWORD, :PTR BYTE, :DWORD, :PTR DWORD, :PTR DWORD ; Writes a block of characters to the console.
ExitProcess proto : DWORD ; Terminates the current process and returns an exit code.

.data
    ; Declare our memory address where our data will be stored
    msg db "Hello, World!", 0 ; The '0' at the end indicates the end of our text string (null-terminated)
    msgLength dd $ - offset msg ; Obtain the length of the message
    hConsoleOutput dd ? ; Reserve 32 bits for later use

.code
main proc ; start function main
    ; Get the handle to the console output
    invoke GetStdHandle, -11 ; -11 represents STD_OUTPUT_HANDLE
    mov hConsoleOutput, eax ; Store the value of eax in hConsoleOutput

    ; Write message to console
    invoke WriteConsoleA, hConsoleOutput, addr msg, msgLength, 0, 0
    ; The function receives the STD_OUTPUT_HANDLE in hConsoleOutput
    ; Receives the message with addr msg
    ; Obtains the length of the message with msgLength
    ; Completes the arguments with 0 and 0

    invoke ExitProcess, 0 ; Indicate that the program finished successfully with exit code 0
main endp ; finish function main

end main ; Finish the program and file
