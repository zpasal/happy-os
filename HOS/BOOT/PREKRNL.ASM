;
;  Kernel loader v1.3
;                                            Last Change: 03.03.2001
;
;   1. Prekopira podatke o definiciji diska (sa boot koda - 7C00)
;   2. Udje u Unreal Mode
;   3. Ucita kernel na KERNEL_ADDRESS
;   4. Setuje pageove, tako da mapira kernel sa KERNEL_ADDRESS na
;      3GB  ( C0000000 )
;   5. Udje u P-mode sa setovanim pagiranjem
;   6. Skok na kernel
;
;
;  - Kernel ucitan na 1MB  == 0x00100000
;  - Kernel mapiran na 3GB == 0xC0000000
;  - PageDirectory  na 0   == 0x00000000
;  - PageTable 1:1  na 4KB  
;  - PageTable Kern na 8KB 
;  - PageTable Heap na 12KB




[SECTION .text]

%include "boot.inc"

%define KERNEL_ADDRESS 0x100000
%define KERNEL_TMP_ADDRESS 0x6000

%define PAGE_DIR_ADDRESS   0
%define PAGE_11_ADDRESS ((PAGE_DIR_ADDRESS) + 4096)
%define PAGE_KRNL_ADDRESS ((PAGE_11_ADDRESS) + 4096)
%define PAGED_KRNL_ADDRESS 0xC0000000
; 100*4096 ~ 400KB
%define KERNEL_PAGE_SIZE   103

; za novi font definisati donji makro :)
; %define __NEWFONT__

start:
      cli
      mov ax, cs
      mov ds, ax
      mov es, ax
      mov ss, ax
      mov sp, 0xFFFE
      sti

%ifdef __NEWFONT__
      mov ax, 0x1110
      mov bh, 0x10
      xor bl, bl
      mov cx, 256
      xor dx, dx
      mov bp, font
      int 0x10
%endif

      mov edi, msg_started
      call prints

;   1. Prekopira podatke o definiciji diska (sa boot koda - 7C00)
      mov cx, 20
      xor ax, ax
      mov es, ax
      mov di, [oem]
      mov si, 3
cloop:
      mov al, [es:si]      
      mov [di], al
      inc si
      inc di
      loop cloop 

; setuje fatno_mul_spf i dir_sectors
      xor ax, ax
      mov al, [fno]
      mul word [spf]
      mov [fatno_mul_spf], ax

      mov ax, [rot]
      dec ax
      shr ax, 4
      inc ax
      mov [dir_sectors]  , ax


;   2. Udje u Unreal Mode

      xor eax, eax
      xor ebx, ebx
      mov ax, cs
      shl eax, 4
      mov bx, gdt
      add eax, ebx
      mov dword [gdtr+2], eax

      xor eax, eax
      xor ebx, ebx
      mov ax, cs
      shl eax, 4
      mov bx, protected
      add eax, ebx
      mov word [gdt+18],ax
      rol eax, 16
      mov [gdt+20],al
      mov [gdt+23],ah

      push cs
      push word realagain

      cli
      lgdt [cs:gdtr]
      mov eax, cr0
      or al, 1
      mov cr0, eax

      db 0xEA
      dw 0, 16
protected:
      mov ax, 8
      mov ds, ax
      mov es, ax
      mov fs, ax
      mov gs, ax
      mov eax, cr0
      and eax, 0FFFFFFFEh
      mov cr0, eax
      retf
realagain:

      mov ax, cs
      mov ds, ax
      mov es, ax
      mov ss, ax
      mov sp, 0xFFFE
      sti


;   3. Ucita kernel na KERNEL_ADDRESS

      mov bx, [rot]        ; koliko entria za pretraziti
      mov ax, ROOT_ADDRESS
      mov es, ax
      xor di, di   ; ES:DI -> odakle pretraziva
      xor cx, cx
search:
      mov si, file_to_load  ; DS:SI -> sta poredi
      mov cl, 11
      cld
      rep cmpsb
      je loader_find   ; trazeni fajl
      add cl, 21
      add di, cx
      dec bx
      jnz search
        ; ako smo pretrazili sve entrie => ERROR sistem ne postoji
error:
   ;   mov edi, msg_nosystem
   ;   call prints 
	mov ah, 0x0E
	mov al, 'X'
	xor bx, bx
	int 0x10
      jmp $


loader_find:
        mov cx, [es:di+0x0F]  ; pocetni cluster

	mov ax, KERNEL_TMP_ADDRESS
	mov es, ax

        mov edi, msg_loading
        call prints

read_next:
        push cx

        ; sec = hid+res+(broj FAT-ova*spf)+direntrysec+(LBA-2)*(spc(=1))
        mov ax, [hid]  ; sec = hid
        add ax, [res]  ; sec = hid+res
        add ax, [fatno_mul_spf] ; sec = hid+res*(fno*spf)
        add ax, [dir_sectors] ; sec = hid+res*(fno*spf)+direntrysec
        push ax

        mov ax, cx     ; (LBA-2)*spc
        sub ax, 2
        xor dx, dx
        mov dl, [spc]
        mul dx

        pop bx         ; bx = sec
        add ax, bx     ; sec = BX[=hid+res*(fno*spf)+direntrysec] + (LBA-2)*spc


        ; sada nam je AX LBA clustera
        mov cx, 1         ; prvi sector
        call read_sectors
	inc word [kernel_size]

	mov ah, 0x0E
	mov al, '.'
	xor bx, bx
	int 0x10

        pop ax
        call next_cluster
        cmp ax, 0xFF8
        jae zadnji_cluster

        mov cx, ax
        jmp read_next

