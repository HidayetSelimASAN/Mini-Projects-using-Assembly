ORG 0

	acall	CONFIGURE_LCD



	MOV DPTR, #MY_STRING
AGAIN:  CLR A			;Print INPUT=
	MOVC A, @A+DPTR
	INC DPTR
	JZ KEYBOARD_LOOP
	ACALL SEND_DATA
	SJMP AGAIN

	
KEYBOARD_LOOP:
	acall KEYBOARD
	;now, A has the key pressed
	
	CJNE A, #'A', DATA_COMING	; Data end solution
	SJMP NEXT
	
DATA_COMING:
	INC R3				; Digit counter
	PUSH A
	acall SEND_DATA	
	SJMP KEYBOARD_LOOP
	
	
NEXT:	
	MOV A,R3
	DEC A
	JZ J1				; IF user enters 1 digit (j1)
	DEC A
	JZ J2				; IF user enters 2 digit (j2)
	DEC A
	JZ NEXT2			; IF user enters 3 digit (j3)

J1:  	POP 40h
	MOV 41H, #00H
	PUSH 41H
	PUSH 41H
	PUSH 40H			; Least sig digit pushed lastly
	SJMP NEXT2
J2: 	POP 40H
	POP 41H
	MOV 42H, #00H
	PUSH 42H
	PUSH 41H
	PUSH 40H



NEXT2:					; Print the 3 digit input number
	MOV A, #0C0H
	ACALL SEND_COMMAND
	MOV A, #'P'
	ACALL SEND_DATA 	; Print P
	MOV A, #'='
	ACALL SEND_DATA
	MOV A, #'('
	ACALL SEND_DATA
	POP 00H			;lowest significant digit in R0
	POP 01H
	POP 02H			;highest significant digit in R2

	MOV A, R0		; ASCII to hex convertion
	ANL A, #0FH
	MOV R0, A		
	
	MOV A, R1		; ASCII to decimal convertion
	ANL A, #0FH
	MOV B, #10
	MUL AB 
	MOV R1, A

	MOV A, R2		; ASCII to decimal convertion
	ANL A, #0FH
	MOV B, #100
	MUL AB 
				; R2 in A	

	ADD A, R1
	ADD A, R0		; We got the number in A
	MOV R7, A 		; The number in R7

	MOV DPTR, #LUT
LOOP:   CLR A
	MOVC A, @A+DPTR
	JZ DONE			; end of look-up table
	MOV B, A
	MOV R5 ,A		; divider kept in R5
	MOV A, R7
	DIV AB
	PUSH A 			; Keep the quotient for the next loop
	MOV A, B		; Remainder in B
	JZ YES			; Jump if remainder zero
	INC DPTR
	POP A
	SJMP LOOP
	
YES:	
	POP 07H
	INC R6 			; Count the number of prime implicants
	MOV A, R5	; Store the prime implicants in stack
	MOV B, #10
	DIV AB
	MOV 30H, A
	MOV A, B
	ORL A, #30H
	MOV 35H, A	;LEAST SIG
	MOV A, 30H
	MOV B, #10
	DIV AB
	ORL A, #30H
	MOV 33H, A	;MOST SİG
	MOV A, B
	ORL A, #30H
	MOV 34H, A
	MOV A, 33H
	PUSH A
	ANL A, #0Fh
	JZ S2
	POP A
	ACALL SEND_DATA
S2:	MOV A, 34H
	PUSH A
	ANL A, #0Fh
	JZ S3
	POP A
	ACALL SEND_DATA
S3:	MOV A, 35H
	ACALL SEND_DATA
	MOV A, #','
	ACALL SEND_DATA
	SJMP LOOP

DONE: 	
	MOV A, #')'
	ACALL SEND_DATA





	
	SJMP $

CONFIGURE_LCD:	;THIS SUBROUTINE SENDS THE INITIALIZATION COMMANDS TO THE LCD
	mov a,#38H	;TWO LINES, 5X7 MATRIX
	acall SEND_COMMAND
	mov a,#0FH	;DISPLAY ON, CURSOR BLINKING
	acall SEND_COMMAND
	mov a,#06H	;INCREMENT CURSOR (SHIFT CURSOR TO RIGHT)
	acall SEND_COMMAND
	mov a,#01H	;CLEAR DISPLAY SCREEN
	acall SEND_COMMAND
	mov a,#80H	;FORCE CURSOR TO BEGINNING OF THE FIRST LINE
	acall SEND_COMMAND
	ret



SEND_COMMAND:
	mov p1,a		;THE COMMAND IS STORED IN A, SEND IT TO LCD
	clr p3.5		;RS=0 BEFORE SENDING COMMAND
	clr p3.6		;R/W=0 TO WRITE
	setb p3.7	;SEND A HIGH TO LOW SIGNAL TO ENABLE PIN
	acall DELAY
	clr p3.7
	ret


SEND_DATA:
	mov p1,a		;SEND THE DATA STORED IN A TO LCD
	setb p3.5	;RS=1 BEFORE SENDING DATA
	clr p3.6		;R/W=0 TO WRITE
	setb p3.7	;SEND A HIGH TO LOW SIGNAL TO ENABLE PIN
	acall DELAY
	clr p3.7
	ret


DELAY:
	push 0
	push 1
	mov r0,#50
DELAY_OUTER_LOOP:
	mov r1,#255
	djnz r1,$
	djnz r0,DELAY_OUTER_LOOP
	pop 1
	pop 0
	ret


KEYBOARD: ;takes the key pressed from the keyboard and puts it to A
	mov	P0, #0ffh	;makes P0 input
K1:
	mov	P2, #0	;ground all rows
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, K1
K2:
	acall	DELAY
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, KB_OVER
	sjmp	K2
KB_OVER:
	acall DELAY
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, KB_OVER1
	sjmp	K2
KB_OVER1:
	mov	P2, #11111110B
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, ROW_0
	mov	P2, #11111101B
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, ROW_1
	mov	P2, #11111011B
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, ROW_2
	mov	P2, #11110111B
	mov	A, P0
	anl	A, #00001111B
	cjne	A, #00001111B, ROW_3
	ljmp	K2
	
ROW_0:
	mov	DPTR, #KCODE0
	sjmp	KB_FIND
ROW_1:
	mov	DPTR, #KCODE1
	sjmp	KB_FIND
ROW_2:
	mov	DPTR, #KCODE2
	sjmp	KB_FIND
ROW_3:
	mov	DPTR, #KCODE3
KB_FIND:
	rrc	A
	jnc	KB_MATCH
	inc	DPTR
	sjmp	KB_FIND
KB_MATCH:
	clr	A
	movc	A, @A+DPTR; get ASCII code from the table 
	ret

;ASCII look-up table 
KCODE0:	DB	'1', '2', '3', 'A'
KCODE1:	DB	'4', '5', '6', 'B'
KCODE2:	DB	'7', '8', '9', 'C'
KCODE3:	DB	'*', '0', '#', 'D'

my_string: DB 'INPUT=',0

LUT: DB 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31,37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107,109,113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193,197, 199, 211, 223, 227, 229, 233, 239, 241, 251,0 



END


