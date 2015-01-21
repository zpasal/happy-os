#include <386.h>
#include <krnl.h>
#include <membmp.h>
#include <string.h>
#include <malloc.h>
#include <intwrap.h>
#include <conio.h>
#include <tasks.h>
#include <stdarg.h>
#include <printf.h>
#include <floppy.h>


extern unsigned *page_directory;   /* malloc.c */
extern unsigned *page_table;
extern unsigned *page_krnl;
extern unsigned *page_heap;
extern unsigned char *heap_start;
extern unsigned char *heap_end;
extern int page_index;
extern console *current_con;       /* console.c */
extern int total_tasks;            /* tasks.c */
extern task *task_list, *last_task;
extern task *next_task, *current_task;
extern unsigned char *stacks[MAX_TASKS];
extern unsigned idno;
extern char *_floppy_area;        /* floppy.c */
extern int _floppy_shutoff;



GDT gdt[5];
GDTR gdtr;
unsigned _timer_counter=0;
unsigned char _scancode=0;
char *videobase, *kvideo;


const char* interrupt_message[] = {
     "Divide Error", "Debug Exception",
     "Non Maskable Interrupt", "Breakpoint [int 03]",
     "Overflow [into]", "Bound Check [bound]", "Invalid Opcode",
     "Coprocessor Not Avaliable", "Double Fault",
     "Coprocessor Segment Overrun","Invalid TSS",
     "Segment Not Presented", "Stack Exception",
     "General Protection Fault","Page Fault",
     "Parity error???","Coprocessor Error",
     "UNKNOWN INTERRUPT", "UNKNOWN INTERRUPT","UNKNOWN INTERRUPT",
     "UNKNOWN INTERRUPT","UNKNOWN INTERRUPT","UNKNOWN INTERRUPT","UNKNOWN INTERRUPT",
     "UNKNOWN INTERRUPT","UNKNOWN INTERRUPT","UNKNOWN INTERRUPT","UNKNOWN INTERRUPT",
     "UNKNOWN INTERRUPT","UNKNOWN INTERRUPT","UNKNOWN INTERRUPT","UNKNOWN INTERRUPT",
     "*IRQ[0]", "*IRQ[1]", "IRQ[2]", "IRQ[3]",
     "IRQ[4]", "IRQ[5]", "*IRQ[6]", "IRQ[7]",
     "IRQ[8]", "IRQ[9]", "IRQ[10]", "IRQ[11]",
     "IRQ[12]", "IRQ[13]", "IRQ[14]", "IRQ[15]"
};


void timer_handler(void);
void keyboard_handler(void);
void k_set_pic(unsigned char master_vector, unsigned char slave_vector);
void k_set_memory(void);
void k_set_console(void);
void k_set_tasker(void);
void k_set_floppy(void);
void reboot(void);
void delay(unsigned ms);
int glob, sem;

void task1(void);
void task2(void);
void task3(void);


void KERNEL_START(void) {
     asm mov esp, 0xC0000000 + 4096*4;      /* ??????????? */
     kvideo = (char *)0xB8000;
     memset(kvideo, 0, 4000);
     k_set_interrupts();
     k_set_memory();
     k_set_console();
     k_set_tasker();
     k_set_floppy();
     k_set_pic(0x20, 0x28);

     stacks[0] = malloc(400);
     stacks[1] = malloc(400);
     stacks[2] = malloc(400);
     sem = 0;

     k_add_task(task1, stacks[0]+354);
     k_add_task(task2, stacks[1]+354);
     k_add_task(task3, stacks[2]+354);

     asm sti;

     while(_scancode != 0x81) {

     }
     _hard_reboot();
}


void delay(unsigned ms) {
     ms = ms+_timer_counter;
     while(ms > _timer_counter);
}



void k_set_floppy(void) {
     _floppy_area = (char *)(4*4096);
}

void k_set_tasker(void) {
     total_tasks = 1;
     idno = 0;
     task_list = malloc(sizeof(task));
     task_list->next = task_list;
     task_list->id = 0;
     task_list->attrib = TASK_RUNABLE;
     task_list->con = current_con;
     last_task = task_list;
     current_task = task_list;
}



void task1(void) {
unsigned i=0;
int u;
     textcolor(WHITE);
     for(;;) {
         gotoxy(1, 10);
         cprintf("Task 1 [%u]", i++);
        
         asm mov eax, 1
again:;
         asm xchg eax, [sem]
         asm or eax, eax
         asm jnz again
        
         glob = 1;
         for(u=0; u<100; u++);
         if (glob != 1) cprintf(" Ajme meni 1");
              
         asm mov [sem], 0
         
     }
}

void task2(void) {
unsigned i=0;
int u;
     textcolor(RED);
     for(;;) {
         gotoxy(1,11);
         cprintf("Task 2 [%u]", i++);
         asm mov eax, 1
again:;
         asm xchg [sem], eax
         asm or eax, eax
         asm jnz again

         glob = 2; 
         for(u=0; u<100; u++);
         if (glob != 2) cprintf(" e mozes ga sada j.....  2");

         asm mov [sem], 0
    }
}

