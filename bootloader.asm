; -------------------
; Minimal Bootloader for BIOS
; Author: Hashem Wahed 
; -------------------

; What does a bootloader do? Boots a computer
; Generally, every processor starts in 16 bit mode, do our processing,
; then move on to 32 bits, etc
BITS 16		; We are in 16-bit real mode (default for BIOS)

; ORG pretty much says for us to do all of our addressing relative to 0x7C00
; BIOS loads the boot sector to memory at 0x7C00
ORG 0x7C00

start:
	; Set up segment registers 
	xor ax, ax		; AX = 0
	mov ds, ax		; Data Segment -> 0
	mov es, ax		; Extra Segment -> 0
main:
	; pauses CPU until it reaches an interrupt
	HLT

	; we want to make sure that it doesnt stop at the interrupt
halt:
	JMP halt

; The $-$$ tells us how many bytes our program takes up.
; We take 510 minus that value to get us to the location 510 in memory
; DB 0 means we write a bunch of 0s until we get to where we want in memory
TIMES 510-($-$$) DB 0
;signature that we want to write, which is what the BIOS is searching for
DW 0AA55h
