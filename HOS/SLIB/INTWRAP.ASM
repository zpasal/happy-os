;  sdf
; intwrap.asm
;
; Modul where all interrupts point to one interrupt handler - exec_handler
; Only three interrupts are not redirected there: timer, keyboard and
; sheduler interrupts. Timer & keyboard are redirected to timer_handler
; and keyboard_handler. Sheduler are coded here.
;
; TO DO: redirect one more interrupt for floppy access.
;
;
; Copyright (C) HappyOS 2003
;
;					Last Revision:08.03.2003

SECTION _TEXT
BITS 32

GLOBAL _interrupt_wrapper00, _interrupt_wrapper09, _interrupt_wrapper12
GLOBAL _interrupt_wrapper01, _interrupt_wrapper0A, _interrupt_wrapper13
GLOBAL _interrupt_wrapper02, _interrupt_wrapper0B, _interrupt_wrapper14
GLOBAL _interrupt_wrapper03, _interrupt_wrapper0C, _interrupt_wrapper15
GLOBAL _interrupt_wrapper04, _interrupt_wrapper0D, _interrupt_wrapper16
GLOBAL _interrupt_wrapper05, _interrupt_wrapper0E, _interrupt_wrapper17
GLOBAL _interrupt_wrapper06, _interrupt_wrapper0F, _interrupt_wrapper18
GLOBAL _interrupt_wrapper07, _interrupt_wrapper10, _interrupt_wrapper19
GLOBAL _interrupt_wrapper08, _interrupt_wrapper11, _interrupt_wrapper1A
GLOBAL _interrupt_wrapper1B, _interrupt_wrapper1E, _interrupt_wrapper21
GLOBAL _interrupt_wrapper1C, _interrupt_wrapper1F
GLOBAL _interrupt_wrapper1D, _interrupt_wrapper20
GLOBAL _interrupt_wrapper22
GLOBAL _interrupt_wrapper23
GLOBAL _interrupt_wrapper24
GLOBAL _interrupt_wrapper25
GLOBAL _interrupt_wrapper26
GLOBAL _interrupt_wrapper27
GLOBAL _interrupt_wrapper28
GLOBAL _interrupt_wrapper29
GLOBAL _interrupt_wrapper2A
GLOBAL _interrupt_wrapper2B
GLOBAL _interrupt_wrapper2C
GLOBAL _interrupt_wrapper2D
GLOBAL _interrupt_wrapper2E
GLOBAL _interrupt_wrapper2F
GLOBAL _interrupt_wrapper30

GLOBAL _set_idtr, __set_cr3
GLOBAL __hard_reboot
GLOBAL __flush_gdtr


EXTERN _total_tasks, _next_task, _current_task
EXTERN _exec_handler, _timer_handler, _keyboard_handler
EXTERN _idtr, _gdtr
EXTERN __irq6


%define BIT32 db 0x66

%macro  WRAPPER 2
%1:
        push    eax
        mov     eax, %2
        jmp     _exc_common           
%endmacro

__set_cr3:
        mov eax, cr3
	mov cr3, eax
        jmp short flush_cr3
flush_cr3:
	ret

_set_idtr:
        lidt [ds:_idtr]
        ret

__hard_reboot:
    cli
_again:
    in al, 0x64
    test al, 00000001b
    jnz _reread
    test al, 00000010b
    jnz _again
    mov al, 0xFE
    out 0x64, al
_reread:
    in al, 0x60
    jmp _again


__flush_gdtr:
        cli
        lgdt [ds:_gdtr]  ; seg. registers are ok  becuase GDT i
        ret              ; like prekrnl.bin gdt


; code below is code for interrupt wrapeer. All interrupts are switched
; to extern function interrupt_handler. Only timer, keyboard and sheduler
; interrupts are not redirected. Timer & keyboard are redirected to
; functions time_handler/keyboard_handler. Sheduler interrupt just
; switch tasks, and all code is here (SPEEEEEED I NEEED :)

_exc_common:
        push    ebp
        mov     ebp, esp
        push    ds
        push    es                      ; saving segment registers and
        pushad                          ; other regs because it's an ISR
        mov     bx, 0x20
        mov     ds, bx
        mov     es, bx                  ; load ds and es with valid selector
        mov     ebx, eax
        cmp     byte [_exc_has_error+ebx], 0
        je      .1
        push    word [ss:ebp+12]          ; error code  4
        push    dword [ss:ebp+16]         ; ip          8
        push    word [ss:ebp+20]         ; cs          12
        jmp     .2
.1:
        push    word 0                    ; error code
        push    dword [ss:ebp+12]         ; ip       4
        push    word [ss:ebp+16]          ; cs       8
.2:
        push    ax                      ; exception no
        mov     eax, [_current_task]    ; task id
        mov     ebx, [eax+6]
        push    ebx
