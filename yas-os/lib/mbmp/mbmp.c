#include <mbmp.h>
#include <console.h>
#include <string.h>

unsigned char memory_bitmap[MAX_MEMORY_BMPS];
unsigned int max_memory; // koliko ima ukupno memorije
unsigned int max_pages;  // koliko pageova treba za cijelu memoriju

void set_mbmp_bit(int i)
{
      memory_bitmap[i/8] = memory_bitmap[i/8] | (1<<(unsigned char)(i%8));
}

void clear_mbmp_bit(int i)
{
      memory_bitmap[i/8] = memory_bitmap[i/8] & ~( 1<<(unsigned char)(i%8) );
}

int get_mbmp_bit(int i)
{
return memory_bitmap[i/8] & (1<<(unsigned char)(i % 8)) ? 1 : 0;
}

void* alloc_page()
{
unsigned i;
      for(i=0; i<max_pages; i++)
          if (!get_mbmp_bit(i)) {
                  set_mbmp_bit(i);
                  return (void*)(i<<12);
          }
return NULL;
}

void free_page(void *ptr)
{
unsigned i = (unsigned)ptr;
      if ((i % 4096) || (!i)) {
            cprintf("Bad pointer passed to free_page((void *)(%08X)).\n", i);
            return;
      }
      i /= 4096;
      clear_mbmp_bit(i);
}

