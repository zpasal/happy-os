DS_CHECK equ 3544DA2Ah

EXTERN code, bss, end
EXTERN _main
EXTERN _fault_wrapper

GLOBAL __kernel_size
GLOBAL __mem_lower, __mem_upper
GLOBAL __boot_device, __cmd_line
GLOBAL __idt_table
GLOBAL __text_start, __data_start, __bss_start
GLOBAL _setvect, _getvect

%define KERNEL_DATA_SELECTOR 0x10
%define KERNEL_CODE_SELECTOR 0x18

BITS 32

GLOBAL entry
SECTION .text
entry:
      mov eax, end
	mov eax, [ds_check]
	cmp eax, DS_CHECK
	je ds_ok
      mov word [0B8000h], 'D'
      mov word [0B8002h], 'S'
      mov word [0B0000h], 'D'
      mov word [0B0002h], 'S'
      jmp $
ds_ok:

	lgdt [gdt_ptr]
	mov ax,KERNEL_DATA_SELECTOR
	mov ds,ax
	mov es,ax
	mov ss,ax
	mov fs,ax
	mov gs,ax
	jmp KERNEL_CODE_SELECTOR:sbat
sbat:

EXTERN bss, end
	mov edi,bss
	mov ecx,end
	sub ecx,edi
	xor eax,eax
	rep stosb

	mov esp, stack

; preracunamo neke podatke
      mov eax, end
      sub eax, entry
      mov [__kernel_size], eax
      mov eax, entry
      mov [__text_start], eax
      mov eax, ds_check
      mov [__data_start], eax
      mov eax, bss
      mov [__bss_start], eax
; povadimo podatke koje je grub postavio
      mov eax, [ebx+4] ; flags
      mov [__mem_lower], eax
      mov eax, [ebx+8]
      mov [__mem_upper], eax
      mov eax, [ebx+12]
      mov [__boot_device], eax
      mov eax, [ebx+16]
      mov [__cmd_line], eax

; set up interrupt handlers, then load IDT register
	mov ecx,(idt_end - idt) >> 3 ; number of exception handlers
	mov edi,idt
	mov esi,isr0
do_idt:
	mov eax,esi			; EAX=offset of entry point
	mov [edi],ax			; set low 16 bits of gate offset
	shr eax,16
	mov [edi + 6],ax		; set high 16 bits of gate offset
	add edi,8			; 8 bytes/interrupt gate
	add esi,(isr1 - isr0)		; bytes/stub
	loop do_idt

	lidt [idt_ptr]

	call _main
	jmp $


MULTIBOOT_PAGE_ALIGN	equ 1<<0
MULTIBOOT_MEMORY_INFO	equ 1<<1
MULTIBOOT_AOUT_KLUDGE	equ 1<<16
MULTIBOOT_HEADER_MAGIC	equ 0x1BADB002
MULTIBOOT_HEADER_FLAGS	equ MULTIBOOT_PAGE_ALIGN | MULTIBOOT_MEMORY_INFO | MULTIBOOT_AOUT_KLUDGE
MULTIBOOT_CHECKSUM	equ -(MULTIBOOT_HEADER_MAGIC + MULTIBOOT_HEADER_FLAGS)

ALIGN 4
mboot:
	dd MULTIBOOT_HEADER_MAGIC
	dd MULTIBOOT_HEADER_FLAGS
	dd MULTIBOOT_CHECKSUM
	dd mboot
	dd code
	dd bss
	dd end
	dd entry


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; NAPOMENA - DIO ZA SETOVANJE IDTA-ova JE PREUZET IZ Os-Dev TUTOIRALA 6
;            (CHRIS GIESE). VECI DIO JE OSTAO ISTI.
;
%macro PUSHB 1
	db 6Ah
	db %1
%endmacro

