/* 
 * malloc module
 *
 * Memory menagement for kernel use only. This functions are compatibile
 * with standard C malloc/free. Only malloc and free are implemented,
 * becuase applications must have other <malloc.h> 
 *
 * TO DO: - implemente code in 'free' that resize two MCBs if they are
 *          one to other ?!?!?! 
 *        - 'realloc'
 *
 * Copyright (C) HappyOS 2003
 *
 *						Last Revision:08.03.2003
 */

#ifndef __MALLOC_H
#include <malloc.h>
#endif

#ifndef __MEMBMP_H
#include <membmp.h>
#endif

extern void _set_cr3(void);    /* intwrap.asm */

unsigned *page_directory;
unsigned *page_table;
unsigned *page_krnl;
unsigned *page_heap;

unsigned char* heap_start;
unsigned char* heap_end;
int page_index;


void* sbrk(size_t s) {
int pages = (s+4095) / 4096;
unsigned ph;
void *tmpptr;
malloc_block* mb=(malloc_block*)heap_start;
      if (s==0) return NULL;
      while(mb->next != NULL)
            mb = mb->next;
      while(pages--) {
            ph = (unsigned)allocate_page();
            if (ph == 0x00000000UL) {
                return NULL;
            }
            page_heap[page_index] = (ph | 7);
            page_index++;
	    heap_end+=4096;
      }
 //     _set_cr3();
return mb;
}


void* malloc(size_t s) {
malloc_block *mblock, *retval;
void *ptr;
      if (s == 0) return NULL;
      mblock = (malloc_block*)heap_start;

      /* searching mcb chain for "FIRST FIT" */
      do {
          if ((mblock->size >= s) && !(mblock->used & MALLOC_USED))
               goto bingo_cell;  /* cell is big enough */
          mblock = mblock->next;
      } while(mblock->next != NULL);
      if ((mblock->size >= s) && !(mblock->used & MALLOC_USED))
           goto bingo_cell;

more_core:;
      /* if there is not enough free space we must call k_sbrk */
      /* to make heap biger. If k_sbrk return NULL - not enough memory */
      ptr = sbrk(s + sizeof(malloc_block));
      if (ptr == NULL)
          return NULL;
      ptr = mblock;    /* for later : ptr = last MCB */
      mblock->size = s;
      mblock->next = (char*)mblock + s + sizeof(malloc_block);
      mblock->used = MALLOC_MAGIC | MALLOC_USED;
      retval = mblock;
      mblock = mblock->next; /* go to next MCB  */
      mblock->used = MALLOC_MAGIC;   /* free memory block */
      mblock->next = NULL;
      mblock->size = (char*)((char*)heap_end - (char*)mblock) - sizeof(malloc_block);
      return ((char*)retval + sizeof(malloc_block));

bingo_cell:;
     /* if MCB isn't last MCB */
     if (mblock->next != NULL) {
         mblock->used = mblock->used | MALLOC_USED;
         return ((char*)mblock + sizeof(malloc_block));
     }
     else {
        /* last MCB -> we must build one more */
        if (mblock->size < s + sizeof(malloc_block))
            goto more_core;
        else {
        /* last MCB, but size of MCB is good for allocation */
           mblock->next = (char*)mblock + s + sizeof(malloc_block);
           mblock->size = s;
           mblock->used = mblock->used | MALLOC_USED;
           retval = mblock;
           mblock = mblock->next;
           mblock->next = NULL;
           mblock->used = MALLOC_MAGIC;     
           mblock->size = (char*)((char*)heap_end - (char*)mblock) - sizeof(malloc_block);
           return ((char*)retval + sizeof(malloc_block));
        }
     }
return NULL;     /*  This CAN NOT be :) */
}

int free(void *ptr) {
malloc_block *mb = (char*)ptr-sizeof(malloc_block);
    if ((mb->used & MALLOC_MAGIC) != MALLOC_MAGIC)
         return 0;        /* wrong pointer */
    mb->used = MALLOC_MAGIC;   /* MCB -> unused */
return 1;
}
