/*
 * task module
 *
 * Functions for multitasking support. Only kernel use this functions.
 * Applications my have <process.h> to run several process.
 *
 * TO DO: 1. semophores - wait & signal
 *        2. Optimisation of every part
 *
 *
 * Copyright (C) HappyOS 2003
 *						Last Revision:08.03.2003
 */


#ifndef __TASKS_H
#include <tasks.h>
#endif

#ifndef __CONIO_H
#include <conio.h>
#endif

#ifndef __MALLOC_H
#include <malloc.h>
#endif

#ifndef __386_H
#include <386.h>
#endif

int  total_tasks;
task *task_list, *last_task;
task *next_task, *current_task;
unsigned char *stacks[MAX_TASKS];
unsigned idno;
extern console *current_con;

/* task with ID 0 can not be killed - NULL TASK*/
int k_kill_task(unsigned id) {
task *t1, *t2;
    if (id == 0) return 0;
    t1 = task_list;
    t2 = t1->next;
    do {
      if (t2->id == id) {
          t1->next = t2->next;
          console_free(t2->con);
          free(t2);
          total_tasks--;
          return 1;
      }
      t1 = t1->next;
      t2 = t2->next; 
    } while(task_list != t2);
return 0;
}

/* data - ds, es, fs, gs */
/* code - cs */
/* stack- ss */
int k_add_task(void *eip, void* esp) {
unsigned *p = esp;
console *c;
unsigned short _cs, _ss;
task *t;

     asm {
         mov [_cs], cs
         mov [_ss], ss
     }

     p--;
     *p-- = 0x202U;          /* EFLAGS */
     *p-- = _cs;           /* CS */
     *p-- = (unsigned)eip;   /* EIP        -  for IRETD */
     p-=6;                   /* EBP,EDI,ESI,EDS,ECX,EBX,EAX */

     t = malloc(sizeof(task));
     if (t == NULL) 
         return NULL;
     last_task->next = t;
     t->next = task_list;
     t->esp = (unsigned)p;
     t->ss = _ss; 
     t->id = ++idno;
     t->attrib = TASK_RUNABLE;
     last_task = t;
     t->con = console_alloc(0x03);
     c = t->con; c->buffer = (char*)0xB8000;
 /* this must be bether implemented for console alloc */
     total_tasks++;
return t->id;
}

void k_sheduler(void) {
  asm cli;
  if (total_tasks < 2) {
      asm sti;
      return;
  }
  current_task->attrib &= 0xFE;

  next_task = current_task->next; /* next iz circular liste */

/* SKONTATI KASNIJE 
    while(1) {
      if (next_task->attrib & TASK_PAUSED)
          next_task = next_task->next;
      else break;
  }
*/

  next_task->attrib |= TASK_ACTIVE;
  current_con = next_task->con;
  asm sti;
  asm {
      int 0x30
  }
}

task* k_get_task(unsigned id) {
task *t1, *t2;
      if (id == 0) return task_list;
      t1 = task_list;
      t2 = t1->next;
      do {
         if (t2->id == id) {
             return t2;
         }
         t1 = t1->next;
         t2 = t2->next;
      } while(t2 != task_list);
return NULL;
}

void k_pause_task(unsigned id) {
task *t;
      if (id == 0) return;
      t = k_get_task(id);
      if (t == NULL) return;
      t->attrib |= TASK_PAUSED;
return;
}

void k_unpause_task(unsigned id) {
task *t;
     if (id == 0) return;
     t = k_get_task(id);
     if (t == NULL) return;
     t->attrib &= (TASK_RUNABLE | TASK_ACTIVE);
return;
}
