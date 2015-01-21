#ifndef __MMU_H
#define __MMU_H

#include <types.h>

#define PAGE_PRESENT   0x01
#define PAGE_WRITE     0x02
#define PAGE_SUPERUSER 0x04
#define PAGE_ACCESSED  0x20
#define PAGE_DIRTY     0x40


extern unsigned int *page_directory;
extern unsigned int *heap_page_table;
extern int           heap_top;
extern void         *dma_buffer;

void init_memory();

#endif
