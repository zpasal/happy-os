/*
 * 386 module
 *
 * Specific functions and structures form 386+ family.
 * Not standard.
 *
 * Copyright (C) HappyOS 2003
 *						Last Revision:08.03.2003
 */


#ifndef __386_H
#include <386.h>
#endif


void outportb(unsigned short portid, unsigned char val) {
  asm {
      mov dx, [portid]
      mov al, [val]
      out dx, al
  }
}

void outport(unsigned short portid, unsigned short val) {
   asm {
      mov dx, [portid]
      mov ax, [val]
      out dx, ax
   }
}

#pragma warn -ret
unsigned char inportb(unsigned short portid) {
     asm mov dx, [portid]
     asm in al, dx
}

#pragma warn -ret
unsigned short inport(unsigned short portid) {
     asm mov dx, [portid]
     asm in ax, dx
}

void disable(void) {
     asm cli
}

void enable(void) {
     asm sti
}

void set_idt_entry(IDT *item, unsigned short selector, unsigned offset,
                   unsigned char access, unsigned char param_cnt)
{
  item->selector = selector;
  item->offset_l = offset & 0xFFFF;
  item->offset_h = offset >> 16;
  item->access = access;
  item->param_cnt = param_cnt;
}

void set_gdt_entry(GDT *item, unsigned base, unsigned limit, unsigned char access,
                   unsigned char attribs) {
  item->base_l = base & 0xFFFF;
  item->base_m = (base >> 16) & 0xFF;
  item->base_h = base >> 24;
  item->limit = limit & 0xFFFF;
  item->attribs = attribs | ((limit >> 16) & 0x0F);
  item->access = access;
}

void k_set_pic(unsigned char master_vector, unsigned char slave_vector) {
  outportb (PORT_8259M, 0x11);   /* inicijalizacija 8259 */
  outportb (PORT_8259S, 0x11);
  outportb (PORT_8259M+1, master_vector);  /* master base interrupt vector */
  outportb (PORT_8259S+1, slave_vector);   /* slave base interrupt vector */
  outportb (PORT_8259M+1, 1<<2);           /* cascade na IRQ2 */
  outportb (PORT_8259S+1, 2);              /* cascade na IRQ2 */
  outportb (PORT_8259M+1, 1);              
  outportb (PORT_8259S+1, 1);
}

unsigned char read_cmos(int offset) {
    outportb(0x70, offset); 
    asm nop
return inportb(0x71);
    
}