/*
 * krnl module
 *
 * HappyOS's functions for prepering memory, interrupts, etc.
 * Not standard.
 *
 * Copyright (C) HappyOS 2003
 *						Last Revision:08.03.2003
 */

#ifndef __KRNL_H
#include <krnl.h>
#endif

#ifndef __386_H
#include <386.h>
#endif

#ifndef __INTWRAP_H
#include <intwrap.h>
#endif

IDT idt[0x31];
IDTR idtr;

void k_set_interrupts(void) {
unsigned *wrapp_ptr[0x30];
int i;
     wrapp_ptr[0] = &interrupt_wrapper00;   wrapp_ptr[1] = &interrupt_wrapper01;
     wrapp_ptr[2] = &interrupt_wrapper02;   wrapp_ptr[3] = &interrupt_wrapper03;
     wrapp_ptr[4] = &interrupt_wrapper04;   wrapp_ptr[5] = &interrupt_wrapper05;
     wrapp_ptr[6] = &interrupt_wrapper06;   wrapp_ptr[7] = &interrupt_wrapper07;
     wrapp_ptr[8] = &interrupt_wrapper08;   wrapp_ptr[9] = &interrupt_wrapper09;
     wrapp_ptr[10] = &interrupt_wrapper0A;  wrapp_ptr[11] = &interrupt_wrapper0B;
     wrapp_ptr[12] = &interrupt_wrapper0C;  wrapp_ptr[13] = &interrupt_wrapper0D;
     wrapp_ptr[14] = &interrupt_wrapper0E;  wrapp_ptr[15] = &interrupt_wrapper0F;
     wrapp_ptr[16] = &interrupt_wrapper10;  wrapp_ptr[17] = &interrupt_wrapper11;
     wrapp_ptr[18] = &interrupt_wrapper12;  wrapp_ptr[19] = &interrupt_wrapper13;
     wrapp_ptr[20] = &interrupt_wrapper14;  wrapp_ptr[21] = &interrupt_wrapper15;
     wrapp_ptr[22] = &interrupt_wrapper16;  wrapp_ptr[23] = &interrupt_wrapper17;
     wrapp_ptr[24] = &interrupt_wrapper18;  wrapp_ptr[25] = &interrupt_wrapper19;
     wrapp_ptr[26] = &interrupt_wrapper1A;  wrapp_ptr[27] = &interrupt_wrapper1B;
     wrapp_ptr[28] = &interrupt_wrapper1C;  wrapp_ptr[29] = &interrupt_wrapper1D;
     wrapp_ptr[30] = &interrupt_wrapper1E;  wrapp_ptr[31] = &interrupt_wrapper1F;
     wrapp_ptr[32] = &interrupt_wrapper20;  wrapp_ptr[33] = &interrupt_wrapper21;
     wrapp_ptr[34] = &interrupt_wrapper22;  wrapp_ptr[35] = &interrupt_wrapper23;
     wrapp_ptr[36] = &interrupt_wrapper24;  wrapp_ptr[37] = &interrupt_wrapper25;
     wrapp_ptr[38] = &interrupt_wrapper26;  wrapp_ptr[39] = &interrupt_wrapper27;
     wrapp_ptr[40] = &interrupt_wrapper28;  wrapp_ptr[41] = &interrupt_wrapper29;
     wrapp_ptr[42] = &interrupt_wrapper2A;  wrapp_ptr[43] = &interrupt_wrapper2B;
     wrapp_ptr[44] = &interrupt_wrapper2C;  wrapp_ptr[45] = &interrupt_wrapper2D;
     wrapp_ptr[46] = &interrupt_wrapper2E;  wrapp_ptr[47] = &interrupt_wrapper2F;
     wrapp_ptr[48] = &interrupt_wrapper30;
     for(i=0; i<0x31; i++)
       set_idt_entry(&idt[i], FLAT_CODE_SEGMENT, wrapp_ptr[i], ACS_INT, 0);
     idtr.base = &idt;        // 0x00100000 fiz == 0xC0000000 virt
     idtr.limit = 8*0x31;
     set_idtr();
}

