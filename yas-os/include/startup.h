#ifndef __STARTUP_H
#define __STARTUP_H

#define KERNEL_CODE_SELECTOR 0x18
#define KERNEL_DATA_SELECTOR 0x10

typedef struct
{
	unsigned int access_byte;
	unsigned int eip;
} t_vector;


extern void * _idt_table;
extern unsigned int _kernel_size;
extern unsigned int _mem_lower;
extern unsigned int _mem_upper;
extern unsigned int _boot_device;
extern unsigned int _text_start;
extern unsigned int _data_start;
extern unsigned int _bss_start;
extern char *       _cmd_line;

void setvect(t_vector *t, unsigned int intno);
void getvect(t_vector *t, unsigned int intno);


#endif