zadnji_cluster:
; dealokacija kernela na KERNEL_ADDRESS
;        ES:EDI <- DS:ESI

	xor ecx, ecx
	mov cx, [kernel_size]
	shl ecx, 9    ; broj bajtova = kernel_size * 512

	mov ax, KERNEL_TMP_ADDRESS
	mov ds, ax
	xor esi, esi

	xor ax, ax
	mov es, ax
	mov edi, KERNEL_ADDRESS
dealoc_loop:
	mov al, [esi]
	mov [es:edi], al
       inc edi
	inc esi
	loop dealoc_loop

 	 mov cx, 19*3
lpfloppy:
         int 0x8
         loop lpfloppy

;--------------------- SETOVANJE PAGE DIREKTORIJA ---------------------------

	xor ax, ax
	mov ds, ax

	mov edi, PAGE_DIR_ADDRESS
	mov ecx, 1024
	xor eax, eax
pd_zero:
	mov [edi], eax
	add edi, 4
	loop pd_zero

	mov edi, PAGE_DIR_ADDRESS
	mov eax, PAGE_11_ADDRESS     ; pointer na PT 4MB lin = fiz
	or al, 7
	mov [edi], eax

	mov eax, PAGE_KRNL_ADDRESS    ; pointer na PT kernela
	or al, 7
	mov [edi+0xC00], eax


; Setovanje 4MB fizickje == 4MB virtualne
	mov edi, PAGE_11_ADDRESS
	xor eax, eax
	xor ebx, ebx
        mov ecx, 1024
pt1:
        or al, 7
	mov [edi], eax
	add edi, 4
        add ebx, 4096
	mov eax, ebx
	loop pt1



; setovanje kernela na 3GB
	mov edi, PAGE_KRNL_ADDRESS
	mov eax, KERNEL_ADDRESS
	mov ebx, eax
	xor ecx, ecx
pt2:
	or al, 7
	mov [edi], eax
	add edi, 4
	add ebx, 4096
	mov eax, ebx
	inc ecx
	cmp ecx, KERNEL_PAGE_SIZE  ; ***************
	jl pt2
	xor eax, eax
ptz2:
	mov [edi], eax        ; ostalo na nulu
	add edi, 4
	inc ecx
        cmp ecx, 1024
	jl ptz2


	mov ax, cs
	mov ds, ax
	mov es, ax

; 5. Setovanje P-moda
; ubijanje NMI i setoavanje keyboard & timer
        cli
        mov dx, 0x70    ; disable NMI
	in al, dx
	or al, 0x80
	out dx, al        

;        mov dx, 0x21    ; enable keyb & timer
;	mov al, 0xFC
;	out dx, al
;	mov dx, 0xA1    ; disable all slaves
;       mov al, 0xFF
;	out dx, al 


; prelazak u PROTECTED MODE i skok u kernel
; FLAT CODE & DATA 

        mov ax, cs
        mov ds, ax
        mov es, ax

	xor eax, eax
	xor ebx, ebx
	mov ax, cs
	shl eax, 4
	mov bx, gdt
	add eax, ebx
	mov dword [gdtr+2], eax

	xor eax, eax
	xor ebx, ebx
        mov ax, cs
	shl eax, 4
	mov bx, kernel_entry
	add eax, ebx
	mov word [gdt+18],ax
	rol eax, 16
	mov [gdt+20],al
	mov [gdt+23],ah

	mov eax, PAGE_DIR_ADDRESS
	mov cr3, eax                 ; PDBR -> Page directory

        lgdt [cs:gdtr]
	mov eax, cr0
	or  eax, 0x80000001           ; p-mode + pageing
	mov cr0, eax

        db 0xEA
        dw 0, 16
kernel_entry:
	mov ax, 0x20
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax
;	mov esp, 4*1024-4  ; ******** SKONTATI

;        mov dx, 0x3C8
;        mov al, 0
;        out dx, al
;        inc dx
;        mov al, 30
;        out dx, al
;        out dx, al
;        out dx, al

        jmp dword 0x0018:PAGED_KRNL_ADDRESS  ; SKOK NA KERNEL

        jmp $


; convert_lba - konvertuje logicki sektor u head, track i sector
;       SEC = (LBA % spt) + 1
;       TRACK = LBA / (spt * nh)
;       HEAD = (LBA / spt) % nh
; INPUT:  AX - LBA
; OUTPUT: BH - Head
;         AX - Track
;         BL - Sector
convert_lba:
          push dx
          push cx
          push ax
          xor dx, dx
          div word [spt]
          mov bx, dx
          xor dx, dx
          inc bx               ; TO sec
          div word [hno]
          mov bh, dl           ; BH - HEAD; BL - SEC
          mov ax, [spt]
          mul word [hno]
          mov cx, ax
          xor dx, dx
          pop ax
          div cx
          pop cx
          pop dx
          retn


