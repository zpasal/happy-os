/*
 * tasks.h
 *
 * Functions for mutitasking support. Only kernel my call this functions,
 * and applications have no access to call. Applications my have <process.h>
 * header to support runing tasks.
 *
 * Copyright (C) HappyOS 2003
 *
 *						Last Revision:08.03.2003
 */


#ifndef __TASKS_H
#define __TASKS_H

#define MAX_TASKS      50

#define TASK_ACTIVE  0x01
#define TASK_RUNABLE 0x02
#define TASK_PAUSED  0x04


/*
 *   esp    - pointer na stack
 *   id     - jedinstveni broj
 *   attrib - b[0] - active
 *            b[1] - runable
 *            b[2] - paused
 *   conid  - pripadajuca konsola  (0 ako ne treba konsola)
 *   next   - slijedeci task
 */
#pragma packed
typedef struct {
        unsigned esp;                   /*4*/
        unsigned short ss;              /*2*/ 
        unsigned id;                    /*4*/
        unsigned char  attrib;          /*1*/
        void* next;                     /*4*/
        void* con;                      /*4*/
} task;
#pragma unpacked


void k_sheduler(void);
int  k_add_task(void* eip, void* esp);
int  k_kill_task(unsigned id);
task* k_get_task(unsigned id);
void k_pause_task(unsigned id);
void k_unpause_task(unsigned id);


#endif
