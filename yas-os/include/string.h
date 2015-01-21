#ifndef __STRING_H
#define __STRING_H

#include <types.h>

size_t strlen(const char *str);
char* strcpy(char *dst, const char *src);
void* memset(void *buffer, int ch, size_t n);
void *memcpy(void *dst_ptr, const void *src_ptr, size_t count);


#endif