; read_sectors - cita sectore pomocu LBA
; INPUT: AX - LBA
;        CX - koliko sectora
;        ES - gdje ucitava
read_sectors:

          or cx, cx        ; da li je procitao sve sektore
          jz kraj_citanja
          push cx
          push ax

          call convert_lba
          mov dh, bh   ; head
          xor dl, dl   ; drive  [floppy - 00]
          mov cl, bl   ; sector
          mov ch, al   ; track
          mov al, 1    ; jedan sektor za procitati
          mov ah, 2
          xor bx, bx   ; ES:0000
          int 0x13
          jc disk_error
          mov ax, es   ; update segment (512/16 = 32)
          add ax, 32
          mov es, ax
          pop ax
          pop cx
          dec cx
          inc ax
          jmp read_sectors

kraj_citanja:
          retn

disk_error:
          mov edi, msg_diskerror
          call prints
          jmp $

; next_cluster - racuna slijedeci cluster fajla
; INPUT : AX  pocetni cluster (LBA)
; OUTPUT: AX  slijedeci cluster (LBA)
next_cluster:
     push es
     push ebx
     push ax      ; snimi LBA
     mov bx, 3
     mul bx
     shr ax, 1    ; index u FAT-u = (LBA * 3) / 2
     mov bx, FAT_ADDRESS
     mov es, bx
     mov bx, ax
     mov ax, [es:bx] ; uzmi word sa indexa iz FAT-a
     pop bx          ; LBA -> BX
     test bx, 1
     jz paran        ; ako je paran => zadrzi donjih 12 bitova
     shr ax, 4       ; ako nije, onda gornjih 12 bitova
paran:
     and ax, 0xFFF
     pop ebx
     pop es
     retn

; puts - ispis ASCIIZ stringa
; INPUT - DI pointer na string
;
prints:
     push ax
     push bx
     mov ah, 0x0E
     xor bx, bx
ploop:
     mov al, [edi]
     or al, al
     jz endloop
     int 0x10
     inc edi
     jmp ploop
endloop:
     pop bx
     pop ax
     retn

gdtr    dw 5*8
        dd 0

gdt     db 0,0,0,0,0,0,0,0          ; NULL

        dw 0FFFFh, 0                ; FLAT DATA
        db 0, 10010010b, 10001111b, 0

        dw 0FFFFh, 0                ; CODE
        db 0, 10011010b, 00000000b, 0

	dw 0xFFFF, 0                ; KERNEL FLAT CODE
	db 0, 10011010b, 11001111b, 0

	dw 0xFFFF, 0                ; KERNEL FLAT DATA
	db 0, 10010010b, 11001111b, 0

file_to_load db 'KERNEL  BIN'
fatno_mul_spf dw 0
dir_sectors   dw 0
kernel_size   dw 0

msg_started   db 'Prekrnl lodaer started.',10,13,0
msg_diskerror db 'Disk error!',0
msg_nosystem  db 'Can not find kernel.bin !',10,13,0
msg_loading    db 'Loading',0
p db 'end',10,13,0

; podaci koji se prekopiraju sa boot koda
oem db 'KOS2.1.1'
bps dw 512
spc db 1
res dw 1
fno db 2
rot dw 0xE0
lno dw 0x0B40
mdb db 0xF0
spf dw 9
spt dw 18
hno dw 2
hid dw 0


