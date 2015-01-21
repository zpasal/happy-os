unsigned char cmos[0x3F];

unsigned char read_cmos(unsigned char addr) {
    asm {
         mov al, addr
         out 0x70, al
         nop
         nop
         in al, 0x71
         xor ah, ah
    }
}


void main() {
int *ptr = (int*)cmos;
int i;
    for(i=0; i<0x3F; i++) {
        cmos[i] = read_cmos(i);
    }
    printf("Memorije %u\n", *(ptr+24));
}