; obicni interrupti bez error koda
; STACK: 0, NUM, GS, FS, ES, DS, 
%macro INTR 1
isr%1:
	push byte 0			      ; ( 0) fake error code
	PUSHB %1			      ; ( 2) exception number
	push gs				; ( 4) push segment registers
	push fs				; ( 6)
	push es				; ( 8)
	push ds				; ( 9)
	pusha				      ; (10) push GP registers
      mov ax, KERNEL_DATA_SELECTOR  ; (11) put known-good values...
	mov ds, eax		            ; (15) ...in segment registers
	mov es, eax		            ; (17)
	mov fs, eax		            ; (19)
	mov gs, eax		            ; (21)
	mov eax, esp	            ; (23)
	push eax		            ; (25) push pointer to regs_t
.1:
; setvect() changes the operand of the CALL instruction at run-time,
; so we need its location = 27 bytes from start of stub. We also want
; the CALL to use absolute addressing instead of EIP-relative, so:
	mov eax,_fault_wrapper         ; (26)
	call eax	                  ; (31)
	jmp all_ints	            ; (33)
%endmacro				      ; (38)

; interrupti sa error kodom
%macro INTR_EC 1
isr%1:
	nop				      ; error code already pushed
	nop				      ; nop+nop=same length as push byte
	PUSHB %1			      ; ( 2) exception number
	push gs				; ( 4) push segment registers
	push fs				; ( 6)
	push es				; ( 8)
	push ds				; ( 9)
	pusha				      ; (10) push GP registers
	mov ax,KERNEL_DATA_SELECTOR   ; (11) put known-good values...
	mov ds,eax		            ; (15) ...in segment registers
	mov es,eax		            ; (17)
	mov fs,eax		            ; (19)
	mov gs,eax		            ; (21)
	mov eax,esp		            ; (23)
	push eax		            ; (25) push pointer to regs_t
.1:
; setvect() changes the operand of the CALL instruction at run-time,
; so we need its location = 27 bytes from start of stub. We also want
; the CALL to use absolute addressing instead of EIP-relative, so:
	mov eax,_fault_wrapper        ; (26)
	call eax	                  ; (31)
	jmp all_ints	            ; (33)
%endmacro				      ; (38)

; the vector within the stub (operand of the CALL instruction)
; is at (isr0.1 - isr0 + 1)
all_ints:
	pop eax
	popa			; pop GP registers
	pop ds		; pop segment registers
	pop es
	pop fs
	pop gs
	add esp,8		; drop exception number and error code
	iret


; void getvect(t_vector *v, unsigned vect_num);
_getvect:
	push ebp
      mov ebp,esp
	push esi
	push ebx
	mov esi,[ebp + 8]
; get access byte from IDT[i]
	xor ebx,ebx
	mov bl,[ebp + 12]
	shl ebx,3
	mov al,[idt + ebx + 5]
	mov [esi + 0],eax
; get handler address from stub
	mov eax,isr1
	sub eax,isr0	; assume stub size < 256 bytes
	mul byte [ebp + 12]
	mov ebx,eax
	add ebx,isr0
	mov eax,[ebx + (isr0.1 - isr0 + 1)]
	mov [esi + 4],eax
	pop ebx
	pop esi
	pop ebp
	ret

; void setvect(vector_t *v, unsigned vect_num);
_setvect
	push ebp
	mov ebp,esp
	push esi
	push ebx
	mov esi,[ebp + 8]
; store access byte in IDT[i]
	mov eax,[esi + 0]
	xor ebx,ebx
	mov bl,[ebp + 12]
	shl ebx,3
	mov [idt + ebx + 5],al
