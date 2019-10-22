.386
.model flat, stdcall
option casemap: none

include incmod\windows.inc; far vs (add folder incmod)
include incmod\macros.asm; far vs (add folder incmod)
;
include incmod\masm32.inc; far vs (add folder incmod)
include incmod\gdi32.inc; far vs (add folder incmod)
include incmod\user32.inc; far vs (add folder incmod)
include incmod\kernel32.inc; far vs (add folder incmod)
;
includelib masm32.lib; far vs
includelib gdi32.lib; far vs
includelib user32.lib; far vs
includelib kernel32.lib; far vs

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

;include \masm32\include\windows.inc ; far masm32
;include \masm32\macros\macros.asm ; far masm32
;;
;include \masm32\include\masm32.inc ; far masm32
;include \masm32\include\gdi32.inc ; far masm32
;include \masm32\include\user32.inc ; far masm32
;include \masm32\include\kernel32.inc ; far masm32
;;
;includelib \masm32\lib\masm32.lib ; far masm32
;includelib \masm32\lib\gdi32.lib ; far masm32
;includelib \masm32\lib\user32.lib ; far masm32
;includelib \masm32\lib\kernel32.lib ; far masm32

.data

valueTemp_msg db 256 dup(0)
valueTemp_fmt db "%d KB free space", 0

;BOOL GetDiskFreeSpaceA(
  ;LPCSTR  
  lpRootPathName db "E:", 0
.data?
  ;LPDWORD 
  lpSectorsPerCluster dd ?
  ;LPDWORD 
  lpBytesPerSector dd ?
  ;LPDWORD 
  lpNumberOfFreeClusters dd ?
  ;LPDWORD 
  lpTotalNumberOfClusters dd ?
;);

.code
Start:

push offset lpTotalNumberOfClusters
push offset lpNumberOfFreeClusters
push offset lpBytesPerSector
push offset lpSectorsPerCluster
push offset lpRootPathName
call GetDiskFreeSpaceA

mov eax, lpNumberOfFreeClusters
mul lpSectorsPerCluster
mul lpBytesPerSector
mov ebx, 1024
div ebx

push eax
push offset valueTemp_fmt
push offset valueTemp_msg
call wsprintfA 

push 40h
push offset lpRootPathName
push offset valueTemp_msg;
push 0
call MessageBoxA

call ExitProcess
end Start