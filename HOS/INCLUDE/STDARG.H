/*
 * stdarg.h
 *
 * HappyOS haeder file for mainpulating ... args.
 * This implementation is not so good, but works good :)
 *
 * Copyright(C) HappyOS (2003)
 *                                          Last Revision: 08.03.2003
 */

#ifndef __STDARG_H
#define __STDARG_H

typedef void* va_list;

#define va_start(ap, param) (ap) = &(param)
#define va_arg(ap, type) *(char**)((char*)ap+=sizeof(type))
#define va_end(ap)

#endif