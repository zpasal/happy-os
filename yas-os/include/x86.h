#ifndef __X86_H
#define __X86_H

#define RESET_8259()  outportb(0x20,0x20)

#define IDT_INTERRUPT_GATE  0x0E
#define IDT_PRESENT         0x80
#define IDT_KERNEL          (IDT_INTERRUPT_GATE | IDT_PRESENT)

unsigned inportb(unsigned short port);
void outportb(unsigned port, unsigned val);
unsigned disable();
void enable();

#endif
