.386
.model flat, stdcall
.stack 4096
option casemap:none

; Import System Library kernel32
includelib kernel32.lib


; Declare extern function prototypes

GetStdHandle proto :DWORD ; Retrieves a handle for a standard input or output device (STDIN, STDOUT, STDERR).
                          ; For example, you can get the output console handle to use with WriteConsoleA.


WriteConsoleA proto :DWORD, :PTR BYTE, :DWORD, :PTR DWORD, :PTR DWORD ; This function writes a block of characters to the console,
                                                                      ; i.e., the text output.
                                                                      ; It is used to display text to the user.
ExitProcess proto :DWORD ; Terminates the current process and returns an exit code.
                         ; It hands control back to the operating system.

.data
    ; Declare our memory address where our data will be stored
    ; The following structure is used for declaration:
    ; Identifier + size of reservation + what will be stored
    msg db "Hello, World!", 0 ; The '0' at the end indicates the end of our text string (null-terminated)

    msgLength dd $ - offset msg ; Obtain bytes space long the msg
     hConsoleOutput dd ? ; Reserve 32 bits for later use

.code
main proc
    ; Get the handle to the console output
    invoke GetStdHandle, -11 ; -11 represents the first argument for GetStdHandle (STD_OUTPUT_HANDLE)
                             ; The result of the function is stored in eax
    mov hConsoleOutput, eax ; Store the value of eax in hConsoleOutput

    ; Write message to console
    invoke WriteConsoleA, hConsoleOutput, addr msg, msgLength, 0, 0
    ; The function recive the STD_OUTPUT_HANDLE of "hConsoleOutput"
    ; Recive the message with "addr msg"
    ; obtein the length of the message with "msgLength"
    ; Complete the arguments with 0 and 0

    invoke ExitProcess, 0 ; The fist argument of "ExitProcess" indicate that the program finished successfully with exit code 0 
                          ; Tell the system that we are done and hand back control
main endp

end main
