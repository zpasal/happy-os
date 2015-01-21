//int read_sectors(int drive, int head, int track, int sector, void *buffer)

#define BADC 0xFF1
#define EOC  0xFF7

typedef unsigned char byte;
typedef unsigned int  word;
typedef unsigned long dword;

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

extern t_boot boot;
extern byte *file_table;

char *_root;
t_directory *root_dir, *current_dir;
word fat1_lba, fat2_lba, root_lba, data_lba;

t_directory* get_current_dir() {
return current_dir;
}

void _make_file_name(char *name, char *ffname) {
int i=0;
     while(*name != '.' && i < 8) {
	    *ffname++ = *name++;
	    i++;
     }
     name++;
     while(i < 8) { *ffname++ = ' '; i++; }
     while(*name && i < 11) {
	   *ffname++ = *dest++;
	   i++;
     }
}

t_directory* _find_file(char *ffname) {
t_directory *dir = get_current_dir();
      while(dir->name[0] != 0) {
	    if (!strncmp(ffname, dir->name, 11)) return d;
	    d++;
      }
return NULL;
}

int _change_dir(char *ffname) {
t_directory *dir = _find_file(ffname);
    if (dir == NULL) return 300;


}
