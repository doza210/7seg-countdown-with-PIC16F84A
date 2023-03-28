;====================================================================
; Main.asm file generated by New Project wizard
;
; For decoder (74LS7) attached to 7seg display
; Processor: PIC16F84A
; Compiler:  MPASM (Proteus)
;====================================================================

;====================================================================
; DEFINITIONS
;====================================================================

LIST P=16F84A, F=INHX8M 			; MCU is PIC16F84A, output is Intel Hex
INCLUDE<P16F84A.INC> 				; include this file to use register names instead of addresses
__CONFIG _CP_OFF & _WDT_ON & _XT_OSC 		; code protection off, Watchdog Timer on, XTAL osc used

;====================================================================
; VARIABLES
;====================================================================

COUNT EQU 0CH 					; assign COUNT to memory address 0CH

;====================================================================
; RESET and INTERRUPT VECTORS
;====================================================================

; Reset Vector
ORG 0 
GOTO INIT

;====================================================================
; CODE SEGMENT
;====================================================================

INIT					; initialize PIC
	BSF STATUS, RP0 		; set register bank to 1
	CLRF TRISB 			; clear register TRISB (bank 1)
	
	MOVLW 0DH 			; load literal value 0DH to Wreg
					; prescaler 1:64 assigned to Watchdog Timer (WDT)
	MOVWF OPTION_REG 		; move data in Wreg to register OPTION_REG 	
	BCF STATUS, RP0 		; set register bank to 0
	
	;program start
START CLRF PORTB			; clear register PORTB (bank 0)
	MOVLW 0AH 			; load literal value 0AH to Wreg
	MOVWF COUNT 			; move data in Wreg to register COUNT

PRESS  BTFSS PORTA, 0			; check if bit 0 at PORTA is1, skip next instruction if 1
	GOTO PRESS			; jump to label PRESS
		
	MOVLW 09H			; load literal value 09H to Wreg
	MOVWF PORTB			; move data in Wreg to PORTB

HERE	SLEEP
		
	DECFSZ COUNT, 1 		; decrement register COUNT, skip next line if result is 0
	GOTO DEC 			; jump to label DEC
	GOTO PRESS			; jump to label PRESS

DEC  DECF PORTB 			; decrement register PORTB
	GOTO HERE 			; jump to label HERE


;====================================================================
	END
