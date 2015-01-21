e:\djgpp\bin\gcc -c -Wall -W -O2 -fno-builtin -Ic:\hari\yas-os\include %1.c
e:\djgpp\bin\ar rcs ..\klibc.a %1.o
e:\djgpp\bin\objdump -a ..\klibc.a
