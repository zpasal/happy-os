/*
 * consio.h
 *
 * Console I/O functions.
 * There is some non-standard functions (console_alloc, move_cursor, ...)
 * but this functions are internal.
 * 
 *
 * Copyrigh (C) HappyOS  2003
 *						Last Revision:08.03.2003
 */


#ifndef __CONIO_H
#define __CONIO_H

enum COLORS {
    BLACK,
    BLUE,
    GREEN,
    CYAN,
    RED,
    MAGENTA,
    BROWN,
    LIGHTGRAY,
    DARKGRAY,       
    LIGHTBLUE,
    LIGHTGREEN,
    LIGHTCYAN,
    LIGHTRED,
    LIGHTMAGENTA,
    YELLOW,
    WHITE
};


#pragma packed
typedef struct {
   unsigned short video_index;
   unsigned char *buffer;
   unsigned char attrib, mode;
} console;
#pragma unpacked


console* console_alloc(unsigned char graph_mode);
int console_free(console *con);
void scroll(void);
void move_cursor(void);
void gotoxy(int x, int y);
void textattr(char __newatt);
void textcolor(char __newcol);
void textbackground(char __newback);
void clrscr(void);
char putch(int ch);
void cputs(char *str);
int _cprintf(unsigned c, void **p);
void cprintf(const char *frm, ...);

#endif
