#include <string.h>
#include <_printf.h>
#include <stdarg.h>
#include <console.h>

t_console current_con;

void init_console(t_console *con) {
      con->x = 0;
      con->y = 0;
      con->v_ptr = (char*)0xB8000;
      con->attr = 0x07;
      memset((void*)0xB8000, 0, 160*25);
}


void scroll() {
      memcpy((void*)(0xB8000), (void*)(0xB8000+160), 160*24);
      memset((void*)(0xB8000 + 160*24), 0, 160);
      current_con.y = 24;
}

void putch(int ch) {
t_console *con = &current_con;
      switch(ch) {
            case '\t':  con->x += 8;
                        if (con->x >= 80) {
                              con->x = 0;
                              if (++con->y > 25)
                                    scroll();
                        }
                        break;
            case '\n':  con->x = 0;
                        if (++con->y >= 25)
                              scroll();
                        break;
            default:    *(con->v_ptr + (con->x + con->y*80)*2) = ch;
                        *(con->v_ptr + (con->x + con->y*80)*2 + 1) = con->attr;
                        if (++con->x >= 80) {
                              con->x = 0;
                              if (++con->y > 25)
                                    scroll();
                        }
                        break;
      }
}


int cprintf_help(unsigned c, void **ptr)
{
	putch(c);
	return 0;
}

void cprintf(const char *fmt, ...)
{
va_list args;
	va_start(args, fmt);
	(void)_printf(fmt, args, cprintf_help, NULL);
	va_end(args);
}