%ifdef __NEWFONT__
; ovo su samo definicje novog izgleda karaktera (ako je __NEWFONT__ definisan)
font   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 066h, 066h
   db 000h, 000h, 042h, 03Ch, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 066h, 066h
   db 000h, 000h, 03Ch, 042h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 066h, 0FFh
   db 0FFh, 0FFh, 07Eh, 07Eh, 03Ch, 018h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 018h, 03Ch
   db 07Eh, 0FFh, 0FFh, 07Eh, 03Ch, 018h, 000h, 000h
   db 000h, 000h, 000h, 000h, 081h, 042h, 03Ch, 024h
   db 024h, 024h, 024h, 03Ch, 042h, 081h, 000h, 000h
   db 000h, 000h, 000h, 000h, 081h, 0C3h, 0FFh, 0E7h
   db 0E7h, 0E7h, 0E7h, 0FFh, 0C3h, 081h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 018h
   db 03Ch, 07Eh, 03Ch, 018h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 00Fh, 003h, 005h, 008h
   db 018h, 024h, 042h, 081h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Ch, 042h, 081h, 042h
   db 024h, 018h, 018h, 0FFh, 018h, 018h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Fh, 021h, 03Fh, 021h
   db 021h, 021h, 021h, 027h, 0E7h, 0E0h, 000h, 000h
   db 000h, 000h, 000h, 000h, 018h, 099h, 05Ah, 024h
   db 042h, 042h, 024h, 05Ah, 099h, 018h, 000h, 000h
   db 000h, 000h, 000h, 000h, 020h, 030h, 038h, 03Ch
   db 03Eh, 03Eh, 03Ch, 038h, 030h, 020h, 000h, 000h
   db 000h, 000h, 000h, 000h, 004h, 00Ch, 01Ch, 03Ch
   db 07Ch, 07Ch, 03Ch, 01Ch, 00Ch, 004h, 000h, 000h
   db 000h, 000h, 000h, 000h, 010h, 038h, 07Ch, 010h
   db 010h, 010h, 010h, 07Ch, 038h, 010h, 000h, 000h
   db 000h, 000h, 000h, 000h, 066h, 066h, 066h, 066h
   db 066h, 066h, 066h, 000h, 066h, 066h, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Eh, 052h, 092h, 052h
   db 03Eh, 012h, 012h, 012h, 012h, 012h, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Ch, 042h, 081h, 058h
   db 024h, 024h, 01Ah, 081h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 0FFh, 0FFh, 0FFh, 0FFh, 000h, 000h
   db 000h, 000h, 000h, 000h, 010h, 038h, 07Ch, 010h
   db 010h, 010h, 07Ch, 038h, 010h, 07Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 010h, 038h, 07Ch, 010h
   db 010h, 010h, 010h, 010h, 010h, 010h, 000h, 000h
   db 000h, 000h, 000h, 000h, 010h, 010h, 010h, 010h
   db 010h, 010h, 010h, 07Ch, 038h, 010h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 020h
   db 040h, 0FFh, 040h, 020h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 080h, 080h, 080h, 0FFh, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 024h
   db 066h, 0FFh, 066h, 024h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 018h, 03Ch, 07Eh, 0FFh, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 0FFh, 07Eh, 03Ch
   db 018h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 018h, 03Ch, 03Ch, 03Ch
   db 03Ch, 018h, 018h, 000h, 018h, 018h, 000h, 000h
   db 000h, 000h, 000h, 000h, 024h, 024h, 048h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 024h, 024h, 0FFh, 024h
   db 024h, 024h, 024h, 0FFh, 024h, 024h, 000h, 000h
   db 000h, 000h, 000h, 008h, 03Ch, 04Ah, 089h, 048h
   db 028h, 01Ch, 00Ah, 089h, 04Ah, 03Ch, 008h, 000h
   db 000h, 000h, 000h, 000h, 000h, 001h, 062h, 044h
   db 008h, 010h, 022h, 046h, 080h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 038h, 044h
   db 044h, 038h, 045h, 082h, 044h, 03Bh, 000h, 000h
   db 000h, 000h, 000h, 000h, 010h, 010h, 020h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 008h, 010h, 020h, 020h
   db 020h, 020h, 020h, 020h, 010h, 008h, 000h, 000h
   db 000h, 000h, 000h, 000h, 010h, 008h, 004h, 004h
   db 004h, 004h, 004h, 004h, 008h, 010h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 092h
   db 054h, 038h, 0FEh, 038h, 054h, 092h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 010h
   db 010h, 010h, 0FEh, 010h, 010h, 010h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 008h, 008h, 010h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 07Eh, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 018h, 018h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 001h, 002h
   db 004h, 008h, 010h, 020h, 040h, 080h, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Ch, 042h, 085h, 089h
   db 089h, 089h, 091h, 0A1h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 008h, 008h, 008h, 008h
   db 008h, 008h, 008h, 008h, 008h, 008h, 000h, 000h
   db 000h, 000h, 000h, 000h, 07Eh, 002h, 002h, 002h
   db 07Eh, 040h, 040h, 040h, 040h, 07Eh, 000h, 000h
   db 000h, 000h, 000h, 000h, 07Eh, 002h, 002h, 002h
   db 03Eh, 002h, 002h, 002h, 002h, 07Eh, 000h, 000h
   db 000h, 000h, 000h, 000h, 042h, 042h, 042h, 042h
   db 042h, 07Eh, 002h, 002h, 002h, 002h, 000h, 000h
   db 000h, 000h, 000h, 000h, 07Eh, 040h, 040h, 040h
   db 07Eh, 002h, 002h, 002h, 002h, 07Eh, 000h, 000h
   db 000h, 000h, 000h, 000h, 07Eh, 040h, 040h, 040h
   db 07Eh, 042h, 042h, 042h, 042h, 07Eh, 000h, 000h
   db 000h, 000h, 000h, 000h, 07Eh, 002h, 002h, 002h
   db 002h, 002h, 002h, 002h, 002h, 002h, 000h, 000h
   db 000h, 000h, 000h, 000h, 07Eh, 042h, 042h, 042h
   db 07Eh, 042h, 042h, 042h, 042h, 07Eh, 000h, 000h
   db 000h, 000h, 000h, 000h, 07Eh, 042h, 042h, 042h
   db 042h, 07Eh, 002h, 002h, 002h, 002h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 018h, 018h, 000h
   db 000h, 000h, 000h, 018h, 018h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 018h, 018h, 000h
   db 000h, 000h, 000h, 008h, 008h, 010h, 000h, 000h
   db 000h, 000h, 000h, 000h, 002h, 004h, 008h, 010h
   db 020h, 020h, 010h, 008h, 004h, 002h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 07Eh, 000h, 07Eh, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 040h, 020h, 010h, 008h
   db 004h, 004h, 008h, 010h, 020h, 040h, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Ch, 042h, 081h, 042h
   db 004h, 008h, 008h, 000h, 018h, 018h, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Ch, 042h, 081h, 081h
   db 09Fh, 091h, 09Fh, 080h, 040h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 018h, 024h, 042h, 042h
   db 042h, 07Eh, 042h, 042h, 042h, 042h, 000h, 000h
   db 000h, 000h, 000h, 000h, 07Ch, 042h, 042h, 042h
   db 07Ch, 042h, 042h, 042h, 042h, 07Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Ch, 042h, 040h, 040h
   db 040h, 040h, 040h, 040h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 078h, 044h, 042h, 042h
   db 042h, 042h, 042h, 042h, 044h, 078h, 000h, 000h
   db 000h, 000h, 000h, 000h, 07Eh, 040h, 040h, 040h
   db 07Ch, 040h, 040h, 040h, 040h, 07Eh, 000h, 000h
   db 000h, 000h, 000h, 000h, 07Eh, 040h, 040h, 040h
   db 07Ch, 040h, 040h, 040h, 040h, 040h, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Ch, 042h, 040h, 040h
   db 040h, 05Eh, 042h, 042h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 042h, 042h, 042h, 042h
   db 042h, 07Eh, 042h, 042h, 042h, 042h, 000h, 000h
   db 000h, 000h, 000h, 000h, 038h, 010h, 010h, 010h
   db 010h, 010h, 010h, 010h, 010h, 038h, 000h, 000h
   db 000h, 000h, 000h, 000h, 07Eh, 002h, 002h, 002h
   db 002h, 002h, 002h, 042h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 042h, 044h, 048h, 050h
   db 060h, 060h, 050h, 048h, 044h, 042h, 000h, 000h
   db 000h, 000h, 000h, 000h, 040h, 040h, 040h, 040h
   db 040h, 040h, 040h, 040h, 040h, 07Eh, 000h, 000h
   db 000h, 000h, 000h, 000h, 042h, 066h, 05Ah, 05Ah
   db 042h, 042h, 042h, 042h, 042h, 042h, 000h, 000h
   db 000h, 000h, 000h, 000h, 042h, 042h, 042h, 062h
   db 052h, 04Ah, 046h, 042h, 042h, 042h, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Ch, 042h, 042h, 042h
   db 042h, 042h, 042h, 042h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 07Ch, 042h, 042h, 042h
   db 042h, 07Ch, 040h, 040h, 040h, 040h, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Ch, 042h, 042h, 042h
   db 042h, 042h, 042h, 04Ah, 046h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 07Ch, 042h, 042h, 042h
   db 07Ch, 060h, 050h, 048h, 044h, 042h, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Ch, 042h, 040h, 020h
   db 010h, 008h, 004h, 002h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 0FEh, 092h, 010h, 010h
   db 010h, 010h, 010h, 010h, 010h, 010h, 000h, 000h
   db 000h, 000h, 000h, 000h, 042h, 042h, 042h, 042h
   db 042h, 042h, 042h, 042h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 042h, 042h, 042h, 042h
   db 042h, 042h, 042h, 042h, 024h, 018h, 000h, 000h
   db 000h, 000h, 000h, 000h, 042h, 042h, 042h, 042h
   db 042h, 042h, 05Ah, 05Ah, 05Ah, 024h, 000h, 000h
   db 000h, 000h, 000h, 000h, 042h, 042h, 024h, 018h
   db 018h, 018h, 018h, 024h, 042h, 042h, 000h, 000h
   db 000h, 000h, 000h, 000h, 042h, 042h, 042h, 026h
   db 01Ah, 002h, 002h, 002h, 044h, 038h, 000h, 000h
   db 000h, 000h, 000h, 000h, 07Eh, 002h, 002h, 004h
   db 008h, 010h, 020h, 020h, 040h, 07Eh, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Ch, 020h, 020h, 020h
   db 020h, 020h, 020h, 020h, 020h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 080h, 040h
   db 020h, 010h, 008h, 004h, 002h, 001h, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Ch, 004h, 004h, 004h
   db 004h, 004h, 004h, 004h, 004h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 010h, 028h, 044h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 0FFh, 000h
   db 000h, 000h, 000h, 000h, 020h, 020h, 010h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 03Ch
   db 042h, 042h, 042h, 042h, 042h, 03Dh, 000h, 000h
   db 000h, 000h, 000h, 000h, 040h, 040h, 040h, 05Ch
   db 062h, 042h, 042h, 042h, 062h, 05Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 03Ch
   db 042h, 040h, 040h, 040h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 002h, 002h, 002h, 03Ah
   db 046h, 042h, 042h, 042h, 046h, 03Ah, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 03Ch
   db 042h, 042h, 07Eh, 040h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 00Ch, 010h, 010h, 010h
   db 038h, 010h, 010h, 010h, 010h, 038h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 03Ch
   db 042h, 042h, 042h, 046h, 03Ah, 002h, 002h, 00Ch
   db 000h, 000h, 000h, 000h, 040h, 040h, 040h, 040h
   db 05Ch, 062h, 042h, 042h, 042h, 042h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 010h, 000h, 038h
   db 010h, 010h, 010h, 010h, 010h, 038h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 008h, 000h
   db 01Ch, 008h, 008h, 008h, 008h, 008h, 008h, 010h
   db 000h, 000h, 000h, 000h, 060h, 020h, 020h, 022h
   db 024h, 028h, 030h, 030h, 028h, 066h, 000h, 000h
   db 000h, 000h, 000h, 000h, 030h, 010h, 010h, 010h
   db 010h, 010h, 010h, 010h, 010h, 038h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 024h
   db 05Ah, 05Ah, 042h, 042h, 042h, 042h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 0BCh
   db 042h, 042h, 042h, 042h, 042h, 042h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 03Ch
   db 042h, 042h, 042h, 042h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 05Ch
   db 062h, 042h, 042h, 062h, 05Ch, 040h, 040h, 0E0h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 03Ah
   db 046h, 042h, 042h, 046h, 03Ah, 002h, 002h, 006h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 05Ch
   db 060h, 040h, 040h, 040h, 040h, 040h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 03Eh
   db 040h, 040h, 03Ch, 002h, 002h, 07Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 010h, 010h, 010h, 038h
   db 010h, 010h, 010h, 010h, 010h, 008h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 042h
   db 042h, 042h, 042h, 042h, 042h, 03Dh, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 042h
   db 042h, 042h, 042h, 042h, 024h, 018h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 042h
   db 042h, 042h, 042h, 05Ah, 05Ah, 024h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 044h
   db 044h, 028h, 010h, 028h, 044h, 044h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 042h
   db 042h, 042h, 042h, 042h, 03Eh, 002h, 002h, 00Ch
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 07Eh
   db 004h, 008h, 010h, 020h, 040h, 07Eh, 000h, 000h
   db 000h, 000h, 000h, 000h, 01Ch, 020h, 020h, 020h
   db 040h, 040h, 020h, 020h, 020h, 01Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 008h, 008h, 008h, 008h
   db 008h, 000h, 008h, 008h, 008h, 008h, 000h, 000h
   db 000h, 000h, 000h, 000h, 038h, 004h, 004h, 004h
   db 002h, 002h, 004h, 004h, 004h, 038h, 000h, 000h
   db 000h, 000h, 000h, 000h, 032h, 04Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 018h, 024h, 042h, 042h, 07Eh, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Ch, 042h, 040h, 040h
   db 040h, 040h, 040h, 042h, 03Ch, 040h, 040h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 042h
   db 000h, 042h, 042h, 042h, 042h, 03Dh, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 024h, 000h
   db 03Ch, 042h, 07Eh, 040h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 018h, 024h
   db 000h, 03Ch, 042h, 042h, 042h, 03Dh, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 024h
   db 000h, 03Ch, 042h, 042h, 042h, 03Dh, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 020h, 018h
   db 000h, 03Ch, 042h, 042h, 042h, 03Dh, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 010h, 028h, 010h
   db 000h, 03Ch, 042h, 042h, 042h, 03Dh, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 03Ch, 042h, 040h, 042h, 03Ch, 020h, 000h
   db 000h, 000h, 000h, 000h, 000h, 018h, 024h, 000h
   db 03Ch, 042h, 07Eh, 040h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 024h, 000h
   db 03Ch, 042h, 07Eh, 040h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 020h, 018h, 000h
   db 03Ch, 042h, 07Eh, 040h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 028h, 000h
   db 038h, 010h, 010h, 010h, 010h, 038h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 010h, 028h, 000h
   db 038h, 010h, 010h, 010h, 010h, 038h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 020h, 018h, 000h
   db 038h, 010h, 010h, 010h, 010h, 038h, 000h, 000h
   db 000h, 000h, 000h, 000h, 024h, 000h, 018h, 024h
   db 042h, 042h, 07Eh, 042h, 042h, 042h, 000h, 000h
   db 000h, 000h, 000h, 000h, 018h, 000h, 018h, 024h
   db 042h, 042h, 07Eh, 042h, 042h, 042h, 000h, 000h
   db 000h, 000h, 000h, 008h, 010h, 000h, 07Eh, 040h
   db 040h, 07Ch, 040h, 040h, 040h, 07Eh, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 0C0h
   db 036h, 049h, 049h, 076h, 003h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 01Eh, 028h, 048h, 048h
   db 07Eh, 048h, 048h, 048h, 048h, 04Eh, 000h, 000h
   db 000h, 000h, 000h, 018h, 024h, 000h, 03Ch, 042h
   db 042h, 042h, 042h, 042h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 024h, 000h, 03Ch, 042h
   db 042h, 042h, 042h, 042h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 020h, 018h, 000h, 03Ch, 042h
   db 042h, 042h, 042h, 042h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 018h, 024h
   db 000h, 042h, 042h, 042h, 042h, 03Dh, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 020h, 018h
   db 000h, 042h, 042h, 042h, 042h, 03Dh, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 042h, 000h
   db 042h, 042h, 042h, 042h, 03Eh, 002h, 002h, 004h
   db 000h, 000h, 000h, 000h, 024h, 000h, 03Ch, 042h
   db 042h, 042h, 042h, 042h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 042h, 000h, 042h, 042h
   db 042h, 042h, 042h, 042h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 010h, 03Ch
   db 052h, 050h, 050h, 052h, 03Ch, 010h, 000h, 000h
   db 000h, 000h, 000h, 000h, 01Ch, 022h, 020h, 020h
   db 020h, 020h, 020h, 020h, 042h, 0FEh, 000h, 000h
   db 000h, 000h, 000h, 000h, 081h, 042h, 024h, 018h
   db 0FFh, 010h, 0FFh, 010h, 010h, 010h, 000h, 000h
   db 000h, 000h, 000h, 000h, 0F0h, 088h, 088h, 088h
   db 0F0h, 080h, 088h, 09Ch, 088h, 088h, 000h, 000h
   db 000h, 000h, 000h, 000h, 00Ch, 012h, 010h, 010h
   db 038h, 010h, 010h, 010h, 090h, 060h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 008h, 030h, 000h
   db 03Ch, 042h, 042h, 042h, 042h, 03Dh, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 004h, 018h, 000h
   db 01Ch, 008h, 008h, 008h, 008h, 01Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 008h, 030h, 000h
   db 03Ch, 042h, 042h, 042h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 008h, 030h
   db 000h, 042h, 042h, 042h, 042h, 03Dh, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 014h, 028h, 000h
   db 0BCh, 042h, 042h, 042h, 042h, 042h, 000h, 000h
   db 000h, 000h, 000h, 000h, 028h, 014h, 042h, 042h
   db 062h, 052h, 04Ah, 046h, 042h, 042h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 03Ch, 042h, 03Dh, 000h, 07Eh, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 03Ch, 042h, 03Ch, 000h, 07Eh, 000h, 000h
   db 000h, 000h, 000h, 000h, 018h, 018h, 000h, 010h
   db 010h, 020h, 042h, 081h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 0FFh, 080h
   db 080h, 080h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 0FFh, 001h, 001h, 001h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 040h, 042h, 044h, 008h
   db 010h, 024h, 04Ah, 002h, 004h, 00Fh, 000h, 000h
   db 000h, 000h, 000h, 000h, 040h, 042h, 044h, 008h
   db 010h, 020h, 04Ah, 00Eh, 002h, 002h, 000h, 000h
   db 000h, 000h, 000h, 000h, 018h, 018h, 000h, 018h
   db 018h, 03Ch, 03Ch, 03Ch, 03Ch, 018h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 012h
   db 024h, 048h, 024h, 012h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 048h
   db 024h, 012h, 024h, 048h, 000h, 000h, 000h, 000h
   db 092h, 049h, 024h, 092h, 049h, 024h, 092h, 049h
   db 024h, 092h, 049h, 024h, 092h, 049h, 025h, 092h
   db 0AAh, 055h, 0AAh, 055h, 0AAh, 055h, 0AAh, 055h
   db 0AAh, 055h, 0AAh, 055h, 0AAh, 055h, 0AAh, 055h
   db 0DBh, 06Dh, 0B6h, 0DBh, 06Dh, 0B6h, 0DBh, 06Dh
   db 0B6h, 0DBh, 06Dh, 0B6h, 0DBh, 06Dh, 0B6h, 0DBh
   db 010h, 010h, 010h, 010h, 010h, 010h, 010h, 010h
   db 010h, 010h, 010h, 010h, 010h, 010h, 010h, 010h
   db 010h, 010h, 010h, 010h, 010h, 010h, 010h, 020h
   db 0C0h, 020h, 010h, 010h, 010h, 010h, 010h, 010h
   db 010h, 010h, 010h, 010h, 010h, 020h, 0E0h, 040h
   db 040h, 0C0h, 020h, 010h, 010h, 010h, 010h, 010h
   db 024h, 024h, 024h, 024h, 024h, 024h, 024h, 044h
   db 084h, 044h, 024h, 024h, 024h, 024h, 024h, 024h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 0F0h, 088h, 044h, 024h, 024h, 024h, 024h, 024h
   db 000h, 000h, 000h, 000h, 000h, 000h, 0C0h, 020h
   db 010h, 0D0h, 030h, 010h, 010h, 010h, 010h, 010h
   db 024h, 024h, 024h, 024h, 024h, 044h, 084h, 004h
   db 004h, 084h, 044h, 024h, 024h, 024h, 024h, 024h
   db 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h
   db 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h
   db 000h, 000h, 000h, 000h, 000h, 000h, 0F0h, 008h
   db 004h, 084h, 044h, 024h, 024h, 024h, 024h, 024h
   db 024h, 024h, 024h, 024h, 024h, 044h, 084h, 004h
   db 008h, 0F0h, 000h, 000h, 000h, 000h, 000h, 000h
   db 024h, 024h, 024h, 024h, 024h, 024h, 024h, 048h
   db 0F0h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 010h, 010h, 010h, 010h, 030h, 050h, 090h, 020h
   db 040h, 080h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 0C0h, 020h, 010h, 010h, 010h, 010h, 010h, 010h
   db 010h, 010h, 010h, 010h, 010h, 010h, 010h, 008h
   db 007h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 010h, 010h, 010h, 010h, 010h, 010h, 010h, 028h
   db 0C7h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 0C7h, 028h, 010h, 010h, 010h, 010h, 010h, 010h
   db 010h, 010h, 010h, 010h, 010h, 010h, 010h, 008h
   db 007h, 008h, 010h, 010h, 010h, 010h, 010h, 010h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 0FFh, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 010h, 010h, 010h, 010h, 010h, 010h, 028h, 044h
   db 083h, 044h, 028h, 010h, 010h, 010h, 010h, 010h
   db 010h, 010h, 010h, 010h, 010h, 008h, 007h, 004h
   db 007h, 008h, 010h, 010h, 010h, 010h, 010h, 010h
   db 024h, 024h, 024h, 024h, 024h, 024h, 024h, 022h
   db 021h, 022h, 024h, 024h, 024h, 024h, 024h, 024h
   db 024h, 024h, 024h, 024h, 024h, 022h, 021h, 020h
   db 010h, 00Fh, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 00Fh, 010h
   db 020h, 021h, 022h, 024h, 024h, 024h, 024h, 024h
   db 024h, 024h, 024h, 024h, 024h, 042h, 081h, 000h
   db 000h, 0FFh, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 0FFh, 000h
   db 000h, 081h, 042h, 024h, 024h, 024h, 024h, 024h
   db 024h, 024h, 024h, 024h, 024h, 022h, 021h, 020h
   db 020h, 021h, 022h, 024h, 024h, 024h, 024h, 024h
   db 000h, 000h, 000h, 000h, 000h, 000h, 0FFh, 000h
   db 000h, 0FFh, 000h, 000h, 000h, 000h, 000h, 000h
   db 024h, 024h, 024h, 024h, 024h, 042h, 081h, 000h
   db 000h, 081h, 042h, 024h, 024h, 024h, 024h, 024h
   db 010h, 010h, 010h, 010h, 010h, 028h, 0C7h, 000h
   db 000h, 0FFh, 000h, 000h, 000h, 000h, 000h, 000h
   db 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h
   db 0FFh, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 0FFh, 000h
   db 000h, 0C7h, 028h, 010h, 010h, 010h, 010h, 010h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 0FFh, 024h, 024h, 024h, 024h, 024h, 024h, 024h
   db 024h, 024h, 024h, 024h, 024h, 024h, 024h, 012h
   db 00Fh, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 010h, 010h, 010h, 010h, 010h, 018h, 017h, 010h
   db 008h, 007h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 007h, 008h
   db 010h, 017h, 018h, 010h, 010h, 010h, 010h, 010h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 00Fh, 012h, 024h, 024h, 024h, 024h, 024h, 024h
   db 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h
   db 0FFh, 024h, 024h, 024h, 024h, 024h, 024h, 024h
   db 010h, 010h, 010h, 010h, 010h, 010h, 0FFh, 010h
   db 010h, 0FFh, 010h, 010h, 010h, 010h, 010h, 010h
   db 010h, 010h, 010h, 010h, 010h, 010h, 010h, 020h
   db 0C0h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 007h, 008h, 010h, 010h, 010h, 010h, 010h, 010h
   db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
   db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
   db 0F0h, 0F0h, 0F0h, 0F0h, 0F0h, 0F0h, 0F0h, 0F0h
   db 0F0h, 0F0h, 0F0h, 0F0h, 0F0h, 0F0h, 0F0h, 0F0h
   db 00Fh, 00Fh, 00Fh, 00Fh, 00Fh, 00Fh, 00Fh, 00Fh
   db 00Fh, 00Fh, 00Fh, 00Fh, 00Fh, 00Fh, 00Fh, 00Fh
   db 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh, 0FFh
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 038h, 049h, 08Ah, 08Ch
   db 088h, 088h, 08Ch, 08Ah, 049h, 038h, 000h, 000h
   db 000h, 000h, 000h, 000h, 078h, 084h, 084h, 084h
   db 088h, 090h, 088h, 084h, 082h, 082h, 000h, 000h
   db 000h, 000h, 000h, 000h, 0FFh, 081h, 081h, 080h
   db 080h, 080h, 080h, 080h, 080h, 080h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 0FCh, 04Ah
   db 048h, 048h, 048h, 048h, 048h, 086h, 000h, 000h
   db 000h, 000h, 000h, 000h, 0FFh, 081h, 040h, 020h
   db 010h, 010h, 020h, 040h, 081h, 0FFh, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 03Fh, 042h
   db 042h, 042h, 042h, 042h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 042h, 042h
   db 042h, 062h, 05Ch, 040h, 040h, 080h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 01Ah, 034h
   db 050h, 010h, 010h, 010h, 010h, 010h, 000h, 000h
   db 000h, 000h, 000h, 000h, 0FFh, 010h, 010h, 028h
   db 044h, 044h, 028h, 010h, 010h, 0FFh, 000h, 000h
   db 000h, 000h, 000h, 000h, 018h, 024h, 042h, 0C3h
   db 0C3h, 0FFh, 0C3h, 042h, 024h, 018h, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Ch, 042h, 081h, 081h
   db 081h, 081h, 081h, 042h, 024h, 0E7h, 000h, 000h
   db 000h, 000h, 000h, 000h, 07Eh, 080h, 070h, 008h
   db 03Ch, 042h, 081h, 081h, 042h, 03Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 076h
   db 089h, 089h, 076h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 001h, 03Eh, 046h, 089h
   db 089h, 091h, 062h, 07Ch, 080h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 00Ch, 010h, 020h, 020h
   db 03Ch, 020h, 020h, 020h, 010h, 00Ch, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Ch, 042h, 081h, 081h
   db 081h, 081h, 081h, 081h, 081h, 081h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 0FFh
   db 000h, 0FFh, 000h, 0FFh, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 010h, 010h, 07Ch
   db 010h, 010h, 000h, 07Ch, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 020h, 010h, 008h, 004h
   db 004h, 008h, 010h, 020h, 000h, 07Eh, 000h, 000h
   db 000h, 000h, 000h, 000h, 004h, 008h, 010h, 020h
   db 020h, 010h, 008h, 004h, 000h, 07Eh, 000h, 000h
   db 000h, 000h, 000h, 000h, 00Eh, 011h, 010h, 010h
   db 010h, 010h, 010h, 010h, 010h, 010h, 000h, 000h
   db 000h, 000h, 000h, 000h, 008h, 008h, 008h, 008h
   db 008h, 008h, 008h, 088h, 088h, 070h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 018h
   db 000h, 07Eh, 000h, 018h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 088h
   db 055h, 022h, 088h, 055h, 022h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 03Ch, 042h, 03Ch, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 018h, 018h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 010h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 00Fh, 008h, 008h, 008h
   db 008h, 0C8h, 028h, 018h, 008h, 000h, 000h, 000h
   db 0B8h, 044h, 044h, 044h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 038h, 044h, 008h, 010h, 07Ch, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 03Ch, 03Ch
   db 03Ch, 03Ch, 03Ch, 03Ch, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
   db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
  
%endif
