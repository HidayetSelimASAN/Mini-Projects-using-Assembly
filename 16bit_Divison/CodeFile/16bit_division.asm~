ORG 0000

	MOV R0, #15H	; low byte of dividend
	MOV R1, #31H	; High byte of dividend
	MOV R2, #07H	; Specify the divisor
	
	MOV A, R1 
	MOV B, R2
	DIV AB		

	MOV 30H, A	; B2 in 30H
	MOV 31H, B	; K2 in 31H
	
	MOV A, R0 
	MOV B, R2
	DIV AB		
	
	MOV 32H, A	; B1 in 32H
	MOV 33H, B	; K1 in 33H
	
	MOV R6, #00H 	; R6 is the counter for divison

	MOV A, 31H
	JZ CHECK 
DEVAM:
AGAIN:  CLR C
	MOV A, 33H
	SUBB A, R2 
	MOV 33H, A
	MOV A, 31H
	SUBB A, #00H
	MOV 31H, A
	INC R6

	CJNE A, #00H , AGAIN
	MOV A, 33H
	CJNE A, 02H, HERE

HERE:	JNC AGAIN
	CLR C
	MOV R5, A 	;K in r5
	MOV A, 32H
	ADD A, R6
	MOV R3, A
	MOV A, 30H
	ADDC A, #00H
	MOV R4, A
	SJMP $

CHECK:  MOV A, 33H
	JNZ COMPARE 	
	MOV R5, #00H
	MOV R4, 30H
	MOV R3, 32H
	SJMP $

COMPARE:
	CJNE A, 02H, $+3
	JC DONE		;SUBB until k1 is smaller
	SUBB A, R2
	INC R6
	SJMP COMPARE

DONE: 	MOV R5, A
	MOV A, 32H
	ADD A, R6
	MOV R3, A
	MOV R4, 30H
	SJMP $








END
