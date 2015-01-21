#include <x86.h>

unsigned inportb(unsigned short port)
{
unsigned char ret_val;
	__asm__ __volatile__("inb %1,%0"
		: "=a"(ret_val)
		: "d"(port));
return ret_val;
}

void outportb(unsigned port, unsigned val)
{
	__asm__ __volatile__("outb %b0,%w1"
		:: "a"(val), "d"(port));
}

unsigned disable()
{
unsigned ret_val;
	__asm__ __volatile__("pushfl\n"
		"popl %0\n"
		"cli"
		: "=a"(ret_val):);
return ret_val;
}

void enable()
{
	__asm__ __volatile__("sti"::);
}

