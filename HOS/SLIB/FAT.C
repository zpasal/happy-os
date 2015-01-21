typedef unsigned char byte;
typedef unsigned int  word;
typedef unsigned long dword;

typedef struct {
       byte oem[8];
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

byte *file_table;
t_boot boot;

void convert_lba(word LBA, word *head, word *track, word *sector) {
     *head   = (LBA / boot.sector_per_track) % boot.head_no;
     *track  = LBA / (boot.sector_per_track * boot.head_no);
     *sector = (LBA % boot.sector_per_track) + 1;
}

word next_cluster(word c) {
word *ptr = (word *)&fat[(c*3)/2];
word a = *ptr;
     if (c % 2)
	 a>>=4;
     else a &= 0xFFF;
return a;
}