; store handler address in stub
	mov eax,isr1
	sub eax,isr0	; assume stub size < 256 bytes
	mul byte [ebp + 12]
	mov ebx,eax
	add ebx,isr0
	mov eax,[esi + 4]
	mov [ebx + (isr0.1 - isr0 + 1)],eax
	pop ebx
	pop esi
	pop ebp
	ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; interrupt/exception stubs
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	INTR 0		; zero divide (fault)
	INTR 1		; debug/single step
	INTR 2		; non-maskable interrupt (trap)
	INTR 3		; INT3 (trap)
	INTR 4		; INTO (trap)
	INTR 5		; BOUND (fault)
	INTR 6		; invalid opcode (fault)
	INTR 7		; coprocessor not available (fault)
	INTR_EC 8	      ; *double fault (abort w/ error code)
	INTR 9		; coproc segment overrun (abort; 386/486SX only)
	INTR_EC 0Ah	      ; *bad TSS (fault w/ error code)
	INTR_EC 0Bh	      ; *segment not present (fault w/ error code)
	INTR_EC 0Ch	      ; *stack fault (fault w/ error code)
	INTR_EC 0Dh	      ; *GPF (fault w/ error code)
	INTR_EC 0Eh	      ; *page fault
	INTR 0Fh	      ; reserved
	INTR 10h	      ; FP exception/coprocessor error (trap)
	INTR 11h	      ; alignment check (trap; 486+ only)
	INTR 12h	      ; machine check (Pentium+ only)
	INTR 13h
	INTR 14h
	INTR 15h
	INTR 16h
	INTR 17h
	INTR 18h
	INTR 19h
	INTR 1Ah
	INTR 1Bh
	INTR 1Ch
	INTR 1Dh
	INTR 1Eh
	INTR 1Fh
; isr20 through isr2F are hardware interrupts. The 8259 programmable
; interrupt controller (PIC) chips must be reprogrammed to make these work.
	INTR 20h	      ; IRQ 0/timer interrupt
	INTR 21h	      ; IRQ 1/keyboard interrupt
	INTR 22h
	INTR 23h
	INTR 24h
	INTR 25h
	INTR 26h	      ; IRQ 6/floppy interrupt
	INTR 27h
	INTR 28h	      ; IRQ 8/real-time clock interrupt
	INTR 29h
	INTR 2Ah
	INTR 2Bh
	INTR 2Ch
	INTR 2Dh	      ; IRQ 13/math coprocessor interrupt
	INTR 2Eh	      ; IRQ 14/primary ATA ("IDE") drive interrupt
	INTR 2Fh	      ; IRQ 15/secondary ATA drive interrupt
	INTR 30h

; ostatak interrupta je nedefinisan
%assign i 31h
%rep (0FFh - 30h)
	INTR i
%assign i (i + 1)
%endrep


SECTION .data
ds_check: dd DS_CHECK
__kernel_size: dd 0
__mem_lower:   dd 0  ; podaci iz GRUBa
__mem_upper:   dd 0 
__boot_device: dd 0 
__cmd_line:    dd 0
__text_start:  dd 0
__data_start:  dd 0
__bss_start:   dd 0


gdt:
; NULL descriptor
	dw 0			; limit 15:0
	dw 0			; base 15:0
	db 0			; base 23:16
	db 0			; type
	db 0			; limit 19:16, flags
	db 0			; base 31:24
; unused descriptor
	dw 0
	dw 0
	db 0
	db 0
	db 0
	db 0
; KERNEL_DATA descriptor
	dw 0FFFFh
	dw 0
	db 0
	db 92h			; present, ring 0, data, expand-up, writable
	db 0CFh                 ; page-granular (4 gig limit), 32-bit
	db 0
; KERNEL_CODE descriptor
	dw 0FFFFh
	dw 0
	db 0
	db 9Ah			; present,ring 0,code,non-conforming,readable
	db 0CFh                 ; page-granular (4 gig limit), 32-bit
	db 0
gdt_end:
gdt_ptr:
	dw gdt_end - gdt - 1
	dd gdt

; idt tabela
__idt_table:
idt:
%rep 256         
	dw 0				; offset 15:0
	dw KERNEL_CODE_SELECTOR	; selector
	db 0				; (always 0 for interrupt gates)
	db 8Eh			; present,ring 0,'386 interrupt gate
	dw 0				; offset 31:16
%endrep
idt_end:

idt_ptr:
	dw idt_end - idt - 1		; IDT limit
	dd idt				; linear adr of IDT


SECTION .bss
	resd 1024
stack:

