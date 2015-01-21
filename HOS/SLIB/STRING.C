/*
 * string module
 *
 * Functions for manipulating string and memory.
 * WARNING: there is several warning that compiler show. Just
 *           foget this warnings :)
 *
 *
 * Copyright (C) HappyOS 2003
 *						Last Revision:08.03.2003
 */


#ifndef __STRING_H
#include <string.h>
#endif


int strlen(char *str) {
int brojac = 0;
    while(*str++) brojac++;
return brojac;
}

char* strrev(char *s) {
char *j;
char c;
  j = s + strlen(s) - 1;
  while(s < j) {
    c = *s;
    *s++ = *j;
    *j-- = c;
  }
return s;
}

char* strcat(char *dest, char *source) {
char *ptr = dest;
      while(*dest != '\0') dest++;
      *dest = 'a';           // if we don't put here charachter != 0 then
                             // next while loop will break on start
      while(*dest++ = *source++);
return ptr; // popraviti
}

char* strcpy(char *dest, char *source) {
     while(*dest++ = *source++);
return dest;
}

void* memcpy(void *dest, void *source, int len) {
void *ret_val = dest;
char *s = (char *)source;
char *d = (char *)dest;
	for(; len != 0; len--)
		*d++ = *s++;
return ret_val;
}

int memcmp(void *mem1, void *mem2, int len) {
unsigned char *m1 = (unsigned char *)mem1;
unsigned char *m2 = (unsigned char *)mem2;
	for(; len != 0; len--) {
  	    if(*m1 != *m2)
		return *m1 -  *m2;
	    m1++;  m2++;
	}
return 0;
}

void* memmove(void *dest, void *source, int len) {
void *ret = dest;
char *src = (char *)source;
char *dst = (char *)dest;
	if (dest < source) {
 	   for(; len != 0; len--)
	       *dst++ = *src++;
	} else {
 	    dst += (len - 1);
	    src += (len - 1);
	    for(; len != 0; len--)
	        *dst-- = *src--;
	}
return ret;
}

void* memset(void* dest, unsigned char val, int len) {
char *d = (char*)dest;
     for(; len != 0; len--)
         *d++ = val;
return dest;
}
