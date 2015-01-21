/*
 * printf.h
 *
 * There is only one function here - do_printf that make formated
 * va_arg output.
 * 
 * I use this function from COMSOS OS (Christhoper Giese) and put-and-cut
 * some thing. I think, that Chris do not go mad for this part that i use :)
 *
 *						Last Revision:08.03.2003
 */


#ifndef __PRINTF_H
#define __PRINTF_H

#ifndef __STDARG_H
#include <stdarg.h>
#endif

#define		PR_LJ	0x01	/* left justify */
#define		PR_CA	0x02	/* use A-F instead of a-f for hex */
#define		PR_SG	0x04	/* signed numeric conversion (%d vs. %u) */
#define		PR_32	0x08	/* long (32-bit) numeric conversion */
#define		PR_16	0x10	/* short (16-bit) numeric conversion */
#define		PR_WS	0x20	/* PR_SG set and num was < 0 */
#define		PR_LZ	0x40	/* pad left with '0' instead of ' ' */
#define		PR_FP	0x80	/* pointers are far */

#define		PR_BUFLEN	16

typedef int (*fnptr_t)(unsigned c, void **helper);

int do_printf(const char* frm, va_list args, fnptr_t fn, void *ptr);

#endif
