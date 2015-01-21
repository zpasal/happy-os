#ifndef __FLOPPY_H
#define __FLOPPY_H

/*
  U zavisnosti od floppy-a sva polja iz donje strukture imaju
  druge vrijednosti. Procitati iz /hos/drv/floppy tekstualnog
  fajla.
*/
typedef struct _DPT_
{
  unsigned char srt_hut;
  unsigned char dma_hlt;
  unsigned char motor_w;
  unsigned char sec_size;
  unsigned char eot;
  unsigned char gap_rw;
  unsigned char dtl;
  unsigned char gap_f;
  unsigned char fill_char;
  unsigned char hst;
  unsigned char mot_start;
} DPT;



// za koliko se _tikova_ ugasi floppy motor
#define FLOPPY_OFF 80

// registri Floppy Controllera
#define STATUSA    0x3F0
#define STATUSB    0x3F1
#define DOR        0x3F2
#define MAINSTATUS 0x3F4
#define DATARATE   0x3F4
#define STATUSREG  0x3F5
#define COMMAND    0x3F5
#define CONFIG     0x3F7

// komande Floppy Controllera
#define C_READTRCK  0x02
#define C_SPECIFY   0x03
#define C_DRIVESTAT 0x04
#define C_WRITE     0x05
#define C_READ      0x06
#define C_RCLB      0x07
#define C_INTSTAT   0x08
#define C_WDELDAT   0x09
#define C_ID        0x0A
#define C_RDELDAT   0x0C
#define C_FORMTRCK  0x0D
#define C_SEEK      0x0F
#define C_VERIFY    0x16

void wait_for_irq6(void);
void init_floppy_dma(void);
void fdc_command(unsigned char command);
int  fdc_status(void);
int  read_sectors(int drive, int head, int track, int sector, void *buffer);


#endif