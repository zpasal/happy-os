/*
 *  386.h
 *
 *  Specific 386+ Processor formats and functions.
 *  Not standard header file.
 *
 *  Copyright (C) HappyOS 2003
 *						Last Revision:08.03.2003
 */


#ifndef __386_H
#define __386_H


#define PORT_8259M      0x20
#define PORT_8259S      0xA0
#define PORT_KBD_A      0x60
#define EOI             0x20

#define ACS_PRESENT     0x80            /* present segment */
#define ACS_CSEG        0x18            /* code segment */
#define ACS_DSEG        0x10            /* data segment */
#define ACS_CONFORM     0x04            /* conforming segment */
#define ACS_READ        0x02            /* readable segment */
#define ACS_WRITE       0x02            /* writable segment */
#define ACS_IDT         ACS_DSEG        /* segment type is the same type */
#define ACS_INT_GATE    0x0E            /* int gate for 386 */
#define ACS_INT         (ACS_PRESENT | ACS_INT_GATE) /* present int gate */

#define ACS_DPL_0       0x00            /* descriptor privilege level #0 */
#define ACS_DPL_1       0x20            /* descriptor privilege level #1 */
#define ACS_DPL_2       0x40            /* descriptor privilege level #2 */
#define ACS_DPL_3       0x60            /* descriptor privilege level #3 */

#define ATTR_GRANULARITY 0x80           /* segment limit is given in 4KB pages rather than in bytes */
#define ATTR_BIG         0x40           /* ESP is used rather than SP */
#define ATTR_DEFAULT     0x40           /* 32-bit code segment rather than 16-bit */

/* Ready-made values */
#define ACS_CODE        (ACS_PRESENT | ACS_CSEG | ACS_READ)
#define ACS_DATA        (ACS_PRESENT | ACS_DSEG | ACS_WRITE)
#define ACS_STACK       (ACS_PRESENT | ACS_DSEG | ACS_WRITE)

/*  GDT, GDTR, IDT, IDTR structs      */
#pragma packed
typedef struct {
  unsigned short limit, base_l;
  unsigned char base_m, access, attribs, base_h;
} GDT;

typedef struct {
  unsigned short limit;
  unsigned base;
} GDTR;

typedef struct {
  unsigned short offset_l, selector;
  unsigned char param_cnt, access;
  unsigned short offset_h;
} IDT;

typedef struct {
  unsigned short limit;
  unsigned base;
} IDTR;
#pragma unpacked



void outportb(unsigned short portid, unsigned char val);
void outport(unsigned short, unsigned short val);
unsigned char inportb(unsigned short portid);
unsigned short inport(unsigned short portid);
void disable(void);
void enable(void);
unsigned char read_cmos(int offset);
void set_idt_entry(IDT *item, unsigned short selector, unsigned offset,
                   unsigned char access, unsigned char param_cnt);
void set_gdt_entry(GDT *item, unsigned base, unsigned limit, unsigned char access,
                   unsigned char attribs);



#endif