void task3(void) {
unsigned i=0, u;
     textcolor(GREEN);
     for(;; i++) {
        gotoxy(1,12);
        cprintf("Task 3 [%u]", i);
        asm mov eax, 1
again:;
        asm xchg eax, [sem]
	asm or eax, eax
	asm jnz again

        glob = 3;
        for(u=0; u<200; u++);
        if (glob != 3) cprintf(" kud koji mili moji! 3");

	asm mov [sem], 0
     }
}




void k_set_console(void) {
     videobase = (char*)0xB8000;
     current_con = console_alloc(0x03);
     current_con->video_index = 0;
     current_con->buffer = videobase;
}

void k_set_memory(void) {
malloc_block *mptr;
unsigned tmp;
       set_gdt_entry(&gdt[0], 0, 0, 0, 0);
       set_gdt_entry(&gdt[1], 0, 0xFFFFFF, ACS_PRESENT | ACS_CSEG | ACS_READ | ACS_DPL_3,
                     ATTR_GRANULARITY | ATTR_DEFAULT);
       set_gdt_entry(&gdt[2], 0, 0xFFFFFF, ACS_PRESENT | ACS_DSEG | ACS_WRITE | ACS_DPL_3,
                     ATTR_GRANULARITY | ATTR_BIG);
       set_gdt_entry(&gdt[3], 0, 0xFFFFFF, ACS_PRESENT | ACS_CSEG | ACS_READ | ACS_DPL_0,
                     ATTR_GRANULARITY | ATTR_DEFAULT);
       set_gdt_entry(&gdt[4], 0, 0xFFFFFF, ACS_PRESENT | ACS_DSEG | ACS_WRITE | ACS_DPL_0,
                     ATTR_GRANULARITY | ATTR_BIG);
       gdtr.base = &gdt;
       gdtr.limit = 5*8; /* pet descriptora */
       _flush_gdtr();
      page_index = 1;
      _init_bmp();
      _allocate_bmp(0);    // page DIR
      _allocate_bmp(1);    // page 1:1
      _allocate_bmp(2);    // page KRNL
      _allocate_bmp(4);    // Kernel Data Area
      heap_start = (char*)0xC0400000; /* heap tabela */
      heap_end   = heap_start;
      page_directory = (unsigned*)PAGE_DIR_ADDRESS;
      page_table = (unsigned*)PAGE_TAB_ADDRESS;
      page_krnl = (unsigned*)PAGE_TAB_KRNL;
      page_heap = (unsigned*)PAGE_TAB_HEAP;
/* fizicke
   namjestamo novu tabelu za heap kernela. Ovo je samo prozor kroz koju
   kernel gleda, pa nam reba 4KB za page tabelu.
   - Namjestimo PD[0x301] da pokazuje na tako alociranu tabelu
   - Setujemo sve nule na heap tabeli
   - prvi entri u heap tabeli mapiramo na novih 4KB koji su
     sada heap kernela gdje se vrse alokacije sa malloc
*/
     tmp = (unsigned)allocate_page();  // PD -> heap tabelu
     page_directory[0x301] = tmp | 7;   // 0x301 -> adrese od 0xC0400000
     memset((void*)tmp, 0, 4096);       // setujemo nule za svaki entri
     tmp = (unsigned)allocate_page();   // alociramo 4KB za heap
     page_heap[0] = tmp | 7;            // prvi entri -> heap
     heap_end+=4096;
     _set_cr3();
     mptr = (malloc_block*)heap_start;  // postavimo prvi mcb
     mptr->next = NULL;
     mptr->used = MALLOC_MAGIC | MALLOC_FREE;
     mptr->size = 4096 - sizeof(malloc_block);
}

void timer_handler(void) {
task *t;
     if (_floppy_shutoff) {
         _floppy_shutoff--;
         if (!_floppy_shutoff)
             outportb(DOR, 0x0C);
     }
     _timer_counter++;
     outportb(PORT_8259M, EOI);
     k_sheduler();
}

void keyboard_handler(void) {
     _scancode = inportb(PORT_KBD_A);
     outportb(PORT_8259M, EOI);
}


void exec_handler(unsigned task_id, unsigned short no, unsigned short cs,
                  unsigned eip, unsigned short error) {
char *int_msg = interrupt_message[no];
int crc;
     asm cli;
//     change_task_view(0); **************
     current_con = task_list->con; 
     cprintf("Interrupt : %s from task %u\n\r", int_msg, task_id);
     cprintf("Interrupt : %02X\n\r", no);
     cprintf("At address: %04X:%08X\n\r", cs, eip);
     cprintf("Error Code: %04X\n\r", error);
     if (task_id == 0)  {
         cprintf("Kernel make this error! System Halted!");
         for(;;);
     } 
     else {
         cprintf("Killing task %u ... ", task_id);
         crc = k_kill_task(task_id);
         if (crc == 0) 
              cputs("FAILED!!!\n\r");
         else cputs("KILLED\n\r");
         k_sheduler();
     }
}

void reboot(void) {
unsigned temp;
    asm cli;    
    do{
	temp = inportb(0x64);
	if((temp & 0x01) != 0)	{
	    inportb(0x60);
	    continue;
	}
    } while((temp & 0x02) != 0);
    outportb(0x64, 0xFE);
    while(1);
}

