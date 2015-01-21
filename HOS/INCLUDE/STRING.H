/*
 * string.h
 *
 * Functions for manipulating string and memory.
 *
 * Copyright (C) HappyOS 2003
 *
 *						Last Revision:08.03.2003
 */

#ifndef __STRING_H
#define __STRING_H

int   strlen(char *str);
char* strrev(char *s);
char* strcat(char *dest, char *source);
char* strcpy(char *dest, char *source);
void* memcpy(void *dest, void *source, int len);
int   memcmp(void *mem1, void *mem2, int len);
void* memmove(void *dest, void *source, int len);
void* memset(void* dest, unsigned char val, int len);

#endif
