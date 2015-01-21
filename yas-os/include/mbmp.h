#ifndef __MBMP_H
#define __MBMP_H

// za sada podrzava se najvise 256MB
#define MAX_MEMORY_PAGES 65536
#define MAX_MEMORY_BMPS  (MAX_MEMORY_PAGES/8 + 1)

extern unsigned char memory_bitmap[MAX_MEMORY_BMPS];
extern unsigned int max_memory; // koliko ima ukupno memorije
extern unsigned int max_pages;  // koliko pageova treba za cijelu memoriju

void set_mbmp_bit(int i);
void clear_mbmp_bit(int i);
int get_mbmp_bit(int i);
void* alloc_page();
void free_page(void *ptr);

#endif
