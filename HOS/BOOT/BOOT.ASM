[SECTION .text]


%define BOOT_ADDRESS 0x7C00
%define FAT_ADDRESS  0x2000
%define ROOT_ADDRESS 0x3000
%define CODE_ADDRESS 0x4000

%define ENABLE_A20

        org BOOT_ADDRESS
start:  jmp short boot
        nop     

        ;  data below are not written, just for test
	db 'HOS2.1.1'
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
        times 0x3B-27 db 0

boot:   
        cli            ; stop interrupts for sake of stack settings
        mov ax, cs
        mov ds, ax
        mov ss, ax
        mov sp, BOOT_ADDRESS - 4   ; stack -> before boot 
        sti

        mov di, msg_started
        call prints

;Enable A20
%ifdef ENABLE_A20
a20_1:
        in	al, 0x64		
	test	al, 2
	jnz	a20_1
	mov	al, 0D1h
	out	0x64, al
a20_2:	in	al, 0x64
	and	ax, byte 2
	jnz	a20_2
	mov	al, 0DFh
	out	0x60, al
%endif

        ; load FAT table
        mov ax, FAT_ADDRESS
        mov es, ax
        mov ax, [res]  ; find FAT (hidden sectors + reserved sectors)
        add ax, [hid]
        mov cx, [spf]  ; number of sectors inside FAT
        call read_sectors

        ; load ROOT dir
        mov ax, ROOT_ADDRESS
        mov es, ax
       ;ROOT=number of fats*Sec per FAT + reserved sectors
        xor ax, ax
        mov al, [fno]
        mul word [spf]
        mov [fatno_mul_spf], ax
        add ax, [res]  ; AX = LBA ROOT folder
        mov cx, [rot]  ; number of sectors via entries
        dec cx         ; number of sectors = (rot - 1)/16 + 1
        shr cx, 4
        inc cx
        mov [dir_sectors], cx
        call read_sectors


        ; search for PREKRNL.BIN 
        mov bx, [rot]        ; number of entries to search
        mov ax, ROOT_ADDRESS
        mov es, ax
        xor di, di   ; ES:DI -> start search
        xor cx, cx
search:
        mov si, file_to_load  ; DS:SI -> compare to
        mov cl, 11
        cld
        rep cmpsb
        je loader_find   ; search for file
        add cl, 21
        add di, cx
        dec bx
        jnz search
        ; if all entries are searched => ERROR  system not exists
error:
        mov di, msg_nosystem
        call prints
        jmp $


loader_find:
        mov cx, [es:di+0x0F]  ; starting cluster
 
        mov ax, CODE_ADDRESS
        mov es, ax

read_next:
        push cx

        ; sec = hid+res+(number of FATs*spf)+direntrysec+(LBA-2)*(spc(=1))
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


        ;  AX  = LBA cluster
        mov cx, 1         ; first sector
        call read_sectors        
        pop ax
        call next_cluster
        cmp ax, 0xFF8
        jae zadnji_cluster

        mov cx, ax
        jmp read_next

zadnji_cluster:
	db 0xEA                  ; far jump to start of prekrnl.bin-a - manual opcode
        dw 0, CODE_ADDRESS

; convert_lba - convert logical sector in head, track and sector
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


; read_sectors - read sector via LBA
; INPUT: AX - LBA
;        CX - how many sectors
;        ES - where
read_sectors:

          or cx, cx        ; loaded all?
          jz kraj_citanja
          push cx
          push ax

          call convert_lba
          mov dh, bh   ; head
          xor dl, dl   ; drive  [floppy - 00]
          mov cl, bl   ; sector
          mov ch, al   ; track
          mov al, 1    ; one sector to read
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
          mov di, msg_diskerror
          call prints
          jmp $

; next_cluster - calc next cluster
; INPUT : AX  pocetni cluster (LBA)
; OUTPUT: AX  slijedeci cluster (LBA)
next_cluster:
     push es
     push ebx
     push ax      ; save LBA
     mov bx, 3
     mul bx
     shr ax, 1    ; index inside FAT = (LBA * 3) / 2
     mov bx, FAT_ADDRESS
     mov es, bx
     mov bx, ax
     mov ax, [es:bx] ; get word form index from FAT-
     pop bx          ; LBA -> BX
     test bx, 1
     jz paran        ; if odd => keep lower 12 bits
     shr ax, 4       ; if not, upper 12
paran:
     and ax, 0xFFF
     pop ebx
     pop es
     retn

; puts - print ASCII
; INPUT - DI pointer to string
;
prints:
     push ax
     push bx
     mov ah, 0x0E
     xor bx, bx
ploop:
     mov al, [cs:di]
     or al, al
     jz endloop
     int 0x10
     inc di
     jmp ploop
endloop:
     pop bx
     pop ax
     retn


file_to_load  db 'PREKRNL BIN'
fatno_mul_spf dw 0
dir_sectors   dw 0
msg_started   db 'Boot loader v2.1 started.',10,13,0
msg_nosystem  db 'System not found!',0
msg_diskerror db 'Disk error!', 0

	 times 510-($-$$) db 0
	 db 0x55, 0xAA
