#include <alloc.h>

typedef unsigned char byte;
typedef unsigned int  word;
typedef unsigned long dword;

typedef struct {
       byte oem[8];                 // samo boot data struktura
       word byte_per_sector;
       byte sector_per_cluster;
       word reserved;
       byte number_of_fat;
       word root_entries;
       word logical_sectors;
       byte MDB;
       word sector_per_fat;
       word sector_per_track;
       word head_no;
       word hidden_sector;
} t_boot;

typedef struct {
       char name[8];
       char extension[3];         // struktura direktorija
       byte attrib;
       char reserved[10];
       word time;
       word date;
       word cluster;
       dword length;
} t_directory;


t_boot boot;
unsigned char *fat;               // ovde ucitavamo FAT tabelu
unsigned char *root;              // ovde ucitavamo ROOT atbelu
unsigned sizeof_fat, sizeof_root;
unsigned sector_per_root;
unsigned fat1_lba, fat2_lba, root_lba, data_lba; // gdjse se koja tabela nalazi na disku


// samo konvertuje LBA u head, track,sector
void convert_lba(unsigned LBA, unsigned *head, unsigned *track, unsigned *sector) {
     *head   = (LBA / boot.sector_per_track) % boot.head_no;
     *track  = LBA / (boot.sector_per_track * boot.head_no);
     *sector = (LBA % boot.sector_per_track) + 1;
}

// funkcija koja cita sa 'LBA' sektora, 'no' sektora u 'buffer'
int sector_read(unsigned LBA, int no, void *buffer) {
unsigned head, track, sector;
unsigned check;
     convert_lba(LBA, &head, &track, &sector);
//      2 - komanda za citanje
//      0 - floppy drive
     check = biosdisk(2, 0, head, track, sector, no, buffer);
     if (check & 0x00FF) {
	 return check;
     } else check = 0;
return check;
}

// fja koja vraca slijedeci cluster iz FAT tabele
// glupost (unsigned*)&fat je samo cast u unsigned jer sam fat definisao
// kao niz char
unsigned next_cluster(unsigned c) {
unsigned *ptr = (unsigned *)&fat[(c*3)/2];
unsigned a = *ptr;
     if (c % 2)
	 a>>=4;
     else a &= 0xFFF;
return a;
}

// izlistavanje 'd' direktorija
void list_directory(void *d) {
t_directory *dir = d;
   puts("-----------------------------------------------------");
   while(dir->name[0]) {
       printf("IME:%.8s  EXT[%.3s]  ATTRIB[%u]  START[%u]  SIZE[%lu]\n",
		dir->name, dir->extension, dir->attrib, dir->cluster, dir->length);
       dir++;
   }
}

// trazi fajl 'str' i ako ga nadje vrati 1, te podatke o njemu u 'd'
int find_file(char *str, t_directory *d) {
t_directory *dir = (t_directory *)root;
    strupr(str);
    while(dir->name[0]) {
	 if (!memcmp(str, dir->name, 11)) {
	     *d = *dir;
	     return 1;
	 }
	 dir++;
    }
return 0;
}


// ovo izpisuje fajl na ekran
// dajemo strukturu 'dir' koju smo dobili nakon find_file
void write_file(t_directory *dir) {
char buffer[512];
unsigned lba;
int i;
dword len = 0;
    lba = dir->cluster;
    while(1) {
       sector_read(lba-2 + data_lba, 1, buffer);
       for(i=0; i<512; i++, len++) {
	  if (len >= dir->length) return;
	  printf("%c", buffer[i]);
       }
       lba = next_cluster(lba);
    }
}


// ovo uklopi gornje dvije fje u jednu, pa je samo potrebno
// ime fajla da ispise njegov sadrzaj na ekran
void write_to_console(char *filename) {
t_directory dir;
     if (!find_file(filename, &dir)) {
	 puts("ne postoji fajl");
	 return;
     }
     write_file(&dir);
}


// promjena direktorija
void change_dir(char *dirname) {
t_directory dir;
unsigned char *ptr;
unsigned c;
     if (!find_file(dirname, &dir)) {
	 puts("ne postoji directory");
	 return;
     }
     ptr = root;
     c = dir.cluster;
     memset(root, 0, sizeof_root);
     if (c == 0) {    // ako je c == 0 onda je to cluter root direktorija
	 sector_read(root_lba, sector_per_root, root);
     } else do {
	      sector_read(c-2 + data_lba, 1, ptr);
	      ptr+=512;
	      c = next_cluster(c);
	    } while(c <= 0xFF8);
}


int main() {
unsigned char buffer[512], *ptr;
t_directory dir;
int i;
    biosdisk(2, 0,  0,0,1, 1, buffer); // e ovo samo da zavrtim floppy
    clrscr();
    biosdisk(2, 0,  0,0,1, 1, buffer); // proctam boot kod
    ptr = buffer;                      // pointer na boot kod
    ptr+=3;                            // pomjerim za tri bajta (JMP instrukcie)
    memcpy(&boot, ptr, sizeof(t_boot)); // prekopiram samo koliko mi je potrebno
    printf("OEM - %.8s\n", boot.oem);
    // ovo su samo karaktersticne vrijednsti iz boot koda
    sizeof_fat = 512 * boot.sector_per_fat;
    sector_per_root = ((boot.root_entries-1) >> 4) + 1;
    sizeof_root = sector_per_root * 512;
    // gdje pocinje koja tabela (lba sektor)
    fat1_lba = boot.hidden_sector + boot.reserved;
    fat2_lba = fat1_lba + boot.sector_per_fat;
    root_lba = fat2_lba + boot.sector_per_fat;
    data_lba = root_lba + sector_per_root;

    // alokacija memorije za FAT i ROOT tabelu
    fat = malloc(sizeof_fat+1);
    root = malloc(sizeof_root+1);

    // procitas FAT i ROOT tabele
    sector_read(fat1_lba, boot.sector_per_fat, fat);
    sector_read(root_lba, sector_per_root, root);

    // ispise tekuci direktorij
    list_directory(root);

//    change_dir("direk      "); ovdje ubaci ime direktorija gdje zelis
//                               preci (11 karaktera sa SPACE-om)
//    list_directory(root);
//    change_dir("..         "); povratak na root direktorij
//    list_directory(root);

// oslobadjanje memorije
    free(root);
    free(fat);
return 0;
}
