.586
.model flat, stdcall
option casemap: none

;include incmod\windows.inc; far vs (add folder incmod)
;include incmod\macros.asm; far vs (add folder incmod)
;;
;include incmod\masm32.inc; far vs (add folder incmod)
;include incmod\gdi32.inc; far vs (add folder incmod)
;include incmod\user32.inc; far vs (add folder incmod)
;include incmod\kernel32.inc; far vs (add folder incmod)
;;
;includelib masm32.lib; far vs
;includelib gdi32.lib; far vs
;includelib user32.lib; far vs
;includelib kernel32.lib; far vs

;include masm32\include\windows.inc ; far masm32p
;include masm32\macros\macros.asm ; far masm32p
;;
;include masm32\include\masm32.inc ; far masm32p
;include masm32\include\gdi32.inc ; far masm32p
;include masm32\include\user32.inc ; far masm32p
;include masm32\include\kernel32.inc ; far masm32p
;;
;includelib masm32\lib\masm32.lib ; far masm32p
;includelib masm32\lib\gdi32.lib ; far masm32p
;includelib masm32\lib\user32.lib ; far masm32p
;includelib masm32\lib\kernel32.lib ; far masm32p

include \masm32\include\windows.inc ; far masm32
include \masm32\macros\macros.asm ; far masm32
;
include \masm32\include\masm32.inc ; far masm32
include \masm32\include\gdi32.inc ; far masm32
include \masm32\include\user32.inc ; far masm32
include \masm32\include\kernel32.inc ; far masm32
;
includelib \masm32\lib\masm32.lib ; far masm32
includelib \masm32\lib\gdi32.lib ; far masm32
includelib \masm32\lib\user32.lib ; far masm32
includelib \masm32\lib\kernel32.lib ; far masm32

.data
fileName db "12345.txt", NULL
filesizevalue dd 123
filesize_fmt db "file size =  %d", NULL
buflen dd 256
hello_title db 'Lab5', 0
hello_message db 'ComputerName: %s', 0
user_name db 256 dup (0)
hello_message_user_name db 256 dup (0)
filesize_message db 256 dup (0)

.DATA?
hFile HANDLE ?

.code
Start:
push offset buflen
push offset user_name
call GetComputerNameA

push offset user_name
push offset hello_message
push offset hello_message_user_name
call wsprintfA 

push 40h
push offset hello_title
push offset hello_message_user_name;
push 0
call MessageBoxA

;;;;;;;;;;;;;;;;;;; FileSize ;;;;;;;;;;;;;;;;;;;
push NULL                                ;; handle to template file
push 0                                   ;; file attributes
push OPEN_EXISTING                       ;; how to create
push NULL                                ;; SD
push 0                                   ;; share mode
push GENERIC_READ                        ;; access mode
push offset fileName                     ;; file name
call CreateFileA

mov hFile, eax

push NULL
push hFile
call GetFileSize

mov filesizevalue, eax

push hFile
call CloseHandle

push filesizevalue
push offset filesize_fmt
push offset filesize_message
call wsprintfA 

push 40h
push offset hello_title
push offset filesize_message;
push 0
call MessageBoxA
push 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

call ExitProcess
end Start