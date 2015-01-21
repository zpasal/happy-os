#ifndef __FLOPPY_H
#include <floppy.h>
#endif

#ifndef __386_H
#include <386.h>
#endif

#ifndef __STRING_H
#include <string.h>
#endif

// _dekomentarisati_ ovo za normalni rad
#define _FDCDEBUG_

#ifdef _FDCDEBUG_
#ifndef __CONIO_H
#include <conio.h>
#endif
#endif


extern void delay(unsigned ms);   /* iz kernel.c */

char *fdc_errors[20] = {
     "OK",
     "FDC - Command terminated abnormali!",
     "FDC - Invalid command!",
     "FDC - Command aborted by ready change signal!",
     "FDC - Fault status signal!",
     "FDC - No diskette in drive!",
     "FDC - End of cilnder!",
     "FDC - CRC error in ID or data!",
     "FDC - Overrun!",
     "FDC - Sector ID not found!",
     "FDC - Write protected!",
     "FDC - ID address mark not found!",
     "FDC - Deleted data address mark detected!",
     "FDC - CRC error in data!",
     "FDC - Wrong cylinder detected!",
     "FDC - Scan command failed!",
     "FDC - Bad cylinder, ID not found!",
     "FDC - Missing data address mark!",
     "FDC - Unknown error!",
     "FDC - Diskette controller is busy"
};

int _floppy_shutoff;
char *_floppy_area;
int _irq6 = 0;


int read_sectors(int drive, int head, int track, int sector, void *buffer) {
unsigned char hd, b0, b1, b2, b3, b4, b5, b6;
int err=0;
    hd = (head << 2) | drive;
    outportb(DOR, 0x1C); // motor0 on + DMA + FDC enable + floppy 0
    delay(20);
    b0 = inportb(MAINSTATUS);  // greske ????
#ifdef _FDCDEBUG_
    cprintf("Motor ON. Status: %02X\n\r", b0);
#endif
    if (b0 & 0x10) { err = 19; goto greska; } // FDC busy

    fdc_command(C_RCLB);
    fdc_command(drive);
    wait_for_irq6();

    fdc_command(C_SEEK);
    fdc_command(hd);   // 00000hdd
    fdc_command(track);
    delay(8);
    b0=inportb(MAINSTATUS); // greske ????
    if (!(b0 & 0x80)) { err = 18; goto greska; } // unknown error ???
#ifdef _FDCDEBUG_
    cprintf("Seeking... Status: %02X\n\r", b0);
#endif
    wait_for_irq6();

    fdc_command(C_INTSTAT);
    b0 = fdc_status();
    b1 = fdc_status();
    if (b0 & 0xC0) { err = b0>>6; goto greska; } // 01, 10, 11
#ifdef _FDCDEBUG_
    cprintf("ST0: %02X\n\r", b0);
    cprintf("PNC: %02X\n\r", b1);
#endif

    fdc_command(C_DRIVESTAT);
    fdc_command(hd);  // param 1: 00000hdd  h-head dd-drive
    b0 = fdc_status();
    if (b0 & 0x80) {
        err = 4;  // fault status signal
        goto greska;
    } else if (b0 & 0x40) {
        err = 5; // Write protect status
        goto greska;
    }
#ifdef _FDCDEBUG_
    cprintf("ST3: %02X\n\r", b0);
#endif

    outportb(CONFIG, 0); // na 500KB/sec
    init_floppy_dma();

    fdc_command(C_READ | 0x60);
    fdc_command(hd);   // param 1: 00000hdd  h-head dd-drive
    fdc_command(track);   // param 2: track number
    fdc_command(head);   // param 3: head number
    fdc_command(sector);   // param 4: sector number
    fdc_command(2); // param 5: sector size
    fdc_command(18);  // param 6: end of track (sec per track)
    fdc_command(27); // param 7: gap length
    fdc_command(255);    // param 8: data length
    wait_for_irq6();

    b0 = fdc_status();
    b1 = fdc_status();
    b2 = fdc_status();
    b3 = fdc_status();
    b4 = fdc_status();
    b5 = fdc_status();
    b6 = fdc_status();
#ifdef __FDCDEBUG_
    cprintf("ST0: %02X\n\r", b0);
    cprintf("ST1: %02X\n\r", b1);
    cprintf("ST2: %02X\n\r", b2);
    cprintf("Cilinder no: %02X\n\r", b3);
    cprintf("Head no:     %02X\n\r", b4);
    cprintf("Sector no:   %02X\n\r", b5);
    cprintf("BPS:         %02X\n\r", b6);
#endif
    if (b0 & 0xC0) { err = b0>>6; goto greska; }
    if (b1) {
        if (b1 & 0x80) {err = 6; goto greska; } // end of cilinder
        else if (b1 & 0x20) {err = 7; goto greska; } // crc error
        else if (b1 & 0x10) {err = 8; goto greska; } // overrun
        else if (b1 & 0x04) {err = 9; goto greska; } // sector not found
        else if (b1 & 0x02) {err = 10; goto greska;} // write protect
        else if (b1 & 0x01) {err = 11; goto greska;} // mark not found
    }
    if (b2) {
        if (b2 & 0x40) {err = 12; goto greska; } // deleted address finded
        else if (b2 & 0x20) {err = 13; goto greska; } // crc error
        else if (b2 & 0x10) {err = 14; goto greska; } // wrong cilinder detected
        else if (b2 & 0x04) {err = 15; goto greska; } // scan failed
        else if (b2 & 0x02) {err = 16; goto greska; } // bad cilinder
        else if (b2 & 0x01) {err = 17; goto greska; } // missing data address mark
    }
    memcpy(buffer, _floppy_area, 512);
greska:
    _floppy_shutoff = FLOPPY_OFF;
return err;
}


void init_floppy_dma(void) {
        asm cli
        asm mov al, 0x46 // single mode + addr inc + to memory + ch 2
        asm out 0x0C, al
        asm out 0x0B, al

        asm mov ax,  0x4000
        asm out 0x04, al  // DMA ch2 lov & high bytes for base address
        asm mov al, ah
        asm out 0x04, al

        asm xor ax, ax
        asm out 0x81, al // ch2 page address

        asm mov ax, 511   // duzina u bajtovima (0 bazirana)
        asm out 0x05, al  // DMA ch2 low & high for count
        asm mov al, ah
        asm out 0x05, al

        asm mov al, 2     // enable mask + ch2
        asm out 0x0A, al
        asm sti
}




void fdc_command(unsigned char command) {
     while(!(inportb(MAINSTATUS) & 0x80));
     outportb(COMMAND, command);
}

int fdc_status(void) {
    while(!(inportb(MAINSTATUS) & 0x80));
return inportb(STATUSREG);
}


void wait_for_irq6() {
     while(_irq6 == 0);
     _irq6 = 0;
}

