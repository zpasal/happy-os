#include <_asm.h>
#include <startup.h>
#include <string.h>
#include <console.h>
#include <types.h>
#include <x86.h>
#include <mbmp.h>
#include <mmu.h>

typedef struct
{
	unsigned edi, esi, ebp, esp, ebx, edx, ecx, eax;
	unsigned ds, es, fs, gs;
	unsigned interrupt_no, error_code;
	unsigned eip, cs, eflags, user_esp, user_ss;
} t_registers;

char * _int_names[49] =
{
	"DIVIDE ERROR","DEBUG EXCEPTION","NMI","INT3","INTO",
	"BOUND EXCEPTION","INVALID OPCODE","NO COPROCESSOR",
	"DOUBLE FAULT","COPROCESSOR SEGMENT OVERRUN", "BAD TSS",
      "SEGMENT NOT PRESENT","STACK FAULT","GENERAL PROTECTION FAULT",
	"PAGE FAULT","UNKNOWN INTERRUPT","COPROCESSOR ERROR",
	"ALIGNMENT CHECK","UNKNOWN INTERRUPT","UNKNOWN INTERRUPT",
	"UNKNOWN INTERRUPT","UNKNOWN INTERRUPT","UNKNOWN INTERRUPT",
	"UNKNOWN INTERRUPT","UNKNOWN INTERRUPT","UNKNOWN INTERRUPT",
	"UNKNOWN INTERRUPT","UNKNOWN INTERRUPT","UNKNOWN INTERRUPT",
	"UNKNOWN INTERRUPT","UNKNOWN INTERRUPT","UNKNOWN INTERRUPT",
	"IRQ0","IRQ1","IRQ2","IRQ3",
	"IRQ4","IRQ5","IRQ6","IRQ7",
	"IRQ8","IRQ9","IRQ10","IRQ11",
	"IRQ12","IRQ13","IRQ14","IRQ15",
	"UNKNOWN INTERRUPT"
};

void fault_wrapper(t_registers *reg)
{
int i = reg->interrupt_no & 0xFF;
char *code_dump;
      if (i < 49)
            cprintf("Exception: %s [%02X] (Error Code %04X)  at  %04X:%08X\n", _int_names[i], i,
                        reg->error_code, reg->cs & 0xFFFF, reg->eip);
      else cprintf("Exception: [%02X] (Error Code %04X)  at  %04X:%08X\n", i, reg->error_code,
                        reg->cs& 0xFFFF, reg->eip);
      cprintf("EAX: %08X  EBX: %08X  ECX: %08X  EDX: %08X\n", reg->eax, reg->ebx, reg->ecx, reg->edx);
      cprintf("EDI: %08X  ESI: %08X  EBP: %08X  ESP: %08X\n", reg->edi, reg->esi, reg->ebp, reg->esp);
      cprintf("DS : %04X      ES : %04X      FS : %04X      GS : %04X\n", reg->ds& 0xFFFF, reg->es& 0xFFFF,
                         reg->fs& 0xFFFF,  reg->gs& 0xFFFF);
      cprintf("User Stack: %04X:%08X\n", reg->user_ss& 0xFFFF, reg->user_esp);
      cprintf("-------------------- CODE DUMP ---------------------------\n");
      code_dump = (char*)reg->eip;
      for(i=0; i<20; i++, code_dump++)
            cprintf("%02X ", *code_dump & 0xFF);
      while(1);
}





static void init_8259s(void)
{
static const unsigned irq0_int = 0x20, irq8_int = 0x28;
	cprintf("Enabling 8259s interrupt controller ... ");
/* Initialization Control Word #1 (ICW1) */
	outportb(0x20, 0x11);
	outportb(0xA0, 0x11);
/* ICW2:
route IRQs 0-7 to INTs 20h-27h */
	outportb(0x21, irq0_int);
/* route IRQs 8-15 to INTs 28h-2Fh */
	outportb(0xA1, irq8_int);
/* ICW3 */
	outportb(0x21, 0x04);
	outportb(0xA1, 0x02);
/* ICW4 */
	outportb(0x21, 0x01);
	outportb(0xA1, 0x01);
/* enable IRQ0 (timer) and IRQ1 (keyboard) */
	outportb(0x21, ~0x03);
	outportb(0xA1, ~0x00);
	cprintf("DONE.\n");
}


