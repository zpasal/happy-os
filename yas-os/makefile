.SUFFIXES: .asm       

# defines
MAKEFILE= makefile
MAKEDEP = $(MAKEFILE)
LDSCRIPT= ld/coffkrnl.ld
NASM	= nasm -f coff
GCC	= e:\djgpp\bin\gcc -g -Wall -W -O2 -nostdinc -fno-builtin -Ic:\hari\yas-os\include
LD	= e:\djgpp\bin\ld  -g -T $(LDSCRIPT) -nostdlib
OBJS	= _startup.o main.o c:\hari\yas-os\lib\klibc.a

# targets
all: krnl.bin

# implicit rules
.asm.o:
	$(NASM) -o$@ $<

.c.o:
	$(GCC) -c -o$@ $<

# dependencies
_startup.o:	_startup.asm	$(MAKEDEP)

main.o:		main.c		$(MAKEDEP)

# explicit rules
krnl.bin: $(OBJS) $(LDSCRIPT)	$(MAKEDEP)
	$(LD) -o$@ $(OBJS)
	e:\djgpp\bin\objdump --source $@ > krnl.lst
      e:\djgpp\bin\nm --line-numbers $@  > krnl.sym
      e:\djgpp\bin\strip $@
