#include <mmu.h>
#include <mbmp.h>
#include <console.h>
#include <string.h>
#include <startup.h>
#include <_asm.h>
#include <types.h>

#define PAGE_PRESENT   0x01
#define PAGE_WRITE     0x02
#define PAGE_SUPERUSER 0x04
#define PAGE_ACCESSED  0x20
#define PAGE_DIRTY     0x40


unsigned int *page_directory;
unsigned int *heap_page_table;
int           heap_top;
void         *dma_buffer;


void init_memory()
{
unsigned int i;
unsigned int *iptr;
unsigned int max_page_tables;
unsigned int address;
      max_memory = _mem_upper + 1024;
      if (max_memory > 524288) {
            max_memory = 524288;
      }
      max_pages = max_memory / 4;
      max_page_tables = max_pages / 1024;
      /*
       * Mapiramo zauzetu memoriju unutar memory bitmapa.
       * Zauzete memorija je: [0]    - Page Directory
       *                      [1..n] - Page tabele koji mapiraju memoriju
       *                      [n]    - DMA buffer
       *                      [n+1]  - Tabela za HEAP prozor
       *                      1MB .. - Kernel
       */
      set_mbmp_bit(0);
      for(i=1; i<=max_page_tables; i++)
            set_mbmp_bit(i);
      set_mbmp_bit(i);
      set_mbmp_bit(i+1);
      page_directory = (unsigned*)0x00000000;
      dma_buffer = (void*)(i * 4096);
      heap_page_table = (unsigned*)((i + 1) * 4096);
      for(i=0; i<_kernel_size / 4096; i++)
            set_mbmp_bit(256 + i);
      /*
       * Prvo setujemo Page Directory da pokazuje na sve tabele.
       * Svaki entri je PRESENT | SUPERUSER | WRITABLE.
       */
      iptr = (unsigned int*)0;
      memset(iptr, 0, 4096);
      for(i=0; i<max_page_tables; i++)
            iptr[i] = ((i + 1) * 4096) | (PAGE_PRESENT | PAGE_WRITE | PAGE_SUPERUSER);
      /*
       * Mapiranje svih tabela da pokriju citavu memoriju.
       * Prvo svaku tabelu popunimo sa nulama, a nakon
       * toga popunjavamo je dok ne mapira citavu memoriju.
       */
       iptr = (unsigned int*)4096;
       i = 0;
       address = 0;
       while(i < max_pages) {
            iptr[i] = address | (PAGE_PRESENT | PAGE_WRITE | PAGE_SUPERUSER);
            address += 4096;
            i++;
       }
       /*
        * Mapiramo heap tabelu. Posto korisnicki prostor pocinje od
        * 1GB namjestamo heap da dobijamo adrese od
        *         1GB - 4MB = 3FC00000
        * Indeks unutar PD-a je 255.
        *
        * Nakon toga alociramo jedan page za heap.
        */
       memset(heap_page_table, 0, 4096);
       page_directory[255] = ((unsigned)heap_page_table) | 0x07;
       address = (unsigned)alloc_page();
       heap_page_table[0] =  (address | 0x07);
       heap_top = 1;

       enable_paging_pm();
       cprintf("page_directorey = 4KB at 0x%08X\n", page_directory);
       cprintf("heap_page_table = 4KB at 0x%08X\n", heap_page_table);
       cprintf("first_heap_page = 4KB at 0x%08X\n", address);
       cprintf("max_page_tables = %i\n", max_page_tables);
       cprintf("max_pages       = %i\n", max_pages);
       cprintf("max_memory      = %i KB\n", max_memory);
       cprintf("dma_buffer      = 4KB at 0x%08X\n", dma_buffer);
}

