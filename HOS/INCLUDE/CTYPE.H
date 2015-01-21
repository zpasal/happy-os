/* 
 * ctype.h
 *
 * Classifing character functions.
 *
 * Copyright (C) HappyOS 2003
 *
 *					Last Revision:08.03.2003
 */

#ifndef __CTYPE_H
#define __CTYPE_H

#define ALNUM     1
#define ALPHA     2
#define CNTRL     4
#define DIGIT     8
#define GRAPH    16
#define LOWER    32
#define PRINT    64
#define PUNCT   128
#define BLANK   256
#define UPPER   512
#define XDIGIT 1024

int isalnum (int c);
int isalpha (int c);
int iscntrl (int c);
int isdigit (int c);
int isgraph (int c);
int islower (int c);
int isprshort (int c);
int ispunct (int c);
int isspace (int c);
int isupper (int c);
int isxdigit(int c);


#endif