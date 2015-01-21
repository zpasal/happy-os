/*
 * malloc.h
 *
 * Header file for memory alocating. Only malloc & free are implemented,
 * because this functions use only kernel. Other apllications must
 * use another malloc & free functions.
 *
 * Copyright (C) HappyOS 2003
 *                                          Last Revision: 03.03.2003
 */

#ifndef __MALLOC_H
#define __MALLOC_H

#define PAGE_DIR_ADDRESS (0x00000000)
#define PAGE_TAB_ADDRESS (PAGE_DIR_ADDRESS+4096)
#define PAGE_TAB_KRNL  (PAGE_TAB_ADDRESS+4096)
#define PAGE_TAB_HEAP  (PAGE_TAB_KRNL+4096)

#define MALLOC_MAGIC 0xFFFFFF00
#define MALLOC_USED  0x01
#define MALLOC_FREE  0x00

#define NULL (void*)0x00000000

typedef unsigned size_t;

#pragma packed
typedef struct {
        unsigned size;          /* block size */
        void*    next;          /* next mcb */
        unsigned used;          /* Used 1, not used 0 + MAGIC 0xFFFFFF00 */
} malloc_block;
#pragma unpacked


void* sbrk(size_t s);
void* malloc(size_t s);
int   free(void *ptr);

#endif
