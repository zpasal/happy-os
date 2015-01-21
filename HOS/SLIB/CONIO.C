/*
 * conio modul
 *
 * Copnsole I/O functions. This functions are for kernel-only use. 
 * Apllications my have another conio.h that call this functions
 * (like interrupts) for console I/O.
 *
 * Copyright (C) HappyOS 2003
 *						Last Revision:08.03.2003
 */

#ifndef __CONIO_H
#include <conio.h>
#endif

#ifndef __MALLOC_H
#include <malloc.h>
#endif

#ifndef __STRING_H
#include <string.h>
#endif

#ifndef __STDARG_H
#include <stdarg.h>
#endif

#ifndef __PRINTF_H
#include <printf.h>
#endif

console *current_con;

console* console_alloc(unsigned char graph_mode) {
console *c;
         c = malloc(sizeof(console));
         if (c == NULL) return NULL;
         c->video_index = 0;
         c->attrib = LIGHTGRAY;
         c->mode = graph_mode;
         c->buffer = malloc(4000);
         if (c->buffer == NULL) return NULL;
         memset(c->buffer, 0, 4000);
return c;
}

int console_free(console *c) {
    free(c->buffer);
    free(c);
return 1;
}

void scroll(void) {
     memmove(current_con->buffer, current_con->buffer+160, 4000-160);
     memset(current_con->buffer+3840, 0, 160); // ponisti zadnju liniju
}


void move_cursor(void) {
     if (current_con->video_index < 4000)
         current_con->video_index+=2;
     else {        // scrollaj za jedan red, i postavi x na 0, y na 24
         scroll();
         current_con->video_index = 160*24;
     }
}

void gotoxy(int x, int y) {
     x--; y--;
     if (x > 79 || x < 0 || y > 24 || y < 0) return;
     current_con->video_index = x*2 + y*160;
}

void textattr(char __newatt) {
     current_con->attrib = __newatt;
}

void textcolor(char __newcol) {
     current_con->attrib = __newcol & 0x0F;
}

void textbackground(char __newback) {
     current_con->attrib  |= (__newback<<4);
}

void clrscr(void) {
     memset(current_con->buffer, 0, 4000);
}

char putch(int ch) {
     switch(ch) {
        case '\n': if (current_con->video_index >= 3840) {
                       scroll();
                   } else current_con->video_index+=160;
                   break;
        case '\r': current_con->video_index -= (current_con->video_index % 160);
                   break;
        case '\b': if (current_con->video_index)
                       current_con->video_index--;
                   break;
        default:   current_con->buffer[current_con->video_index] = ch;
                   current_con->buffer[current_con->video_index+1] = current_con->attrib;
                   move_cursor();
                   break;
     }
return ch;
}

void cputs(char *str) {
     while(*str) {
         putch(*str);
         str++;
     }
}


int _cprintf(unsigned c, void **p) {
    putch(c);
return 0;
}

void cprintf(const char *frm, ...) {
va_list va;
    va_start(va, frm);
    do_printf(frm, va, _cprintf, NULL);
    va_end(va);
}
