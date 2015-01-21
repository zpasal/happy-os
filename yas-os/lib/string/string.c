#include <string.h>
#include <types.h>

size_t strlen(const char *str) {
size_t s;
	for(s=0; *str!='\0'; str++)
            s++;
return s;
}

char* strcpy(char *dst, const char *src) {
char *d = dst;
      while((*dst++ = *src++));
return d;
}

void* memset(void *buffer, int ch, size_t n) {
char *tmp = (char*)buffer;
      while(n) {
            *tmp++ = ch;
            n--;
      }
return buffer;
}

void *memcpy(void *dst_ptr, const void *src_ptr, size_t count)
{
void *ret_val = dst_ptr;
const char *src = (const char *)src_ptr;
char *dst = (char *)dst_ptr;
	for(; count != 0; count--)
		*dst++ = *src++;
return ret_val;
}
