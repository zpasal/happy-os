/*
 * intwrap.h
 *
 * 386+ interrupt tables and some specific functions from intwrap.asm
 * Not standard header.
 *
 * Copyrigh (C) HappyOS 2003
 *						Last Revision:08.03.2003
 */


#ifndef __INTWRAP_H
#define __INTWRAP_H

extern void interrupt_wrapper00(void);
extern void interrupt_wrapper01(void);
extern void interrupt_wrapper02(void);
extern void interrupt_wrapper03(void);
extern void interrupt_wrapper04(void);
extern void interrupt_wrapper05(void);
extern void interrupt_wrapper06(void);
extern void interrupt_wrapper07(void);
extern void interrupt_wrapper08(void);
extern void interrupt_wrapper09(void);
extern void interrupt_wrapper0A(void);
extern void interrupt_wrapper0B(void);
extern void interrupt_wrapper0C(void);
extern void interrupt_wrapper0D(void);
extern void interrupt_wrapper0E(void);
extern void interrupt_wrapper0F(void);
extern void interrupt_wrapper10(void);
extern void interrupt_wrapper11(void);
extern void interrupt_wrapper12(void);
extern void interrupt_wrapper13(void);
extern void interrupt_wrapper14(void);
extern void interrupt_wrapper15(void);
extern void interrupt_wrapper16(void);
extern void interrupt_wrapper17(void);
extern void interrupt_wrapper18(void);
extern void interrupt_wrapper19(void);
extern void interrupt_wrapper1A(void);
extern void interrupt_wrapper1B(void);
extern void interrupt_wrapper1C(void);
extern void interrupt_wrapper1D(void);
extern void interrupt_wrapper1E(void);
extern void interrupt_wrapper1F(void);
extern void interrupt_wrapper20(void);
extern void interrupt_wrapper21(void);
extern void interrupt_wrapper22(void);
extern void interrupt_wrapper23(void);
extern void interrupt_wrapper24(void);
extern void interrupt_wrapper25(void);
extern void interrupt_wrapper26(void);
extern void interrupt_wrapper27(void);
extern void interrupt_wrapper28(void);
extern void interrupt_wrapper29(void);
extern void interrupt_wrapper2A(void);
extern void interrupt_wrapper2B(void);
extern void interrupt_wrapper2C(void);
extern void interrupt_wrapper2D(void);
extern void interrupt_wrapper2E(void);
extern void interrupt_wrapper2F(void);
extern void interrupt_wrapper30(void);
extern set_idtr(void);
extern _set_cr3(void);
extern void _hard_reboot(void);
extern void _flush_gdtr(void);

#endif