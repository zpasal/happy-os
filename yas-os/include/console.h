#ifndef __CONSOLE_H
#define __CONSOLE_H

typedef struct {
        int x, y;
        char *v_ptr;
        unsigned char attr;
} t_console;

void init_console(t_console *con);
void scroll();
void putch(int ch);
int cprintf_help(unsigned c, void **ptr);
void cprintf(const char *fmt, ...);

extern t_console current_con;

#endif
