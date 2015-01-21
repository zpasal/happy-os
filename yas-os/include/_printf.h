#ifndef ___PRINTF_H
#define ___PRINTF_H

#include <stdarg.h>

typedef int (*fnptr_t)(unsigned c, void **helper);

int _printf(const char *fmt, va_list args, fnptr_t fn, void *ptr);

#endif