void timer_handler() {
char * ptr = (char*)0xB8000;
      (*ptr)++;
      RESET_8259();
}


/* IMEPLEMENTACIJA FUNKCIJA MALLOC & FREE */

#define MALLOC_USED 1
#define MALLOC_FREE 0

#define MALLOC_MAGIC  0xDEAD

// NAPOMENA - 4096 mora biti djeljivo sa sizeof(t_mcb) = 16
typedef struct _t_mcb {
       size_t size;
       int magic;
       int attrib;
       struct _t_mcb *next;
} t_mcb;

t_mcb *heap, *prev;


void* sbrk(size_t chunks) {
int pages = chunks*sizeof(t_mcb)/4096 + 1;
unsigned address;
int i;
       // provjerimo dali ima jos pageova u Heap Page Tabeli
       if (pages + heap_top >= 1024) return NULL;
       // mapiramo nove pageove
       for(i = 0; i < pages; i++) {
            address = (unsigned)alloc_page();
            if (!address) return NULL;
            heap_page_table[heap_top++] = address | 0x07;
       }
       load_cr3();
       // uradimo flush pagiranja
       // sredimo mcb listu
       if (heap != prev || prev->size )
              prev->next =  (prev += prev->size+1);
       prev->size = chunks;
       prev->next = heap;
       prev->attrib = MALLOC_USED;
       prev->magic = MALLOC_MAGIC;
return (void*)(prev+1);
}

t_mcb *malloc_fit(size_t size) {
size_t nchunk = (size + sizeof(t_mcb))/ sizeof(t_mcb) + 1;
t_mcb *m = heap;
       prev = heap;
       do {
              if (m->size >= nchunk && m->attrib == MALLOC_FREE) { // imamo ga
                     m->attrib = MALLOC_USED;
                     m->magic = MALLOC_MAGIC;
                     return (void*)(m+1);
              }
              prev = m;
              m = m->next;
       } while(m != heap);
       // ako smo stigli ovde prevp pokazuje na zadnji blok
       // sada moramo pozvati sbrk da bi dobili jos memorije
       m = sbrk(nchunk);
return m;
}

void* malloc(size_t size) {
return malloc_fit(size);
}

void free(void *ptr) {
t_mcb *m = (t_mcb*)ptr;
       m--;
       if (m->magic != MALLOC_MAGIC) {
              cprintf("Bad pointer passed to free((void*)%08X)\n", ptr);
              return;
       }
       m->attrib = MALLOC_FREE;
}

void heap_walk() {
t_mcb *m = heap;
       cprintf("------------------------------\n");
       do {
              cprintf("[%08X] - S:%i  A:%i  N:%08X\n", m, m->size, m->attrib, m->next);
              m = m->next;
       } while(m != heap);
}



int main(void)
{
t_vector v;
char *ptr;
int i;
        init_console(&current_con);
        cprintf("Yas-Os v0.2 Compiled %s\n", __DATE__);
        cprintf(".text = 0x%08X\n", _text_start);
        cprintf(".data = 0x%08X\n", _data_start);
        cprintf(".bss  = 0x%08X\n", _bss_start);
        cprintf("Kernel size: %iKB\n", _kernel_size/1024);
        init_memory();
        init_8259s();
        v.access_byte = IDT_KERNEL;
        v.eip = (unsigned)timer_handler;
        setvect(&v, 0x20);
        enable();
        heap = (t_mcb*)0x3FC00000; // prva mapirana adresa
        heap->size = 0;
        heap->next = heap;
        heap->attrib = MALLOC_FREE;
        ptr = malloc(8096);
        for(i=0; i<10 ; i++)
            cprintf("%08X\n", heap_page_table[i]);
        while(1);
return 0;
}
