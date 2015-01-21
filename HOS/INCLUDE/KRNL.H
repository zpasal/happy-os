/*
 * krnl.h
 *
 * HappyOS specific kernel function for setup HappyOS kernel.
 * Not standard header.
 *
 * Copyrigh (C) HAppyOS 2003
 *						Last Revision:08.03.2003
 */


#ifndef __KRNL_H
#define __KRNL_H

#define FLAT_CODE_SEGMENT 0x18
#define FLAT_DATA_SEGMENT 0x20

#define DESCRIPTOR_CODE_DPL0 0x18
#define DESCRIPTOR_DATA_DPL0 0x20
#define DESCRIPTOR_CODE_DPL3 0x08
#define DESCRIPTOR_DATA_DPL3 0x10


void k_set_interrupts(void);

#endif
