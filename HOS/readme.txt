= Happy OS =

This was my pet project during  mu first year of study 2001-2002 where I research 
writing 32bit multitasking operating systems.

Happy OS (HOS) was implemented mostly in C and some small
parts are done in assembly (bootloader and preloader).

It futures:

- Custom written boot loader 
- Custom written kernel loader (PREKRENL)
- 32 bit protected mode OS
- Virtual memory management
- Memory management (malloc/free)
- Process tables with console support
- Multitasking
- Simple FAT12 file system access (partially implemented)

Some directions for folder structure:

- /BOOT contains implementation of boot loader and prekrnl
- /KERNEL (KERNEL.C) is main .C file of kernel
- /INCLUDE contains .h files for kernel libraries
- /SLIB contains implementation of all kernel parts
- /INSTALL contains already precompiled binaries which can be used for installation

Some parts of code are commented on my native language (Bosnian) and
if you are in real need to translate them, try to contact me but i do not promise
anything.

While HOS is written totally from scratch, there is also partially finished OS
(yas-os) which I started working on but never had time to make anything useful except
taht it uses GRUB loader to load kernel and GCC compiled/linker which are used
to build kernel in COFF file format.

Some basic staf is implemented here (interrupts and memory manager) but that is all.

==  Boot loader (BOOT.ASM) ==

BOOT.ASM is assembly written boot loader. It is written to boot sector
and executed during booting process. Maximum size of boot sector
is 512 bytes, hence boot loader functionality is just to
load second program (PREKRNL) which will setup environment
and load kernel.


Boot loader is written in assembly using NASM and it is used to load
PREKRNL.BIN file. PREKRNL.BIN must be saved inside root folder of
disk.

Boot loader will search disk for PREKRNL and load/run it
on specific memory address.

Simple configuration is done via following macros

%define BOOT_ADDRESS 0x7C00
%define FAT_ADDRESS  0x2000
%define ROOT_ADDRESS 0x3000
%define CODE_ADDRESS 0x4000

Boot.asm can enable A20 line if following macro is defined

%define ENABLE_A20

It is generic bootloader and can be used to load any file and
execute it.

== PREKRNL.BIN (BOOT/PREKNRL.ASM) ==

This is kernel loader code written in NASM. It is also stored in root folder of 
FAT12.

PREKRNL will do following:

- Switch to Unreal-mode (flat memory access)
- Load kernel from FAT12 disk to KERNEL_ADDRESS
- Set virtual memory so Kernel will be accessed on memory C0000000 (top 3GB)
- Switch to protected mode
- Jump to Kernel
- If __NEWFONT__ is defined it will replace standard BIOS fonts with custom one 
(made fully be me - spending hours and hours of handmade bitmap drawings :)


Both boot loader and PREKRNL can be built with MK.BAT script and installed on
floppy disk using MKBOOT.BAT (providing that NASM and partcopy are installed correctly).

Main part of PREKRNL is to switch

== KERNEL (KERNEL/KERNEL.C) ==

Kernel is totally written in C and it used sepcific Linkage options so
it will start at address C0000000 (top 3GB of memory).

Kernel entry point is

void KERNEL_START(void);

PREKRNL will load kernel and create protected mode setup so other
processes cannot access kernel memory.

Kernel will do following:

- Setup interrupts (set table for handling all interrupts)
- Setup memory managements (virtual memory, bitmap page tracker, malloc/free)
- Setup access to console (each task/process will have it's own instance of console)
- Setup task manager which keeps linked list of process descriptors and it will do
task switching between them
- Setup floppy disk access

After all that is prepared it will create 3 processes: task1, task2 and task3.

Currently those 3 processes are testing semaphore implementation of locking mechanism
by doing count on global variable.

== Installation ==

1. Empty formatted floppy disk
2. Run INSTALL/INSTALL.BAT

Requirements:
- Installed rawwritewin

== WARNING ==

I'm not responsible for any damage this program could cause to your computer!!!

== LICENSE ==

Do whatever u want!