;void exec_handler(unsigned task_id, short no, short cs, int ip, short error) {
        call    _exec_handler            ; call actual ISR code
        add     esp, 14
        popad                           ; restoring the regs
        pop     es
        pop     ds
        pop     ebp
        pop     eax
        iretd


WRAPPER _interrupt_wrapper00, 00h
WRAPPER _interrupt_wrapper01, 01h
WRAPPER _interrupt_wrapper02, 02h
WRAPPER _interrupt_wrapper03, 03h
WRAPPER _interrupt_wrapper04, 04h
WRAPPER _interrupt_wrapper05, 05h
WRAPPER _interrupt_wrapper06, 06h
WRAPPER _interrupt_wrapper07, 07h
WRAPPER _interrupt_wrapper08, 08h
WRAPPER _interrupt_wrapper09, 09h
WRAPPER _interrupt_wrapper0A, 0Ah
WRAPPER _interrupt_wrapper0B, 0Bh
WRAPPER _interrupt_wrapper0C, 0Ch
WRAPPER _interrupt_wrapper0D, 0Dh
WRAPPER _interrupt_wrapper0E, 0Eh
WRAPPER _interrupt_wrapper0F, 0Fh
WRAPPER _interrupt_wrapper10, 10h
WRAPPER _interrupt_wrapper11, 11h
WRAPPER _interrupt_wrapper12, 12h
WRAPPER _interrupt_wrapper13, 13h
WRAPPER _interrupt_wrapper14, 14h
WRAPPER _interrupt_wrapper15, 15h
WRAPPER _interrupt_wrapper16, 16h
WRAPPER _interrupt_wrapper17, 17h
WRAPPER _interrupt_wrapper18, 18h
WRAPPER _interrupt_wrapper19, 19h
WRAPPER _interrupt_wrapper1A, 1Ah
WRAPPER _interrupt_wrapper1B, 1Bh
WRAPPER _interrupt_wrapper1C, 1Ch
WRAPPER _interrupt_wrapper1D, 1Dh
WRAPPER _interrupt_wrapper1E, 1Eh
WRAPPER _interrupt_wrapper1F, 1Fh
; WRAPPER _interrupt_wrapper20, 20h   timer
; WRAPPER _interrupt_wrapper21, 21h   keyboard
WRAPPER _interrupt_wrapper22, 22h
WRAPPER _interrupt_wrapper23, 23h
WRAPPER _interrupt_wrapper24, 24h
WRAPPER _interrupt_wrapper25, 25h
;WRAPPER _interrupt_wrapper26, 26h    floppy
WRAPPER _interrupt_wrapper27, 27h
WRAPPER _interrupt_wrapper28, 28h
WRAPPER _interrupt_wrapper29, 29h
WRAPPER _interrupt_wrapper2A, 2Ah
WRAPPER _interrupt_wrapper2B, 2Bh
WRAPPER _interrupt_wrapper2C, 2Ch
WRAPPER _interrupt_wrapper2D, 2Dh
WRAPPER _interrupt_wrapper2E, 2Eh
WRAPPER _interrupt_wrapper2F, 2Fh
; WRAPPER _interrupt_wrapper30, 30h  sheduler

_interrupt_wrapper20:        ; time handler
	push ds
	push es
	pushad
	mov ax, 0x20
	mov ds, ax
	mov es, ax
	call _timer_handler
	popad
	pop es
	pop ds
	iretd

_interrupt_wrapper21:     ; keyboard handler
        push ds
	push es
	pushad
	mov ax, 0x20
	mov ds, ax
	mov es, ax
	call _keyboard_handler
	popad
	pop es
	pop ds
	iretd


_interrupt_wrapper26:        ; floppy handler
        push eax
        mov eax, 1
        mov [__irq6], eax
        mov al, 0x20
        out 0x20, al
        pop eax
        iretd

_interrupt_wrapper30:
        push ebp
        push edi
        push esi
        push edx
        push ecx
        push ebx
        push eax

        cli
        mov ax, 0x20         ; KERNEL FLAT DATA SEGMENT
        mov ds, ax
        mov es, ax
        mov es, ax
        mov fs, ax 
        mov gs, ax

        mov ebx, [_current_task]
        mov [ebx], esp

        mov ebx, [_next_task]
        mov [_current_task], ebx
        mov esp, [ebx]
        sti

        pop eax
        pop ebx
        pop ecx
        pop edx
        pop esi
        pop edi
        pop ebp    
        iretd

SECTION _DATA
        _exc_has_error  DB      0,0,0,0,0,0,0,0, 1,0,1,1,1,1,1,0
                        DB      0,1,0,0,0,0,0,0, 0,0,0,0,0,0,0,0
