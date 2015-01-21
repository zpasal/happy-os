BITS 32

GLOBAL _load_cr3
GLOBAL _enable_paging
GLOBAL _enable_paging_pm
GLOBAL _get_cr0, _get_cr2, _get_cr3

SECTION .text

; void load_cr3(void)
_load_cr3:
      xor eax, eax
      mov cr3, eax
      jmp short L1
L1:
      ret

; void enable_paging(void)
_enable_paging:
      mov eax, cr0
      or eax, 0x80000001
      mov cr0, eax
      jmp L2
L2:
      ret
      
;void enable_paging_pm(void)
_enable_paging_pm:
      xor eax, eax
      mov cr3, eax
      mov eax, cr0
      or eax, 0x80000000
      mov cr0, eax
      jmp short L3
L3:
      ret


;unsigned get_cr0(void);
_get_cr0:
      mov eax, cr0
      ret

;unsigned get_cr2(void);
_get_cr2:
      mov eax, cr2
      ret

;unsigned get_cr3(void);
_get_cr3:
      mov eax, cr3
      ret


      
