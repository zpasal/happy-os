/*
 *  membmp.c
 *
 *  Source code form memory bitmap manipulation.
 *  NON-STANDARD  
 *  
 *  Copyright(c) HappyOS
 *                                             Last Revision: 08.03.2003
 */


#ifndef __MEMBMP_H
#include <membmp.h>
#endif


unsigned char memory_bmp[128];

void _init_bmp(void) {
int i;
    for(i=0; i<128; i++)
        memory_bmp[i] = 0;
}

void _allocate_bmp(int i) {
    memory_bmp[i/8] = memory_bmp[i/8] | (1<<(unsigned char)(i%8));
}

void _deallocate_bmp(int i) {
     memory_bmp[i/8] = memory_bmp[i/8] & ~( 1<<(unsigned char)(i%8) );
}

int _get_bmp(int i) {
    if ( memory_bmp[i/8] & (1<<(unsigned char)(i % 8)) ) return 1;
return 0;
}

void allocate_at_phisical(unsigned addr) {
int i = addr/4096;
     _allocate_bmp(i);
}


void* allocate_page(void) {
unsigned mem;
int i;
     for(i=0; i<1024; i++) {
         if (_get_bmp(i) == 0) {
             _allocate_bmp(i);
             break;
         }
     }
return (void*)((unsigned)i*4096);
}

unsigned _free_bmp(void) {
unsigned a = 0;
int i;
    for(i=0; i<1024; i++)
        if (_get_bmp(i)==0) a+=4096;
return a;
}

unsigned _used_bmp(void) {
unsigned a = 0;
int i;
     for(i=0; i<1024; i++)
         if(_get_bmp(i) == 1) a+=4096;
return a;
}
