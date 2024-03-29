ORG 0000H
	ljmp MAIN

ORG 000BH
	CLR TR0
	CLR A
	MOVC A, @A+DPTR
	MOV TH0, A
	CLR A
	MOV A, #1
	MOVC A, @A+DPTR  // Get the frequency from LUT
	MOV TL0, A
	CPL CY
	SETB TR0
	MOV P1.1, C
	RETI

ORG 0030H

MAIN:	MOV TMOD, #21H	; Timer1 in 16 bit mode, Timer0 in 16 bit mode	
	MOV IE, #82H    ; Timer0 interrupt enabled
	MOV DPTR, #1000H
	CLR RI
	MOV R0, #8
	MOV SCON, #50H
	MOV TH1, #0F3H
	MOV TL1, #0F3H
	
	MOV A, SBUF
	JNB RI, $
	PUSH ACC
	DEC A
	ANL A, #0F0H
	CJNE A, #30H, OutOfRange
	POP ACC
	ANL A, #0F0H
	CJNE A, #30H, OutOfRange
	ANL A, #0FH
	MOV B, #10
	MUL AB
	MOV R1, A
	MOV TMOD, #11H
	SETB TF0
	
AGAIN:	CLR TR1
	MOV TL1, #0B0H	; Timer1 overflows in 0.05s
	MOV TH1, #3CH
	CLR TF1
	SETB TR1
	JNB TF1, $	; Wait for 0.05s
	DJNZ R1, AGAIN  ; Repeat 10 times so that 0.5s is achieved	
	INC DPTR
	INC DPTR
	MOV R1, #10
	DJNZ R0, AGAIN  ; 8 note loop

OutOfRange:
	LJMP MAIN



ORG 1000H  // LUT FOR FREQUENCİES
DB 0FCH, 44H, 0FCH, 0ADH, 0FDH, 0AH, 0FDH, 82H, 0FDH, 0C8H, 0FCH, 0CH, 0FEH, 06H, 0FEH, 022H


end 
