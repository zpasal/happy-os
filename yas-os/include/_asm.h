#ifndef ___ASM_H
#define ___ASM_H

void load_cr3();
void enable_paging();
void enable_paging_pm();
unsigned get_cr0();
unsigned get_cr2();
unsigned get_cr3();

#endif
