;-------------------------------------------------------------------------------------------------------------------------------------------------------
data	segment							; data segment. Keyword db means define byte. You can also define word (dw)
msg1 db 'Enter a 16-bit binary number: $'
msg2 db 0dh,0ah,'The decimal signed integer equivalent is $'
msg3 db 0dh,0ah,'Error! Please enter exactly 16-bits: $'
msg4 db 0dh,0ah,'Error! Illegal characters detected. Please enter a 16-bit binary number: $'
data	ends

										; stack segment
stack1  segment	stack 		
		db	100 dup(?)      			; This is the stack of 100 bytes
stack1  ends


code    segment
        assume  cs:code, ds:data, ss:stack1

start: 
										;Perform initialization 
		mov ax, data					;Put the starting address of the data segment into the ax register (must do this first)
		mov ds, ax						;Put the starting address of the data segment into the ds register (where it belongs)
mov ax, stack1					;Put the starting address of the stack into the ax register (must do this first)
		mov ss, ax
-------------------------------------------------------------------		
mov ah, 09h
lea dx, offset msg1
int 21h
    
mov bl,0

mov cl, 16
loop1:
mov ah, 01h
int 21h
sub al, 48
shl bl, 1
add bl, al
loop loop1

mov ah, 09h
mov dx, offset msg2
int 21h

mov ah, 02h
mov dl, bl
int 21h
;-------------------------------------------------------------------------------------------------------------------------------------------------------										
        mov ah, 4ch					;Set up code to specify return to dos
        int 21h							;Interpt number 21 (Return control to dos prompt)

code    ends

end     start
;-------------------------------------------------------------------------------------------------------------------------------------------------------



