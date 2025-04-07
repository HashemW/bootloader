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
    ; ss sets the segment of the stack
    mov ss, ax
    ; moves the stack pointer down to the starting point of our application
    mov sp, 0x7C00 
    ;mov si, os_boot_msg
    ;call print
	; pauses CPU until it reaches an interrupt
	HLT

	; we want to make sure that it doesnt stop at the interrupt
halt:
	JMP halt

print:
    ; push all these registers onto the stack
    push si
    push ax
    push bx

print_loop:
    ; loads a single byte in the al register from si?
    LODSB
    ;check if the value loaded =0, if it was we are at the end of the string
    or al,al
    jz done_print
    
    ; represents printing a character to the screen
    mov ah, 0x0E
    ; represents "page number," maybe you have multiple monitors, dw about it
    mov bh, 0
    ; BIOS interrupt, called a video interrupt
    int 0x10

    jmp print_loop
done_print:
    pop bx
    pop ax
    pop si
    ret
os_boot_msg: DB "Our OS has booted!", 0x0D, 0x0A, 0
; The $-$$ tells us how many bytes our program takes up.
; We take 510 minus that value to get us to the location 510 in memory
; DB 0 means we write a bunch of 0s until we get to where we want in memory
TIMES 510-($-$$) DB 0
;signature that we want to write, which is what the BIOS is searching for
DW 0AA55h
