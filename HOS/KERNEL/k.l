00000000  BC004000C0        mov esp,0xc0004000
00000005  C705C82400C00080  mov dword [0xc00024c8],0xb8000
         -0B00
0000000F  68A00F0000        push dword 0xfa0
00000014  6A00              push byte +0x0
00000016  FF35C82400C0      push dword [0xc00024c8]
0000001C  E8E50D0000        call 0xe06
00000021  83C40C            add esp,byte +0xc
00000024  E8C6080000        call 0x8ef
00000029  E802030000        call 0x330
0000002E  E8CD020000        call 0x300
00000033  E8D1000000        call 0x109
00000038  E8C1000000        call 0xfe
0000003D  6A28              push byte +0x28
0000003F  6A20              push byte +0x20
00000041  E8AC0B0000        call 0xbf2
00000046  83C408            add esp,byte +0x8
00000049  6890010000        push dword 0x190
0000004E  E808140000        call 0x145b
00000053  59                pop ecx
00000054  A3162700C0        mov [0xc0002716],eax
00000059  6890010000        push dword 0x190
0000005E  E8F8130000        call 0x145b
00000063  59                pop ecx
00000064  A31A2700C0        mov [0xc000271a],eax
00000069  6890010000        push dword 0x190
0000006E  E8E8130000        call 0x145b
00000073  59                pop ecx
00000074  A31E2700C0        mov [0xc000271e],eax
00000079  C705D02400C00000  mov dword [0xc00024d0],0x0
         -0000
00000083  A1162700C0        mov eax,[0xc0002716]
00000088  0562010000        add eax,0x162
0000008D  50                push eax
0000008E  8D05700100C0      lea eax,[0xc0000170]
00000094  50                push eax
00000095  E805180000        call 0x189f
0000009A  83C408            add esp,byte +0x8
0000009D  A11A2700C0        mov eax,[0xc000271a]
000000A2  0562010000        add eax,0x162
000000A7  50                push eax
000000A8  8D05F50100C0      lea eax,[0xc00001f5]
000000AE  50                push eax
000000AF  E8EB170000        call 0x189f
000000B4  83C408            add esp,byte +0x8
000000B7  A11E2700C0        mov eax,[0xc000271e]
000000BC  0562010000        add eax,0x162
000000C1  50                push eax
000000C2  8D057A0200C0      lea eax,[0xc000027a]
000000C8  50                push eax
000000C9  E8D1170000        call 0x189f
000000CE  83C408            add esp,byte +0x8
000000D1  FB                sti
000000D2  0FB6058A2000C0    movzx eax,byte [0xc000208a]
000000D9  3D81000000        cmp eax,0x81
000000DE  75F2              jnz 0xd2
000000E0  E8EF200000        call 0x21d4
000000E5  C3                ret
000000E6  55                push ebp
000000E7  89E5              mov ebp,esp
000000E9  53                push ebx
000000EA  8B5D08            mov ebx,[ebp+0x8]
000000ED  031D862000C0      add ebx,[0xc0002086]
000000F3  3B1D862000C0      cmp ebx,[0xc0002086]
000000F9  77F8              ja 0xf3
000000FB  5B                pop ebx
000000FC  5D                pop ebp
000000FD  C3                ret
000000FE  C705E62700C00040  mov dword [0xc00027e6],0x4000
         -0000
00000108  C3                ret
00000109  C705022700C00100  mov dword [0xc0002702],0x1
         -0000
00000113  C705DE2700C00000  mov dword [0xc00027de],0x0
         -0000
0000011D  6A13              push byte +0x13
0000011F  E837130000        call 0x145b
00000124  59                pop ecx
00000125  A3062700C0        mov [0xc0002706],eax
0000012A  A1062700C0        mov eax,[0xc0002706]
0000012F  8B0D062700C0      mov ecx,[0xc0002706]
00000135  89480B            mov [eax+0xb],ecx
00000138  A1062700C0        mov eax,[0xc0002706]
0000013D  C7400600000000    mov dword [eax+0x6],0x0
00000144  A1062700C0        mov eax,[0xc0002706]
00000149  C6400A02          mov byte [eax+0xa],0x2
0000014D  A1062700C0        mov eax,[0xc0002706]
00000152  8B0DFE2600C0      mov ecx,[0xc00026fe]
00000158  89480F            mov [eax+0xf],ecx
0000015B  A1062700C0        mov eax,[0xc0002706]
00000160  A30A2700C0        mov [0xc000270a],eax
00000165  A1062700C0        mov eax,[0xc0002706]
0000016A  A3122700C0        mov [0xc0002712],eax
0000016F  C3                ret
00000170  53                push ebx
00000171  56                push esi
00000172  BE00000000        mov esi,0x0
00000177  6A0F              push byte +0xf
00000179  E85A150000        call 0x16d8
0000017E  59                pop ecx
0000017F  E96C000000        jmp 0x1f0
00000184  6A0A              push byte +0xa
00000186  6A01              push byte +0x1
00000188  E8FC140000        call 0x1689
0000018D  83C408            add esp,byte +0x8
00000190  89F0              mov eax,esi
00000192  46                inc esi
00000193  50                push eax
00000194  8D05240700C0      lea eax,[0xc0000724]
0000019A  50                push eax
0000019B  E871160000        call 0x1811
000001A0  83C408            add esp,byte +0x8
000001A3  B801000000        mov eax,0x1
000001A8  8705D02400C0      xchg eax,[0xc00024d0]
000001AE  09C0              or eax,eax
000001B0  0F85F2FFFFFF      jnz near 0x1a8
000001B6  C705CC2400C00100  mov dword [0xc00024cc],0x1
         -0000
000001C0  BB00000000        mov ebx,0x0
000001C5  E901000000        jmp 0x1cb
000001CA  43                inc ebx
000001CB  83FB64            cmp ebx,byte +0x64
000001CE  7CFA              jl 0x1ca
000001D0  833DCC2400C001    cmp dword [0xc00024cc],byte +0x1
000001D7  740D              jz 0x1e6
000001D9  8D05170700C0      lea eax,[0xc0000717]
000001DF  50                push eax
000001E0  E82C160000        call 0x1811
000001E5  59                pop ecx
000001E6  C705D02400C00000  mov dword [0xc00024d0],0x0
         -0000
000001F0  EB92              jmp short 0x184
000001F2  5E                pop esi
000001F3  5B                pop ebx
000001F4  C3                ret
000001F5  53                push ebx
000001F6  56                push esi
000001F7  BE00000000        mov esi,0x0
000001FC  6A04              push byte +0x4
000001FE  E8D5140000        call 0x16d8
00000203  59                pop ecx
00000204  E96C000000        jmp 0x275
00000209  6A0B              push byte +0xb
0000020B  6A01              push byte +0x1
0000020D  E877140000        call 0x1689
00000212  83C408            add esp,byte +0x8
00000215  89F0              mov eax,esi
00000217  46                inc esi
00000218  50                push eax
00000219  8D050B0700C0      lea eax,[0xc000070b]
0000021F  50                push eax
00000220  E8EC150000        call 0x1811
00000225  83C408            add esp,byte +0x8
00000228  B801000000        mov eax,0x1
0000022D  8705D02400C0      xchg eax,[0xc00024d0]
00000233  09C0              or eax,eax
00000235  0F85F2FFFFFF      jnz near 0x22d
0000023B  C705CC2400C00200  mov dword [0xc00024cc],0x2
         -0000
00000245  BB00000000        mov ebx,0x0
0000024A  E901000000        jmp 0x250
0000024F  43                inc ebx
00000250  83FB64            cmp ebx,byte +0x64
00000253  7CFA              jl 0x24f
00000255  833DCC2400C002    cmp dword [0xc00024cc],byte +0x2
0000025C  740D              jz 0x26b
0000025E  8D05F00600C0      lea eax,[0xc00006f0]
00000264  50                push eax
00000265  E8A7150000        call 0x1811
0000026A  59                pop ecx
0000026B  C705D02400C00000  mov dword [0xc00024d0],0x0
         -0000
00000275  EB92              jmp short 0x209
00000277  5E                pop esi
00000278  5B                pop ebx
00000279  C3                ret
0000027A  53                push ebx
0000027B  56                push esi
0000027C  BE00000000        mov esi,0x0
00000281  6A02              push byte +0x2
00000283  E850140000        call 0x16d8
00000288  59                pop ecx
00000289  E96D000000        jmp 0x2fb
0000028E  6A0C              push byte +0xc
00000290  6A01              push byte +0x1
00000292  E8F2130000        call 0x1689
00000297  83C408            add esp,byte +0x8
0000029A  56                push esi
0000029B  8D05E40600C0      lea eax,[0xc00006e4]
000002A1  50                push eax
000002A2  E86A150000        call 0x1811
000002A7  83C408            add esp,byte +0x8
000002AA  B801000000        mov eax,0x1
000002AF  8705D02400C0      xchg eax,[0xc00024d0]
000002B5  09C0              or eax,eax
000002B7  0F85F2FFFFFF      jnz near 0x2af
000002BD  C705CC2400C00300  mov dword [0xc00024cc],0x3
         -0000
000002C7  BB00000000        mov ebx,0x0
000002CC  E901000000        jmp 0x2d2
000002D1  43                inc ebx
000002D2  81FBC8000000      cmp ebx,0xc8
000002D8  72F7              jc 0x2d1
000002DA  833DCC2400C003    cmp dword [0xc00024cc],byte +0x3
000002E1  740D              jz 0x2f0
000002E3  8D05CD0600C0      lea eax,[0xc00006cd]
000002E9  50                push eax
000002EA  E822150000        call 0x1811
000002EF  59                pop ecx
000002F0  C705D02400C00000  mov dword [0xc00024d0],0x0
         -0000
000002FA  46                inc esi
000002FB  EB91              jmp short 0x28e
000002FD  5E                pop esi
000002FE  5B                pop ebx
000002FF  C3                ret
00000300  C705C42400C00080  mov dword [0xc00024c4],0xb8000
         -0B00
0000030A  6A03              push byte +0x3
0000030C  E88B120000        call 0x159c
00000311  59                pop ecx
00000312  A3FE2600C0        mov [0xc00026fe],eax
00000317  A1FE2600C0        mov eax,[0xc00026fe]
0000031C  66C7000000        mov word [eax],0x0
00000321  A1FE2600C0        mov eax,[0xc00026fe]
00000326  8B0DC42400C0      mov ecx,[0xc00024c4]
0000032C  894802            mov [eax+0x2],ecx
0000032F  C3                ret
00000330  53                push ebx
00000331  56                push esi
00000332  57                push edi
00000333  8D3D942400C0      lea edi,[0xc0002494]
00000339  6A00              push byte +0x0
0000033B  6A00              push byte +0x0
0000033D  6A00              push byte +0x0
0000033F  6A00              push byte +0x0
00000341  57                push edi
00000342  E85C080000        call 0xba3
00000347  83C414            add esp,byte +0x14
0000034A  68C0000000        push dword 0xc0
0000034F  68FA000000        push dword 0xfa
00000354  68FFFFFF00        push dword 0xffffff
00000359  6A00              push byte +0x0
0000035B  8D4708            lea eax,[edi+0x8]
0000035E  50                push eax
0000035F  E83F080000        call 0xba3
00000364  83C414            add esp,byte +0x14
00000367  68C0000000        push dword 0xc0
0000036C  68F2000000        push dword 0xf2
00000371  68FFFFFF00        push dword 0xffffff
00000376  6A00              push byte +0x0
00000378  8D4710            lea eax,[edi+0x10]
0000037B  50                push eax
0000037C  E822080000        call 0xba3
00000381  83C414            add esp,byte +0x14
00000384  68C0000000        push dword 0xc0
00000389  689A000000        push dword 0x9a
0000038E  68FFFFFF00        push dword 0xffffff
00000393  6A00              push byte +0x0
00000395  8D4718            lea eax,[edi+0x18]
00000398  50                push eax
00000399  E805080000        call 0xba3
0000039E  83C414            add esp,byte +0x14
000003A1  68C0000000        push dword 0xc0
000003A6  6892000000        push dword 0x92
000003AB  68FFFFFF00        push dword 0xffffff
000003B0  6A00              push byte +0x0
000003B2  8D4720            lea eax,[edi+0x20]
000003B5  50                push eax
000003B6  E8E8070000        call 0xba3
000003BB  83C414            add esp,byte +0x14
000003BE  893DBE2400C0      mov [0xc00024be],edi
000003C4  66C705BC2400C028  mov word [0xc00024bc],0x28
         -00
000003CD  E8151E0000        call 0x21e7
000003D2  C705FA2600C00100  mov dword [0xc00026fa],0x1
         -0000
000003DC  E8770E0000        call 0x1258
000003E1  6A00              push byte +0x0
000003E3  E88D0E0000        call 0x1275
000003E8  59                pop ecx
000003E9  6A01              push byte +0x1
000003EB  E8850E0000        call 0x1275
000003F0  59                pop ecx
000003F1  6A02              push byte +0x2
000003F3  E87D0E0000        call 0x1275
000003F8  59                pop ecx
000003F9  6A04              push byte +0x4
000003FB  E8750E0000        call 0x1275
00000400  59                pop ecx
00000401  C705F22600C00000  mov dword [0xc00026f2],0xc0400000
         -40C0
0000040B  A1F22600C0        mov eax,[0xc00026f2]
00000410  A3F62600C0        mov [0xc00026f6],eax
00000415  C705E22600C00000  mov dword [0xc00026e2],0x0
         -0000
0000041F  C705E62600C00010  mov dword [0xc00026e6],0x1000
         -0000
00000429  C705EA2600C00020  mov dword [0xc00026ea],0x2000
         -0000
00000433  C705EE2600C00030  mov dword [0xc00026ee],0x3000
         -0000
0000043D  E8DC0E0000        call 0x131e
00000442  89C3              mov ebx,eax
00000444  89D8              mov eax,ebx
00000446  83C807            or eax,byte +0x7
00000449  8B0DE22600C0      mov ecx,[0xc00026e2]
0000044F  8981040C0000      mov [ecx+0xc04],eax
00000455  6800100000        push dword 0x1000
0000045A  6A00              push byte +0x0
0000045C  53                push ebx
0000045D  E8A4090000        call 0xe06
00000462  83C40C            add esp,byte +0xc
00000465  E8B40E0000        call 0x131e
0000046A  89C3              mov ebx,eax
0000046C  89D8              mov eax,ebx
0000046E  83C807            or eax,byte +0x7
00000471  8B0DEE2600C0      mov ecx,[0xc00026ee]
00000477  8901              mov [ecx],eax
00000479  8105F62600C00010  add dword [0xc00026f6],0x1000
         -0000
00000483  E83A1D0000        call 0x21c2
00000488  8B35F22600C0      mov esi,[0xc00026f2]
0000048E  C7460400000000    mov dword [esi+0x4],0x0
00000495  C7460800FFFFFF    mov dword [esi+0x8],0xffffff00
0000049C  C706F40F0000      mov dword [esi],0xff4
000004A2  5F                pop edi
000004A3  5E                pop esi
000004A4  5B                pop ebx
000004A5  C3                ret
000004A6  55                push ebp
000004A7  89E5              mov ebp,esp
000004A9  83EC04            sub esp,byte +0x4
000004AC  833DE22700C000    cmp dword [0xc00027e2],byte +0x0
000004B3  741E              jz 0x4d3
000004B5  FF0DE22700C0      dec dword [0xc00027e2]
000004BB  833DE22700C000    cmp dword [0xc00027e2],byte +0x0
000004C2  750F              jnz 0x4d3
000004C4  6A0C              push byte +0xc
000004C6  68F2030000        push dword 0x3f2
000004CB  E86A060000        call 0xb3a
000004D0  83C408            add esp,byte +0x8
000004D3  FF05862000C0      inc dword [0xc0002086]
000004D9  6A20              push byte +0x20
000004DB  6A20              push byte +0x20
000004DD  E858060000        call 0xb3a
000004E2  83C408            add esp,byte +0x8
000004E5  E85C140000        call 0x1946
000004EA  89EC              mov esp,ebp
000004EC  5D                pop ebp
000004ED  C3                ret
000004EE  6A60              push byte +0x60
000004F0  E861060000        call 0xb56
000004F5  59                pop ecx
000004F6  A28A2000C0        mov [0xc000208a],al
000004FB  6A20              push byte +0x20
000004FD  6A20              push byte +0x20
000004FF  E836060000        call 0xb3a
00000504  83C408            add esp,byte +0x8
00000507  C3                ret
00000508  55                push ebp
00000509  89E5              mov ebp,esp
0000050B  83EC04            sub esp,byte +0x4
0000050E  53                push ebx
0000050F  56                push esi
00000510  57                push edi
00000511  8B5D08            mov ebx,[ebp+0x8]
00000514  0FB77D0C          movzx edi,word [ebp+0xc]
00000518  0FB7FF            movzx edi,di
0000051B  8B04BD8E2000C0    mov eax,[edi*4+0xc000208e]
00000522  8945FC            mov [ebp-0x4],eax
00000525  FA                cli
00000526  A1062700C0        mov eax,[0xc0002706]
0000052B  8B400F            mov eax,[eax+0xf]
0000052E  A3FE2600C0        mov [0xc00026fe],eax
00000533  53                push ebx
00000534  FF75FC            push dword [ebp-0x4]
00000537  8D05AF0600C0      lea eax,[0xc00006af]
0000053D  50                push eax
0000053E  E8CE120000        call 0x1811
00000543  83C40C            add esp,byte +0xc
00000546  0FB7FF            movzx edi,di
00000549  57                push edi
0000054A  8D059C0600C0      lea eax,[0xc000069c]
00000550  50                push eax
00000551  E8BB120000        call 0x1811
00000556  83C408            add esp,byte +0x8
00000559  FF7514            push dword [ebp+0x14]
0000055C  0FB74510          movzx eax,word [ebp+0x10]
00000560  50                push eax
00000561  8D05840600C0      lea eax,[0xc0000684]
00000567  50                push eax
00000568  E8A4120000        call 0x1811
0000056D  83C40C            add esp,byte +0xc
00000570  0FB74518          movzx eax,word [ebp+0x18]
00000574  50                push eax
00000575  8D05710600C0      lea eax,[0xc0000671]
0000057B  50                push eax
0000057C  E890120000        call 0x1811
00000581  83C408            add esp,byte +0x8
00000584  85DB              test ebx,ebx
00000586  7514              jnz 0x59c
00000588  8D054A0600C0      lea eax,[0xc000064a]
0000058E  50                push eax
0000058F  E87D120000        call 0x1811
00000594  59                pop ecx
00000595  EBFE              jmp short 0x595
00000597  E941000000        jmp 0x5dd
0000059C  53                push ebx
0000059D  8D05350600C0      lea eax,[0xc0000635]
000005A3  50                push eax
000005A4  E868120000        call 0x1811
000005A9  83C408            add esp,byte +0x8
000005AC  53                push ebx
000005AD  E882120000        call 0x1834
000005B2  59                pop ecx
000005B3  89C6              mov esi,eax
000005B5  85F6              test esi,esi
000005B7  7512              jnz 0x5cb
000005B9  8D05290600C0      lea eax,[0xc0000629]
000005BF  50                push eax
000005C0  E81A120000        call 0x17df
000005C5  59                pop ecx
000005C6  E90D000000        jmp 0x5d8
000005CB  8D05200600C0      lea eax,[0xc0000620]
000005D1  50                push eax
000005D2  E808120000        call 0x17df
000005D7  59                pop ecx
000005D8  E869130000        call 0x1946
000005DD  5F                pop edi
000005DE  5E                pop esi
000005DF  5B                pop ebx
000005E0  89EC              mov esp,ebp
000005E2  5D                pop ebp
000005E3  C3                ret
000005E4  53                push ebx
000005E5  FA                cli
000005E6  6A64              push byte +0x64
000005E8  E869050000        call 0xb56
000005ED  59                pop ecx
000005EE  0FB6C0            movzx eax,al
000005F1  89C3              mov ebx,eax
000005F3  89D8              mov eax,ebx
000005F5  83E001            and eax,byte +0x1
000005F8  740A              jz 0x604
000005FA  6A60              push byte +0x60
000005FC  E855050000        call 0xb56
00000601  59                pop ecx
00000602  EBE2              jmp short 0x5e6
00000604  89D8              mov eax,ebx
00000606  83E002            and eax,byte +0x2
00000609  0F85D7FFFFFF      jnz near 0x5e6
0000060F  68FE000000        push dword 0xfe
00000614  6A64              push byte +0x64
00000616  E81F050000        call 0xb3a
0000061B  83C408            add esp,byte +0x8
0000061E  EBFE              jmp short 0x61e
00000620  4B                dec ebx
00000621  49                dec ecx
00000622  4C                dec esp
00000623  4C                dec esp
00000624  45                inc ebp
00000625  44                inc esp
00000626  0A0D00464149      or cl,[0x49414600]
0000062C  4C                dec esp
0000062D  45                inc ebp
0000062E  44                inc esp
0000062F  2121              and [ecx],esp
00000631  210A              and [edx],ecx
00000633  0D004B696C        or eax,0x6c694b00
00000638  6C                insb
00000639  696E6720746173    imul ebp,[esi+0x67],0x73617420
00000640  6B2025            imul esp,[eax],byte +0x25
00000643  7520              jnz 0x665
00000645  2E2E2E2000        and [cs:eax],al
0000064A  4B                dec ebx
0000064B  65726E            gs jc 0x6bc
0000064E  656C              gs insb
00000650  206D61            and [ebp+0x61],ch
00000653  6B652074          imul esp,[ebp+0x20],byte +0x74
00000657  6869732065        push dword 0x65207369
0000065C  7272              jc 0x6d0
0000065E  6F                outsd
0000065F  7221              jc 0x682
00000661  205379            and [ebx+0x79],dl
00000664  7374              jnc 0x6da
00000666  656D              gs insd
00000668  204861            and [eax+0x61],cl
0000066B  6C                insb
0000066C  7465              jz 0x6d3
0000066E  642100            and [fs:eax],eax
00000671  45                inc ebp
00000672  7272              jc 0x6e6
00000674  6F                outsd
00000675  7220              jc 0x697
00000677  43                inc ebx
00000678  6F                outsd
00000679  64653A20          cmp ah,[gs:eax]
0000067D  253034580A        and eax,0xa583430
00000682  0D00417420        or eax,0x20744100
00000687  61                popa
00000688  64647265          fs jc 0x6f1
0000068C  7373              jnc 0x701
0000068E  3A20              cmp ah,[eax]
00000690  253034583A        and eax,0x3a583430
00000695  253038580A        and eax,0xa583830
0000069A  0D00496E74        or eax,0x746e4900
0000069F  657272            gs jc 0x714
000006A2  7570              jnz 0x714
000006A4  7420              jz 0x6c6
000006A6  3A20              cmp ah,[eax]
000006A8  253032580A        and eax,0xa583230
000006AD  0D00496E74        or eax,0x746e4900
000006B2  657272            gs jc 0x727
000006B5  7570              jnz 0x727
000006B7  7420              jz 0x6d9
000006B9  3A20              cmp ah,[eax]
000006BB  2573206672        and eax,0x72662073
000006C0  6F                outsd
000006C1  6D                insd
000006C2  20746173          and [ecx+0x73],dh
000006C6  6B2025            imul esp,[eax],byte +0x25
000006C9  750A              jnz 0x6d5
000006CB  0D00206B75        or eax,0x756b2000
000006D0  64206B6F          and [fs:ebx+0x6f],ch
000006D4  6A69              push byte +0x69
000006D6  206D69            and [ebp+0x69],ch
000006D9  6C                insb
000006DA  69206D6F6A69      imul esp,[eax],0x696a6f6d
000006E0  2120              and [eax],esp
000006E2  3300              xor eax,[eax]
000006E4  54                push esp
000006E5  61                popa
000006E6  736B              jnc 0x753
000006E8  2033              and [ebx],dh
000006EA  205B25            and [ebx+0x25],bl
000006ED  755D              jnz 0x74c
000006EF  0020              add [eax],ah
000006F1  65206D6F          and [gs:ebp+0x6f],ch
000006F5  7A65              jpe 0x75c
000006F7  7320              jnc 0x719
000006F9  6761              a16 popa
000006FB  207361            and [ebx+0x61],dh
000006FE  6461              fs popa
00000700  206A2E            and [edx+0x2e],ch
00000703  2E2E2E2E2020      and [cs:eax],ah
00000709  3200              xor al,[eax]
0000070B  54                push esp
0000070C  61                popa
0000070D  736B              jnc 0x77a
0000070F  2032              and [edx],dh
00000711  205B25            and [ebx+0x25],bl
00000714  755D              jnz 0x773
00000716  0020              add [eax],ah
00000718  41                inc ecx
00000719  6A6D              push byte +0x6d
0000071B  65206D65          and [gs:ebp+0x65],ch
0000071F  6E                outsb
00000720  692031005461      imul esp,[eax],0x61540031
00000726  736B              jnc 0x793
00000728  2031              and [ecx],dh
0000072A  205B25            and [ebx+0x25],bl
0000072D  755D              jnz 0x78c
0000072F  004952            add [ecx+0x52],cl
00000732  51                push ecx
00000733  5B                pop ebx
00000734  31355D004952      xor [0x5249005d],esi
0000073A  51                push ecx
0000073B  5B                pop ebx
0000073C  31345D00495251    xor [ebx*2+0x51524900],esi
00000743  5B                pop ebx
00000744  3133              xor [ebx],esi
00000746  5D                pop ebp
00000747  004952            add [ecx+0x52],cl
0000074A  51                push ecx
0000074B  5B                pop ebx
0000074C  3132              xor [edx],esi
0000074E  5D                pop ebp
0000074F  004952            add [ecx+0x52],cl
00000752  51                push ecx
00000753  5B                pop ebx
00000754  3131              xor [ecx],esi
00000756  5D                pop ebp
00000757  004952            add [ecx+0x52],cl
0000075A  51                push ecx
0000075B  5B                pop ebx
0000075C  3130              xor [eax],esi
0000075E  5D                pop ebp
0000075F  004952            add [ecx+0x52],cl
00000762  51                push ecx
00000763  5B                pop ebx
00000764  395D00            cmp [ebp+0x0],ebx
00000767  49                dec ecx
00000768  52                push edx
00000769  51                push ecx
0000076A  5B                pop ebx
0000076B  385D00            cmp [ebp+0x0],bl
0000076E  49                dec ecx
0000076F  52                push edx
00000770  51                push ecx
00000771  5B                pop ebx
00000772  37                aaa
00000773  5D                pop ebp
00000774  002A              add [edx],ch
00000776  49                dec ecx
00000777  52                push edx
00000778  51                push ecx
00000779  5B                pop ebx
0000077A  365D              ss pop ebp
0000077C  004952            add [ecx+0x52],cl
0000077F  51                push ecx
00000780  5B                pop ebx
00000781  355D004952        xor eax,0x5249005d
00000786  51                push ecx
00000787  5B                pop ebx
00000788  345D              xor al,0x5d
0000078A  004952            add [ecx+0x52],cl
0000078D  51                push ecx
0000078E  5B                pop ebx
0000078F  335D00            xor ebx,[ebp+0x0]
00000792  49                dec ecx
00000793  52                push edx
00000794  51                push ecx
00000795  5B                pop ebx
00000796  325D00            xor bl,[ebp+0x0]
00000799  2A4952            sub cl,[ecx+0x52]
0000079C  51                push ecx
0000079D  5B                pop ebx
0000079E  315D00            xor [ebp+0x0],ebx
000007A1  2A4952            sub cl,[ecx+0x52]
000007A4  51                push ecx
000007A5  5B                pop ebx
000007A6  305D00            xor [ebp+0x0],bl
000007A9  55                push ebp
000007AA  4E                dec esi
000007AB  4B                dec ebx
000007AC  4E                dec esi
000007AD  4F                dec edi
000007AE  57                push edi
000007AF  4E                dec esi
000007B0  20494E            and [ecx+0x4e],cl
000007B3  54                push esp
000007B4  45                inc ebp
000007B5  52                push edx
000007B6  52                push edx
000007B7  55                push ebp
000007B8  50                push eax
000007B9  54                push esp
000007BA  00436F            add [ebx+0x6f],al
000007BD  7072              jo 0x831
000007BF  6F                outsd
000007C0  636573            arpl [ebp+0x73],sp
000007C3  736F              jnc 0x834
000007C5  7220              jc 0x7e7
000007C7  45                inc ebp
000007C8  7272              jc 0x83c
000007CA  6F                outsd
000007CB  7200              jc 0x7cd
000007CD  50                push eax
000007CE  61                popa
000007CF  7269              jc 0x83a
000007D1  7479              jz 0x84c
000007D3  206572            and [ebp+0x72],ah
000007D6  726F              jc 0x847
000007D8  723F              jc 0x819
000007DA  005061            add [eax+0x61],dl
000007DD  6765204661        and [gs:bp+0x61],al
000007E2  756C              jnz 0x850
000007E4  7400              jz 0x7e6
000007E6  47                inc edi
000007E7  656E              gs outsb
000007E9  657261            gs jc 0x84d
000007EC  6C                insb
000007ED  205072            and [eax+0x72],dl
000007F0  6F                outsd
000007F1  7465              jz 0x858
000007F3  6374696F          arpl [ecx+ebp*2+0x6f],si
000007F7  6E                outsb
000007F8  204661            and [esi+0x61],al
000007FB  756C              jnz 0x869
000007FD  7400              jz 0x7ff
000007FF  53                push ebx
00000800  7461              jz 0x863
00000802  636B20            arpl [ebx+0x20],bp
00000805  45                inc ebp
00000806  7863              js 0x86b
00000808  657074            gs jo 0x87f
0000080B  696F6E00536567    imul ebp,[edi+0x6e],0x67655300
00000812  6D                insd
00000813  656E              gs outsb
00000815  7420              jz 0x837
00000817  4E                dec esi
00000818  6F                outsd
00000819  7420              jz 0x83b
0000081B  50                push eax
0000081C  7265              jc 0x883
0000081E  7365              jnc 0x885
00000820  6E                outsb
00000821  7465              jz 0x888
00000823  6400496E          add [fs:ecx+0x6e],cl
00000827  7661              jna 0x88a
00000829  6C                insb
0000082A  6964205453530043  imul esp,[eax+0x54],0x43005353
00000832  6F                outsd
00000833  7072              jo 0x8a7
00000835  6F                outsd
00000836  636573            arpl [ebp+0x73],sp
00000839  736F              jnc 0x8aa
0000083B  7220              jc 0x85d
0000083D  53                push ebx
0000083E  65676D            gs a16 insd
00000841  656E              gs outsb
00000843  7420              jz 0x865
00000845  4F                dec edi
00000846  7665              jna 0x8ad
00000848  7272              jc 0x8bc
0000084A  756E              jnz 0x8ba
0000084C  00446F75          add [edi+ebp*2+0x75],al
00000850  626C6520          bound ebp,[ebp+0x20]
00000854  46                inc esi
00000855  61                popa
00000856  756C              jnz 0x8c4
00000858  7400              jz 0x85a
0000085A  43                inc ebx
0000085B  6F                outsd
0000085C  7072              jo 0x8d0
0000085E  6F                outsd
0000085F  636573            arpl [ebp+0x73],sp
00000862  736F              jnc 0x8d3
00000864  7220              jc 0x886
00000866  4E                dec esi
00000867  6F                outsd
00000868  7420              jz 0x88a
0000086A  41                inc ecx
0000086B  7661              jna 0x8ce
0000086D  6C                insb
0000086E  6961626C650049    imul esp,[ecx+0x62],0x4900656c
00000875  6E                outsb
00000876  7661              jna 0x8d9
00000878  6C                insb
00000879  6964204F70636F64  imul esp,[eax+0x4f],0x646f6370
00000881  6500426F          add [gs:edx+0x6f],al
00000885  756E              jnz 0x8f5
00000887  64204368          and [fs:ebx+0x68],al
0000088B  65636B20          arpl [gs:ebx+0x20],bp
0000088F  5B                pop ebx
00000890  626F75            bound ebp,[edi+0x75]
00000893  6E                outsb
00000894  645D              fs pop ebp
00000896  004F76            add [edi+0x76],cl
00000899  657266            gs jc 0x902
0000089C  6C                insb
0000089D  6F                outsd
0000089E  7720              ja 0x8c0
000008A0  5B                pop ebx
000008A1  696E746F5D0042    imul ebp,[esi+0x74],0x42005d6f
000008A8  7265              jc 0x90f
000008AA  61                popa
000008AB  6B706F69          imul esi,[eax+0x6f],byte +0x69
000008AF  6E                outsb
000008B0  7420              jz 0x8d2
000008B2  5B                pop ebx
000008B3  696E742030335D    imul ebp,[esi+0x74],0x5d333020
000008BA  004E6F            add [esi+0x6f],cl
000008BD  6E                outsb
000008BE  204D61            and [ebp+0x61],cl
000008C1  736B              jnc 0x92e
000008C3  61                popa
000008C4  626C6520          bound ebp,[ebp+0x20]
000008C8  49                dec ecx
000008C9  6E                outsb
000008CA  7465              jz 0x931
000008CC  7272              jc 0x940
000008CE  7570              jnz 0x940
000008D0  7400              jz 0x8d2
000008D2  44                inc esp
000008D3  65627567          bound esi,[gs:ebp+0x67]
000008D7  204578            and [ebp+0x78],al
000008DA  636570            arpl [ebp+0x70],sp
000008DD  7469              jz 0x948
000008DF  6F                outsd
000008E0  6E                outsb
000008E1  00446976          add [ecx+ebp*2+0x76],al
000008E5  696465204572726F  imul esp,[ebp+0x20],0x6f727245
000008ED  7200              jc 0x8ef
000008EF  55                push ebp
000008F0  89E5              mov ebp,esp
000008F2  81ECC0000000      sub esp,0xc0
000008F8  53                push ebx
000008F9  8D05462200C0      lea eax,[0xc0002246]
000008FF  898540FFFFFF      mov [ebp+0xffffff40],eax
00000905  8D054E2200C0      lea eax,[0xc000224e]
0000090B  898544FFFFFF      mov [ebp+0xffffff44],eax
00000911  8D05562200C0      lea eax,[0xc0002256]
00000917  898548FFFFFF      mov [ebp+0xffffff48],eax
0000091D  8D055E2200C0      lea eax,[0xc000225e]
00000923  89854CFFFFFF      mov [ebp+0xffffff4c],eax
00000929  8D05662200C0      lea eax,[0xc0002266]
0000092F  898550FFFFFF      mov [ebp+0xffffff50],eax
00000935  8D056E2200C0      lea eax,[0xc000226e]
0000093B  898554FFFFFF      mov [ebp+0xffffff54],eax
00000941  8D05792200C0      lea eax,[0xc0002279]
00000947  898558FFFFFF      mov [ebp+0xffffff58],eax
0000094D  8D05842200C0      lea eax,[0xc0002284]
00000953  89855CFFFFFF      mov [ebp+0xffffff5c],eax
00000959  8D058F2200C0      lea eax,[0xc000228f]
0000095F  898560FFFFFF      mov [ebp+0xffffff60],eax
00000965  8D059A2200C0      lea eax,[0xc000229a]
0000096B  898564FFFFFF      mov [ebp+0xffffff64],eax
00000971  8D05A52200C0      lea eax,[0xc00022a5]
00000977  898568FFFFFF      mov [ebp+0xffffff68],eax
0000097D  8D05B02200C0      lea eax,[0xc00022b0]
00000983  89856CFFFFFF      mov [ebp+0xffffff6c],eax
00000989  8D05BB2200C0      lea eax,[0xc00022bb]
0000098F  898570FFFFFF      mov [ebp+0xffffff70],eax
00000995  8D05C62200C0      lea eax,[0xc00022c6]
0000099B  898574FFFFFF      mov [ebp+0xffffff74],eax
000009A1  8D05D12200C0      lea eax,[0xc00022d1]
000009A7  898578FFFFFF      mov [ebp+0xffffff78],eax
000009AD  8D05DC2200C0      lea eax,[0xc00022dc]
000009B3  89857CFFFFFF      mov [ebp+0xffffff7c],eax
000009B9  8D05E72200C0      lea eax,[0xc00022e7]
000009BF  894580            mov [ebp-0x80],eax
000009C2  8D05F22200C0      lea eax,[0xc00022f2]
000009C8  894584            mov [ebp-0x7c],eax
000009CB  8D05FD2200C0      lea eax,[0xc00022fd]
000009D1  894588            mov [ebp-0x78],eax
000009D4  8D05082300C0      lea eax,[0xc0002308]
000009DA  89458C            mov [ebp-0x74],eax
000009DD  8D05132300C0      lea eax,[0xc0002313]
000009E3  894590            mov [ebp-0x70],eax
000009E6  8D051E2300C0      lea eax,[0xc000231e]
000009EC  894594            mov [ebp-0x6c],eax
000009EF  8D05292300C0      lea eax,[0xc0002329]
000009F5  894598            mov [ebp-0x68],eax
000009F8  8D05342300C0      lea eax,[0xc0002334]
000009FE  89459C            mov [ebp-0x64],eax
00000A01  8D053F2300C0      lea eax,[0xc000233f]
00000A07  8945A0            mov [ebp-0x60],eax
00000A0A  8D054A2300C0      lea eax,[0xc000234a]
00000A10  8945A4            mov [ebp-0x5c],eax
00000A13  8D05552300C0      lea eax,[0xc0002355]
00000A19  8945A8            mov [ebp-0x58],eax
00000A1C  8D05602300C0      lea eax,[0xc0002360]
00000A22  8945AC            mov [ebp-0x54],eax
00000A25  8D056B2300C0      lea eax,[0xc000236b]
00000A2B  8945B0            mov [ebp-0x50],eax
00000A2E  8D05762300C0      lea eax,[0xc0002376]
00000A34  8945B4            mov [ebp-0x4c],eax
00000A37  8D05812300C0      lea eax,[0xc0002381]
00000A3D  8945B8            mov [ebp-0x48],eax
00000A40  8D058C2300C0      lea eax,[0xc000238c]
00000A46  8945BC            mov [ebp-0x44],eax
00000A49  8D05262400C0      lea eax,[0xc0002426]
00000A4F  8945C0            mov [ebp-0x40],eax
00000A52  8D053A2400C0      lea eax,[0xc000243a]
00000A58  8945C4            mov [ebp-0x3c],eax
00000A5B  8D05972300C0      lea eax,[0xc0002397]
00000A61  8945C8            mov [ebp-0x38],eax
00000A64  8D05A22300C0      lea eax,[0xc00023a2]
00000A6A  8945CC            mov [ebp-0x34],eax
00000A6D  8D05AD2300C0      lea eax,[0xc00023ad]
00000A73  8945D0            mov [ebp-0x30],eax
00000A76  8D05B82300C0      lea eax,[0xc00023b8]
00000A7C  8945D4            mov [ebp-0x2c],eax
00000A7F  8D054E2400C0      lea eax,[0xc000244e]
00000A85  8945D8            mov [ebp-0x28],eax
00000A88  8D05C32300C0      lea eax,[0xc00023c3]
00000A8E  8945DC            mov [ebp-0x24],eax
00000A91  8D05CE2300C0      lea eax,[0xc00023ce]
00000A97  8945E0            mov [ebp-0x20],eax
00000A9A  8D05D92300C0      lea eax,[0xc00023d9]
00000AA0  8945E4            mov [ebp-0x1c],eax
00000AA3  8D05E42300C0      lea eax,[0xc00023e4]
00000AA9  8945E8            mov [ebp-0x18],eax
00000AAC  8D05EF2300C0      lea eax,[0xc00023ef]
00000AB2  8945EC            mov [ebp-0x14],eax
00000AB5  8D05FA2300C0      lea eax,[0xc00023fa]
00000ABB  8945F0            mov [ebp-0x10],eax
00000ABE  8D05052400C0      lea eax,[0xc0002405]
00000AC4  8945F4            mov [ebp-0xc],eax
00000AC7  8D05102400C0      lea eax,[0xc0002410]
00000ACD  8945F8            mov [ebp-0x8],eax
00000AD0  8D051B2400C0      lea eax,[0xc000241b]
00000AD6  8945FC            mov [ebp-0x4],eax
00000AD9  8D055F2400C0      lea eax,[0xc000245f]
00000ADF  894500            mov [ebp+0x0],eax
00000AE2  BB00000000        mov ebx,0x0
00000AE7  E927000000        jmp 0xb13
00000AEC  6A00              push byte +0x0
00000AEE  688E000000        push dword 0x8e
00000AF3  FFB49D40FFFFFF    push dword [ebp+ebx*4+0xffffff40]
00000AFA  6A18              push byte +0x18
00000AFC  8D05D42400C0      lea eax,[0xc00024d4]
00000B02  89D9              mov ecx,ebx
00000B04  C1E103            shl ecx,0x3
00000B07  01C8              add eax,ecx
00000B09  50                push eax
00000B0A  E860000000        call 0xb6f
00000B0F  83C414            add esp,byte +0x14
00000B12  43                inc ebx
00000B13  83FB31            cmp ebx,byte +0x31
00000B16  0F8CD0FFFFFF      jl near 0xaec
00000B1C  8D05D42400C0      lea eax,[0xc00024d4]
00000B22  A35E2600C0        mov [0xc000265e],eax
00000B27  66C7055C2600C088  mov word [0xc000265c],0x188
         -01
00000B30  E896160000        call 0x21cb
00000B35  5B                pop ebx
00000B36  89EC              mov esp,ebp
00000B38  5D                pop ebp
00000B39  C3                ret
00000B3A  55                push ebp
00000B3B  89E5              mov ebp,esp
00000B3D  668B5508          mov dx,[ebp+0x8]
00000B41  8A450C            mov al,[ebp+0xc]
00000B44  EE                out dx,al
00000B45  5D                pop ebp
00000B46  C3                ret
00000B47  55                push ebp
00000B48  89E5              mov ebp,esp
00000B4A  668B5508          mov dx,[ebp+0x8]
00000B4E  668B450C          mov ax,[ebp+0xc]
00000B52  66EF              out dx,ax
00000B54  5D                pop ebp
00000B55  C3                ret
00000B56  55                push ebp
00000B57  89E5              mov ebp,esp
00000B59  668B5508          mov dx,[ebp+0x8]
00000B5D  EC                in al,dx
00000B5E  5D                pop ebp
00000B5F  C3                ret
00000B60  55                push ebp
00000B61  89E5              mov ebp,esp
00000B63  668B5508          mov dx,[ebp+0x8]
00000B67  66ED              in ax,dx
00000B69  5D                pop ebp
00000B6A  C3                ret
00000B6B  FA                cli
00000B6C  C3                ret
00000B6D  FB                sti
00000B6E  C3                ret
00000B6F  55                push ebp
00000B70  89E5              mov ebp,esp
00000B72  53                push ebx
00000B73  56                push esi
00000B74  8B7508            mov esi,[ebp+0x8]
00000B77  8B5D10            mov ebx,[ebp+0x10]
00000B7A  668B450C          mov ax,[ebp+0xc]
00000B7E  66894602          mov [esi+0x2],ax
00000B82  89D8              mov eax,ebx
00000B84  0FB7C0            movzx eax,ax
00000B87  668906            mov [esi],ax
00000B8A  89D8              mov eax,ebx
00000B8C  C1E810            shr eax,0x10
00000B8F  66894606          mov [esi+0x6],ax
00000B93  8A4514            mov al,[ebp+0x14]
00000B96  884605            mov [esi+0x5],al
00000B99  8A4518            mov al,[ebp+0x18]
00000B9C  884604            mov [esi+0x4],al
00000B9F  5E                pop esi
00000BA0  5B                pop ebx
00000BA1  5D                pop ebp
00000BA2  C3                ret
00000BA3  55                push ebp
00000BA4  89E5              mov ebp,esp
00000BA6  53                push ebx
00000BA7  56                push esi
00000BA8  57                push edi
00000BA9  8B7508            mov esi,[ebp+0x8]
00000BAC  8B5D0C            mov ebx,[ebp+0xc]
00000BAF  8B7D10            mov edi,[ebp+0x10]
00000BB2  89D8              mov eax,ebx
00000BB4  0FB7C0            movzx eax,ax
00000BB7  66894602          mov [esi+0x2],ax
00000BBB  89D8              mov eax,ebx
00000BBD  C1E810            shr eax,0x10
00000BC0  0FB6C0            movzx eax,al
00000BC3  884604            mov [esi+0x4],al
00000BC6  89D8              mov eax,ebx
00000BC8  C1E818            shr eax,0x18
00000BCB  884607            mov [esi+0x7],al
00000BCE  89F8              mov eax,edi
00000BD0  0FB7C0            movzx eax,ax
00000BD3  668906            mov [esi],ax
00000BD6  89F8              mov eax,edi
00000BD8  C1E810            shr eax,0x10
00000BDB  83E00F            and eax,byte +0xf
00000BDE  0FB64D18          movzx ecx,byte [ebp+0x18]
00000BE2  09C1              or ecx,eax
00000BE4  884E06            mov [esi+0x6],cl
00000BE7  8A4514            mov al,[ebp+0x14]
00000BEA  884605            mov [esi+0x5],al
00000BED  5F                pop edi
00000BEE  5E                pop esi
00000BEF  5B                pop ebx
00000BF0  5D                pop ebp
00000BF1  C3                ret
00000BF2  55                push ebp
00000BF3  89E5              mov ebp,esp
00000BF5  6A11              push byte +0x11
00000BF7  6A20              push byte +0x20
00000BF9  E83CFFFFFF        call 0xb3a
00000BFE  83C408            add esp,byte +0x8
00000C01  6A11              push byte +0x11
00000C03  68A0000000        push dword 0xa0
00000C08  E82DFFFFFF        call 0xb3a
00000C0D  83C408            add esp,byte +0x8
00000C10  0FB64508          movzx eax,byte [ebp+0x8]
00000C14  50                push eax
00000C15  6A21              push byte +0x21
00000C17  E81EFFFFFF        call 0xb3a
00000C1C  83C408            add esp,byte +0x8
00000C1F  0FB6450C          movzx eax,byte [ebp+0xc]
00000C23  50                push eax
00000C24  68A1000000        push dword 0xa1
00000C29  E80CFFFFFF        call 0xb3a
00000C2E  83C408            add esp,byte +0x8
00000C31  6A04              push byte +0x4
00000C33  6A21              push byte +0x21
00000C35  E800FFFFFF        call 0xb3a
00000C3A  83C408            add esp,byte +0x8
00000C3D  6A02              push byte +0x2
00000C3F  68A1000000        push dword 0xa1
00000C44  E8F1FEFFFF        call 0xb3a
00000C49  83C408            add esp,byte +0x8
00000C4C  6A01              push byte +0x1
00000C4E  6A21              push byte +0x21
00000C50  E8E5FEFFFF        call 0xb3a
00000C55  83C408            add esp,byte +0x8
00000C58  6A01              push byte +0x1
00000C5A  68A1000000        push dword 0xa1
00000C5F  E8D6FEFFFF        call 0xb3a
00000C64  83C408            add esp,byte +0x8
00000C67  5D                pop ebp
00000C68  C3                ret
00000C69  55                push ebp
00000C6A  89E5              mov ebp,esp
00000C6C  FF7508            push dword [ebp+0x8]
00000C6F  6A70              push byte +0x70
00000C71  E8C4FEFFFF        call 0xb3a
00000C76  83C408            add esp,byte +0x8
00000C79  90                nop
00000C7A  6A71              push byte +0x71
00000C7C  E8D5FEFFFF        call 0xb56
00000C81  59                pop ecx
00000C82  5D                pop ebp
00000C83  C3                ret
00000C84  55                push ebp
00000C85  89E5              mov ebp,esp
00000C87  53                push ebx
00000C88  BB00000000        mov ebx,0x0
00000C8D  E901000000        jmp 0xc93
00000C92  43                inc ebx
00000C93  8B4508            mov eax,[ebp+0x8]
00000C96  FF4508            inc dword [ebp+0x8]
00000C99  803800            cmp byte [eax],0x0
00000C9C  75F4              jnz 0xc92
00000C9E  89D8              mov eax,ebx
00000CA0  5B                pop ebx
00000CA1  5D                pop ebp
00000CA2  C3                ret
00000CA3  55                push ebp
00000CA4  89E5              mov ebp,esp
00000CA6  53                push ebx
00000CA7  56                push esi
00000CA8  57                push edi
00000CA9  8B7508            mov esi,[ebp+0x8]
00000CAC  56                push esi
00000CAD  E8D2FFFFFF        call 0xc84
00000CB2  59                pop ecx
00000CB3  01F0              add eax,esi
00000CB5  48                dec eax
00000CB6  89C7              mov edi,eax
00000CB8  E90E000000        jmp 0xccb
00000CBD  8A1E              mov bl,[esi]
00000CBF  89F0              mov eax,esi
00000CC1  46                inc esi
00000CC2  8A0F              mov cl,[edi]
00000CC4  8808              mov [eax],cl
00000CC6  89F8              mov eax,edi
00000CC8  4F                dec edi
00000CC9  8818              mov [eax],bl
00000CCB  39FE              cmp esi,edi
00000CCD  0F82EAFFFFFF      jc near 0xcbd
00000CD3  89F0              mov eax,esi
00000CD5  5F                pop edi
00000CD6  5E                pop esi
00000CD7  5B                pop ebx
00000CD8  5D                pop ebp
00000CD9  C3                ret
00000CDA  55                push ebp
00000CDB  89E5              mov ebp,esp
00000CDD  56                push esi
00000CDE  8B7508            mov esi,[ebp+0x8]
00000CE1  E901000000        jmp 0xce7
00000CE6  46                inc esi
00000CE7  0FBE06            movsx eax,byte [esi]
00000CEA  85C0              test eax,eax
00000CEC  75F8              jnz 0xce6
00000CEE  C60661            mov byte [esi],0x61
00000CF1  8B450C            mov eax,[ebp+0xc]
00000CF4  FF450C            inc dword [ebp+0xc]
00000CF7  89F1              mov ecx,esi
00000CF9  46                inc esi
00000CFA  8A00              mov al,[eax]
00000CFC  8801              mov [ecx],al
00000CFE  84C0              test al,al
00000D00  75EF              jnz 0xcf1
00000D02  89F0              mov eax,esi
00000D04  5E                pop esi
00000D05  5D                pop ebp
00000D06  C3                ret
00000D07  55                push ebp
00000D08  89E5              mov ebp,esp
00000D0A  56                push esi
00000D0B  8B7508            mov esi,[ebp+0x8]
00000D0E  8B450C            mov eax,[ebp+0xc]
00000D11  FF450C            inc dword [ebp+0xc]
00000D14  89F1              mov ecx,esi
00000D16  46                inc esi
00000D17  8A00              mov al,[eax]
00000D19  8801              mov [ecx],al
00000D1B  84C0              test al,al
00000D1D  75EF              jnz 0xd0e
00000D1F  89F0              mov eax,esi
00000D21  5E                pop esi
00000D22  5D                pop ebp
00000D23  C3                ret
00000D24  55                push ebp
00000D25  89E5              mov ebp,esp
00000D27  83EC04            sub esp,byte +0x4
00000D2A  53                push ebx
00000D2B  56                push esi
00000D2C  57                push edi
00000D2D  8B5D10            mov ebx,[ebp+0x10]
00000D30  8B4508            mov eax,[ebp+0x8]
00000D33  8945FC            mov [ebp-0x4],eax
00000D36  8B7D0C            mov edi,[ebp+0xc]
00000D39  8B7508            mov esi,[ebp+0x8]
00000D3C  E90B000000        jmp 0xd4c
00000D41  89F8              mov eax,edi
00000D43  47                inc edi
00000D44  89F1              mov ecx,esi
00000D46  46                inc esi
00000D47  8A00              mov al,[eax]
00000D49  8801              mov [ecx],al
00000D4B  4B                dec ebx
00000D4C  85DB              test ebx,ebx
00000D4E  0F85EDFFFFFF      jnz near 0xd41
00000D54  8B45FC            mov eax,[ebp-0x4]
00000D57  5F                pop edi
00000D58  5E                pop esi
00000D59  5B                pop ebx
00000D5A  89EC              mov esp,ebp
00000D5C  5D                pop ebp
00000D5D  C3                ret
00000D5E  55                push ebp
00000D5F  89E5              mov ebp,esp
00000D61  53                push ebx
00000D62  56                push esi
00000D63  57                push edi
00000D64  8B5D10            mov ebx,[ebp+0x10]
00000D67  8B7D08            mov edi,[ebp+0x8]
00000D6A  8B750C            mov esi,[ebp+0xc]
00000D6D  E915000000        jmp 0xd87
00000D72  8A07              mov al,[edi]
00000D74  3A06              cmp al,[esi]
00000D76  740C              jz 0xd84
00000D78  8A07              mov al,[edi]
00000D7A  2A06              sub al,[esi]
00000D7C  0FB6C0            movzx eax,al
00000D7F  E910000000        jmp 0xd94
00000D84  47                inc edi
00000D85  46                inc esi
00000D86  4B                dec ebx
00000D87  85DB              test ebx,ebx
00000D89  0F85E3FFFFFF      jnz near 0xd72
00000D8F  B800000000        mov eax,0x0
00000D94  5F                pop edi
00000D95  5E                pop esi
00000D96  5B                pop ebx
00000D97  5D                pop ebp
00000D98  C3                ret
00000D99  55                push ebp
00000D9A  89E5              mov ebp,esp
00000D9C  83EC04            sub esp,byte +0x4
00000D9F  53                push ebx
00000DA0  56                push esi
00000DA1  57                push edi
00000DA2  8B5D10            mov ebx,[ebp+0x10]
00000DA5  8B4508            mov eax,[ebp+0x8]
00000DA8  8945FC            mov [ebp-0x4],eax
00000DAB  8B7D0C            mov edi,[ebp+0xc]
00000DAE  8B7508            mov esi,[ebp+0x8]
00000DB1  8B4508            mov eax,[ebp+0x8]
00000DB4  3B450C            cmp eax,[ebp+0xc]
00000DB7  0F831D000000      jnc near 0xdda
00000DBD  E90B000000        jmp 0xdcd
00000DC2  89F8              mov eax,edi
00000DC4  47                inc edi
00000DC5  89F1              mov ecx,esi
00000DC7  46                inc esi
00000DC8  8A00              mov al,[eax]
00000DCA  8801              mov [ecx],al
00000DCC  4B                dec ebx
00000DCD  85DB              test ebx,ebx
00000DCF  0F85EDFFFFFF      jnz near 0xdc2
00000DD5  E922000000        jmp 0xdfc
00000DDA  8D43FF            lea eax,[ebx-0x1]
00000DDD  01C6              add esi,eax
00000DDF  8D43FF            lea eax,[ebx-0x1]
00000DE2  01C7              add edi,eax
00000DE4  E90B000000        jmp 0xdf4
00000DE9  89F8              mov eax,edi
00000DEB  4F                dec edi
00000DEC  89F1              mov ecx,esi
00000DEE  4E                dec esi
00000DEF  8A00              mov al,[eax]
00000DF1  8801              mov [ecx],al
00000DF3  4B                dec ebx
00000DF4  85DB              test ebx,ebx
00000DF6  0F85EDFFFFFF      jnz near 0xde9
00000DFC  8B45FC            mov eax,[ebp-0x4]
00000DFF  5F                pop edi
00000E00  5E                pop esi
00000E01  5B                pop ebx
00000E02  89EC              mov esp,ebp
00000E04  5D                pop ebp
00000E05  C3                ret
00000E06  55                push ebp
00000E07  89E5              mov ebp,esp
00000E09  53                push ebx
00000E0A  56                push esi
00000E0B  57                push edi
00000E0C  8B5D10            mov ebx,[ebp+0x10]
00000E0F  8B7508            mov esi,[ebp+0x8]
00000E12  89F7              mov edi,esi
00000E14  E909000000        jmp 0xe22
00000E19  89F8              mov eax,edi
00000E1B  47                inc edi
00000E1C  8A4D0C            mov cl,[ebp+0xc]
00000E1F  8808              mov [eax],cl
00000E21  4B                dec ebx
00000E22  85DB              test ebx,ebx
00000E24  75F3              jnz 0xe19
00000E26  89F0              mov eax,esi
00000E28  5F                pop edi
00000E29  5E                pop esi
00000E2A  5B                pop ebx
00000E2B  5D                pop ebp
00000E2C  C3                ret
00000E2D  55                push ebp
00000E2E  89E5              mov ebp,esp
00000E30  83EC2C            sub esp,byte +0x2c
00000E33  53                push ebx
00000E34  56                push esi
00000E35  57                push edi
00000E36  8B7508            mov esi,[ebp+0x8]
00000E39  C745E400000000    mov dword [ebp-0x1c],0x0
00000E40  C745E000000000    mov dword [ebp-0x20],0x0
00000E47  BB00000000        mov ebx,0x0
00000E4C  C745D800000000    mov dword [ebp-0x28],0x0
00000E53  E9ED030000        jmp 0x1245
00000E58  8B45D8            mov eax,[ebp-0x28]
00000E5B  3D05000000        cmp eax,0x5
00000E60  0F83CB030000      jnc near 0x1231
00000E66  FF24856D0E00C0    jmp near [eax*4+0xc0000e6d]
00000E6D  810E00C0A30E      or dword [esi],0xea3c000
00000E73  00C0              add al,al
00000E75  1C0F              sbb al,0xf
00000E77  00C0              add al,al
00000E79  49                dec ecx
00000E7A  0F00C0            sldt ax
00000E7D  8B0F              mov ecx,[edi]
00000E7F  00C0              add al,al
00000E81  0FBE06            movsx eax,byte [esi]
00000E84  83F825            cmp eax,byte +0x25
00000E87  7416              jz 0xe9f
00000E89  8D4514            lea eax,[ebp+0x14]
00000E8C  50                push eax
00000E8D  0FBE06            movsx eax,byte [esi]
00000E90  50                push eax
00000E91  FF5510            call near [ebp+0x10]
00000E94  83C408            add esp,byte +0x8
00000E97  FF45E0            inc dword [ebp-0x20]
00000E9A  E9A5030000        jmp 0x1244
00000E9F  FF45D8            inc dword [ebp-0x28]
00000EA2  46                inc esi
00000EA3  0FBE06            movsx eax,byte [esi]
00000EA6  83F825            cmp eax,byte +0x25
00000EA9  0F8529000000      jnz near 0xed8
00000EAF  8D4514            lea eax,[ebp+0x14]
00000EB2  50                push eax
00000EB3  0FBE06            movsx eax,byte [esi]
00000EB6  50                push eax
00000EB7  FF5510            call near [ebp+0x10]
00000EBA  83C408            add esp,byte +0x8
00000EBD  FF45E0            inc dword [ebp-0x20]
00000EC0  C745E400000000    mov dword [ebp-0x1c],0x0
00000EC7  BB00000000        mov ebx,0x0
00000ECC  C745D800000000    mov dword [ebp-0x28],0x0
00000ED3  E96C030000        jmp 0x1244
00000ED8  0FBE06            movsx eax,byte [esi]
00000EDB  83F82D            cmp eax,byte +0x2d
00000EDE  0F8528000000      jnz near 0xf0c
00000EE4  89D8              mov eax,ebx
00000EE6  83E001            and eax,byte +0x1
00000EE9  7418              jz 0xf03
00000EEB  C745E400000000    mov dword [ebp-0x1c],0x0
00000EF2  BB00000000        mov ebx,0x0
00000EF7  C745D800000000    mov dword [ebp-0x28],0x0
00000EFE  E904000000        jmp 0xf07
00000F03  0FBAEB00          bts ebx,0x0
00000F07  E938030000        jmp 0x1244
00000F0C  FF45D8            inc dword [ebp-0x28]
00000F0F  0FBE06            movsx eax,byte [esi]
00000F12  83F830            cmp eax,byte +0x30
00000F15  7505              jnz 0xf1c
00000F17  0FBAEB06          bts ebx,0x6
00000F1B  46                inc esi
00000F1C  0FBE06            movsx eax,byte [esi]
00000F1F  83F830            cmp eax,byte +0x30
00000F22  0F8C1E000000      jl near 0xf46
00000F28  0FBE06            movsx eax,byte [esi]
00000F2B  83F839            cmp eax,byte +0x39
00000F2E  7F16              jg 0xf46
00000F30  8B45E4            mov eax,[ebp-0x1c]
00000F33  6BC00A            imul eax,eax,byte +0xa
00000F36  0FBE0E            movsx ecx,byte [esi]
00000F39  01C8              add eax,ecx
00000F3B  83C0D0            add eax,byte -0x30
00000F3E  8945E4            mov [ebp-0x1c],eax
00000F41  E9FE020000        jmp 0x1244
00000F46  FF45D8            inc dword [ebp-0x28]
00000F49  0FBE06            movsx eax,byte [esi]
00000F4C  83F846            cmp eax,byte +0x46
00000F4F  7509              jnz 0xf5a
00000F51  0FBAEB07          bts ebx,0x7
00000F55  E9EA020000        jmp 0x1244
00000F5A  0FBE06            movsx eax,byte [esi]
00000F5D  83F84E            cmp eax,byte +0x4e
00000F60  0F84DE020000      jz near 0x1244
00000F66  0FBE06            movsx eax,byte [esi]
00000F69  83F86C            cmp eax,byte +0x6c
00000F6C  7509              jnz 0xf77
00000F6E  0FBAEB03          bts ebx,0x3
00000F72  E9CD020000        jmp 0x1244
00000F77  0FBE06            movsx eax,byte [esi]
00000F7A  83F868            cmp eax,byte +0x68
00000F7D  7509              jnz 0xf88
00000F7F  0FBAEB04          bts ebx,0x4
00000F83  E9BC020000        jmp 0x1244
00000F88  FF45D8            inc dword [ebp-0x28]
00000F8B  8D45EC            lea eax,[ebp-0x14]
00000F8E  83E8F1            sub eax,byte -0xf
00000F91  8945E8            mov [ebp-0x18],eax
00000F94  8B45E8            mov eax,[ebp-0x18]
00000F97  C60000            mov byte [eax],0x0
00000F9A  8A06              mov al,[esi]
00000F9C  3C6F              cmp al,0x6f
00000F9E  0F8490000000      jz near 0x1034
00000FA4  0F8F40000000      jg near 0xfea
00000FAA  3C64              cmp al,0x64
00000FAC  0F8472000000      jz near 0x1024
00000FB2  7F1B              jg 0xfcf
00000FB4  3C63              cmp al,0x63
00000FB6  0F8463010000      jz near 0x111f
00000FBC  0F8F6F020000      jg near 0x1231
00000FC2  3C58              cmp al,0x58
00000FC4  0F844A000000      jz near 0x1014
00000FCA  E962020000        jmp 0x1231
00000FCF  3C6E              cmp al,0x6e
00000FD1  0F8441000000      jz near 0x1018
00000FD7  0F8F54020000      jg near 0x1231
00000FDD  3C69              cmp al,0x69
00000FDF  0F843F000000      jz near 0x1024
00000FE5  E947020000        jmp 0x1231
00000FEA  3C75              cmp al,0x75
00000FEC  0F8436000000      jz near 0x1028
00000FF2  7F17              jg 0x100b
00000FF4  3C73              cmp al,0x73
00000FF6  0F8441010000      jz near 0x113d
00000FFC  0F8F2F020000      jg near 0x1231
00001002  3C70              cmp al,0x70
00001004  7412              jz 0x1018
00001006  E926020000        jmp 0x1231
0000100B  3C78              cmp al,0x78
0000100D  7409              jz 0x1018
0000100F  E91D020000        jmp 0x1231
00001014  0FBAEB01          bts ebx,0x1
00001018  C745DC10000000    mov dword [ebp-0x24],0x10
0000101F  E917000000        jmp 0x103b
00001024  0FBAEB02          bts ebx,0x2
00001028  C745DC0A000000    mov dword [ebp-0x24],0xa
0000102F  E907000000        jmp 0x103b
00001034  C745DC08000000    mov dword [ebp-0x24],0x8
0000103B  89D8              mov eax,ebx
0000103D  83E008            and eax,byte +0x8
00001040  7411              jz 0x1053
00001042  83450C04          add dword [ebp+0xc],byte +0x4
00001046  8B450C            mov eax,[ebp+0xc]
00001049  8B00              mov eax,[eax]
0000104B  8945FC            mov [ebp-0x4],eax
0000104E  E958000000        jmp 0x10ab
00001053  89D8              mov eax,ebx
00001055  83E010            and eax,byte +0x10
00001058  0F8429000000      jz near 0x1087
0000105E  89D8              mov eax,ebx
00001060  83E004            and eax,byte +0x4
00001063  7411              jz 0x1076
00001065  83450C02          add dword [ebp+0xc],byte +0x2
00001069  8B450C            mov eax,[ebp+0xc]
0000106C  8B00              mov eax,[eax]
0000106E  8945FC            mov [ebp-0x4],eax
00001071  E90C000000        jmp 0x1082
00001076  83450C02          add dword [ebp+0xc],byte +0x2
0000107A  8B450C            mov eax,[ebp+0xc]
0000107D  8B00              mov eax,[eax]
0000107F  8945FC            mov [ebp-0x4],eax
00001082  E924000000        jmp 0x10ab
00001087  89D8              mov eax,ebx
00001089  83E004            and eax,byte +0x4
0000108C  7411              jz 0x109f
0000108E  83450C04          add dword [ebp+0xc],byte +0x4
00001092  8B450C            mov eax,[ebp+0xc]
00001095  8B00              mov eax,[eax]
00001097  8945FC            mov [ebp-0x4],eax
0000109A  E90C000000        jmp 0x10ab
0000109F  83450C04          add dword [ebp+0xc],byte +0x4
000010A3  8B450C            mov eax,[ebp+0xc]
000010A6  8B00              mov eax,[eax]
000010A8  8945FC            mov [ebp-0x4],eax
000010AB  89D8              mov eax,ebx
000010AD  83E004            and eax,byte +0x4
000010B0  740D              jz 0x10bf
000010B2  837DFC00          cmp dword [ebp-0x4],byte +0x0
000010B6  7D07              jnl 0x10bf
000010B8  0FBAEB05          bts ebx,0x5
000010BC  F75DFC            neg dword [ebp-0x4]
000010BF  8B45FC            mov eax,[ebp-0x4]
000010C2  29D2              sub edx,edx
000010C4  F775DC            div dword [ebp-0x24]
000010C7  8955D4            mov [ebp-0x2c],edx
000010CA  FF4DE8            dec dword [ebp-0x18]
000010CD  837DD40A          cmp dword [ebp-0x2c],byte +0xa
000010D1  7310              jnc 0x10e3
000010D3  8B45D4            mov eax,[ebp-0x2c]
000010D6  83C030            add eax,byte +0x30
000010D9  8B4DE8            mov ecx,[ebp-0x18]
000010DC  8801              mov [ecx],al
000010DE  E922000000        jmp 0x1105
000010E3  89D8              mov eax,ebx
000010E5  83E002            and eax,byte +0x2
000010E8  7410              jz 0x10fa
000010EA  8B45D4            mov eax,[ebp-0x2c]
000010ED  83C037            add eax,byte +0x37
000010F0  8B4DE8            mov ecx,[ebp-0x18]
000010F3  8801              mov [ecx],al
000010F5  E90B000000        jmp 0x1105
000010FA  8B45D4            mov eax,[ebp-0x2c]
000010FD  83C057            add eax,byte +0x57
00001100  8B4DE8            mov ecx,[ebp-0x18]
00001103  8801              mov [ecx],al
00001105  8B45FC            mov eax,[ebp-0x4]
00001108  29D2              sub edx,edx
0000110A  F775DC            div dword [ebp-0x24]
0000110D  8945FC            mov [ebp-0x4],eax
00001110  837DFC00          cmp dword [ebp-0x4],byte +0x0
00001114  0F85A5FFFFFF      jnz near 0x10bf
0000111A  E92E000000        jmp 0x114d
0000111F  0FBAF306          btr ebx,0x6
00001123  FF4DE8            dec dword [ebp-0x18]
00001126  FF450C            inc dword [ebp+0xc]
00001129  8B450C            mov eax,[ebp+0xc]
0000112C  8B00              mov eax,[eax]
0000112E  8B4DE8            mov ecx,[ebp-0x18]
00001131  8801              mov [ecx],al
00001133  BF01000000        mov edi,0x1
00001138  E93C000000        jmp 0x1179
0000113D  0FBAF306          btr ebx,0x6
00001141  83450C04          add dword [ebp+0xc],byte +0x4
00001145  8B450C            mov eax,[ebp+0xc]
00001148  8B00              mov eax,[eax]
0000114A  8945E8            mov [ebp-0x18],eax
0000114D  FF75E8            push dword [ebp-0x18]
00001150  E82FFBFFFF        call 0xc84
00001155  59                pop ecx
00001156  89C7              mov edi,eax
00001158  89D8              mov eax,ebx
0000115A  83E020            and eax,byte +0x20
0000115D  7401              jz 0x1160
0000115F  47                inc edi
00001160  89D8              mov eax,ebx
00001162  83E060            and eax,byte +0x60
00001165  83F860            cmp eax,byte +0x60
00001168  750F              jnz 0x1179
0000116A  8D4514            lea eax,[ebp+0x14]
0000116D  50                push eax
0000116E  6A2D              push byte +0x2d
00001170  FF5510            call near [ebp+0x10]
00001173  83C408            add esp,byte +0x8
00001176  FF45E0            inc dword [ebp-0x20]
00001179  89D8              mov eax,ebx
0000117B  83E001            and eax,byte +0x1
0000117E  0F8535000000      jnz near 0x11b9
00001184  E927000000        jmp 0x11b0
00001189  8D4514            lea eax,[ebp+0x14]
0000118C  50                push eax
0000118D  89D8              mov eax,ebx
0000118F  83E040            and eax,byte +0x40
00001192  740A              jz 0x119e
00001194  B830000000        mov eax,0x30
00001199  E905000000        jmp 0x11a3
0000119E  B820000000        mov eax,0x20
000011A3  50                push eax
000011A4  FF5510            call near [ebp+0x10]
000011A7  83C408            add esp,byte +0x8
000011AA  FF45E0            inc dword [ebp-0x20]
000011AD  FF4DE4            dec dword [ebp-0x1c]
000011B0  397DE4            cmp [ebp-0x1c],edi
000011B3  0F87D0FFFFFF      ja near 0x1189
000011B9  89D8              mov eax,ebx
000011BB  83E060            and eax,byte +0x60
000011BE  83F820            cmp eax,byte +0x20
000011C1  750F              jnz 0x11d2
000011C3  8D4514            lea eax,[ebp+0x14]
000011C6  50                push eax
000011C7  6A2D              push byte +0x2d
000011C9  FF5510            call near [ebp+0x10]
000011CC  83C408            add esp,byte +0x8
000011CF  FF45E0            inc dword [ebp-0x20]
000011D2  E917000000        jmp 0x11ee
000011D7  8D4514            lea eax,[ebp+0x14]
000011DA  50                push eax
000011DB  8B45E8            mov eax,[ebp-0x18]
000011DE  FF45E8            inc dword [ebp-0x18]
000011E1  0FBE00            movsx eax,byte [eax]
000011E4  50                push eax
000011E5  FF5510            call near [ebp+0x10]
000011E8  83C408            add esp,byte +0x8
000011EB  FF45E0            inc dword [ebp-0x20]
000011EE  8B45E8            mov eax,[ebp-0x18]
000011F1  0FBE00            movsx eax,byte [eax]
000011F4  85C0              test eax,eax
000011F6  0F85DBFFFFFF      jnz near 0x11d7
000011FC  397DE4            cmp [ebp-0x1c],edi
000011FF  730C              jnc 0x120d
00001201  C745E400000000    mov dword [ebp-0x1c],0x0
00001208  E903000000        jmp 0x1210
0000120D  297DE4            sub [ebp-0x1c],edi
00001210  E912000000        jmp 0x1227
00001215  8D4514            lea eax,[ebp+0x14]
00001218  50                push eax
00001219  6A20              push byte +0x20
0000121B  FF5510            call near [ebp+0x10]
0000121E  83C408            add esp,byte +0x8
00001221  FF45E0            inc dword [ebp-0x20]
00001224  FF4DE4            dec dword [ebp-0x1c]
00001227  837DE400          cmp dword [ebp-0x1c],byte +0x0
0000122B  0F85E4FFFFFF      jnz near 0x1215
00001231  C745E400000000    mov dword [ebp-0x1c],0x0
00001238  BB00000000        mov ebx,0x0
0000123D  C745D800000000    mov dword [ebp-0x28],0x0
00001244  46                inc esi
00001245  803E00            cmp byte [esi],0x0
00001248  0F850AFCFFFF      jnz near 0xe58
0000124E  8B45E0            mov eax,[ebp-0x20]
00001251  5F                pop edi
00001252  5E                pop esi
00001253  5B                pop ebx
00001254  89EC              mov esp,ebp
00001256  5D                pop ebp
00001257  C3                ret
00001258  53                push ebx
00001259  BB00000000        mov ebx,0x0
0000125E  E908000000        jmp 0x126b
00001263  C683622600C000    mov byte [ebx+0xc0002662],0x0
0000126A  43                inc ebx
0000126B  81FB80000000      cmp ebx,0x80
00001271  7CF0              jl 0x1263
00001273  5B                pop ebx
00001274  C3                ret
00001275  55                push ebp
00001276  89E5              mov ebp,esp
00001278  53                push ebx
00001279  8B5D08            mov ebx,[ebp+0x8]
0000127C  89D8              mov eax,ebx
0000127E  C1F803            sar eax,0x3
00001281  89D9              mov ecx,ebx
00001283  83E107            and ecx,byte +0x7
00001286  BA01000000        mov edx,0x1
0000128B  D3E2              shl edx,cl
0000128D  0FB680622600C0    movzx eax,byte [eax+0xc0002662]
00001294  09D0              or eax,edx
00001296  89D9              mov ecx,ebx
00001298  C1F903            sar ecx,0x3
0000129B  8881622600C0      mov [ecx+0xc0002662],al
000012A1  5B                pop ebx
000012A2  5D                pop ebp
000012A3  C3                ret
000012A4  55                push ebp
000012A5  89E5              mov ebp,esp
000012A7  53                push ebx
000012A8  8B5D08            mov ebx,[ebp+0x8]
000012AB  89D8              mov eax,ebx
000012AD  C1F803            sar eax,0x3
000012B0  89D9              mov ecx,ebx
000012B2  83E107            and ecx,byte +0x7
000012B5  BA01000000        mov edx,0x1
000012BA  D3E2              shl edx,cl
000012BC  F7D2              not edx
000012BE  0FB680622600C0    movzx eax,byte [eax+0xc0002662]
000012C5  21D0              and eax,edx
000012C7  89D9              mov ecx,ebx
000012C9  C1F903            sar ecx,0x3
000012CC  8881622600C0      mov [ecx+0xc0002662],al
000012D2  5B                pop ebx
000012D3  5D                pop ebp
000012D4  C3                ret
000012D5  55                push ebp
000012D6  89E5              mov ebp,esp
000012D8  53                push ebx
000012D9  8B5D08            mov ebx,[ebp+0x8]
000012DC  89D8              mov eax,ebx
000012DE  C1F803            sar eax,0x3
000012E1  89D9              mov ecx,ebx
000012E3  83E107            and ecx,byte +0x7
000012E6  BA01000000        mov edx,0x1
000012EB  D3E2              shl edx,cl
000012ED  0FB680622600C0    movzx eax,byte [eax+0xc0002662]
000012F4  21D0              and eax,edx
000012F6  740A              jz 0x1302
000012F8  B801000000        mov eax,0x1
000012FD  E905000000        jmp 0x1307
00001302  B800000000        mov eax,0x0
00001307  5B                pop ebx
00001308  5D                pop ebp
00001309  C3                ret
0000130A  55                push ebp
0000130B  89E5              mov ebp,esp
0000130D  53                push ebx
0000130E  8B5D08            mov ebx,[ebp+0x8]
00001311  C1EB0C            shr ebx,0xc
00001314  53                push ebx
00001315  E85BFFFFFF        call 0x1275
0000131A  59                pop ecx
0000131B  5B                pop ebx
0000131C  5D                pop ebp
0000131D  C3                ret
0000131E  55                push ebp
0000131F  89E5              mov ebp,esp
00001321  83EC04            sub esp,byte +0x4
00001324  53                push ebx
00001325  BB00000000        mov ebx,0x0
0000132A  E918000000        jmp 0x1347
0000132F  53                push ebx
00001330  E8A0FFFFFF        call 0x12d5
00001335  59                pop ecx
00001336  85C0              test eax,eax
00001338  750C              jnz 0x1346
0000133A  53                push ebx
0000133B  E835FFFFFF        call 0x1275
00001340  59                pop ecx
00001341  E90D000000        jmp 0x1353
00001346  43                inc ebx
00001347  81FB00040000      cmp ebx,0x400
0000134D  0F8CDCFFFFFF      jl near 0x132f
00001353  89D8              mov eax,ebx
00001355  C1E00C            shl eax,0xc
00001358  5B                pop ebx
00001359  89EC              mov esp,ebp
0000135B  5D                pop ebp
0000135C  C3                ret
0000135D  53                push ebx
0000135E  56                push esi
0000135F  BE00000000        mov esi,0x0
00001364  BB00000000        mov ebx,0x0
00001369  E912000000        jmp 0x1380
0000136E  53                push ebx
0000136F  E861FFFFFF        call 0x12d5
00001374  59                pop ecx
00001375  85C0              test eax,eax
00001377  7506              jnz 0x137f
00001379  81C600100000      add esi,0x1000
0000137F  43                inc ebx
00001380  81FB00040000      cmp ebx,0x400
00001386  0F8CE2FFFFFF      jl near 0x136e
0000138C  89F0              mov eax,esi
0000138E  5E                pop esi
0000138F  5B                pop ebx
00001390  C3                ret
00001391  53                push ebx
00001392  56                push esi
00001393  BE00000000        mov esi,0x0
00001398  BB00000000        mov ebx,0x0
0000139D  E913000000        jmp 0x13b5
000013A2  53                push ebx
000013A3  E82DFFFFFF        call 0x12d5
000013A8  59                pop ecx
000013A9  83F801            cmp eax,byte +0x1
000013AC  7506              jnz 0x13b4
000013AE  81C600100000      add esi,0x1000
000013B4  43                inc ebx
000013B5  81FB00040000      cmp ebx,0x400
000013BB  0F8CE1FFFFFF      jl near 0x13a2
000013C1  89F0              mov eax,esi
000013C3  5E                pop esi
000013C4  5B                pop ebx
000013C5  C3                ret
000013C6  55                push ebp
000013C7  89E5              mov ebp,esp
000013C9  83EC08            sub esp,byte +0x8
000013CC  53                push ebx
000013CD  56                push esi
000013CE  57                push edi
000013CF  8B7D08            mov edi,[ebp+0x8]
000013D2  89F8              mov eax,edi
000013D4  05FF0F0000        add eax,0xfff
000013D9  C1E80C            shr eax,0xc
000013DC  8945F8            mov [ebp-0x8],eax
000013DF  8B35F22600C0      mov esi,[0xc00026f2]
000013E5  85FF              test edi,edi
000013E7  750A              jnz 0x13f3
000013E9  B800000000        mov eax,0x0
000013EE  E961000000        jmp 0x1454
000013F3  E903000000        jmp 0x13fb
000013F8  8B7604            mov esi,[esi+0x4]
000013FB  837E0400          cmp dword [esi+0x4],byte +0x0
000013FF  75F7              jnz 0x13f8
00001401  E939000000        jmp 0x143f
00001406  E813FFFFFF        call 0x131e
0000140B  89C3              mov ebx,eax
0000140D  85DB              test ebx,ebx
0000140F  750A              jnz 0x141b
00001411  B800000000        mov eax,0x0
00001416  E939000000        jmp 0x1454
0000141B  89D8              mov eax,ebx
0000141D  83C807            or eax,byte +0x7
00001420  8B0DEE2600C0      mov ecx,[0xc00026ee]
00001426  8B15FA2600C0      mov edx,[0xc00026fa]
0000142C  890491            mov [ecx+edx*4],eax
0000142F  FF05FA2600C0      inc dword [0xc00026fa]
00001435  8105F62600C00010  add dword [0xc00026f6],0x1000
         -0000
0000143F  8B45F8            mov eax,[ebp-0x8]
00001442  FF4DF8            dec dword [ebp-0x8]
00001445  85C0              test eax,eax
00001447  0F85B9FFFFFF      jnz near 0x1406
0000144D  E8700D0000        call 0x21c2
00001452  89F0              mov eax,esi
00001454  5F                pop edi
00001455  5E                pop esi
00001456  5B                pop ebx
00001457  89EC              mov esp,ebp
00001459  5D                pop ebp
0000145A  C3                ret
0000145B  55                push ebp
0000145C  89E5              mov ebp,esp
0000145E  83EC04            sub esp,byte +0x4
00001461  53                push ebx
00001462  56                push esi
00001463  57                push edi
00001464  8B5D08            mov ebx,[ebp+0x8]
00001467  85DB              test ebx,ebx
00001469  750A              jnz 0x1475
0000146B  B800000000        mov eax,0x0
00001470  E9EE000000        jmp 0x1563
00001475  8B35F22600C0      mov esi,[0xc00026f2]
0000147B  391E              cmp [esi],ebx
0000147D  720C              jc 0x148b
0000147F  8B4608            mov eax,[esi+0x8]
00001482  83E001            and eax,byte +0x1
00001485  0F8473000000      jz near 0x14fe
0000148B  8B7604            mov esi,[esi+0x4]
0000148E  837E0400          cmp dword [esi+0x4],byte +0x0
00001492  75E7              jnz 0x147b
00001494  391E              cmp [esi],ebx
00001496  720C              jc 0x14a4
00001498  8B4608            mov eax,[esi+0x8]
0000149B  83E001            and eax,byte +0x1
0000149E  0F845A000000      jz near 0x14fe
000014A4  8D430C            lea eax,[ebx+0xc]
000014A7  50                push eax
000014A8  E819FFFFFF        call 0x13c6
000014AD  59                pop ecx
000014AE  8945FC            mov [ebp-0x4],eax
000014B1  837DFC00          cmp dword [ebp-0x4],byte +0x0
000014B5  750A              jnz 0x14c1
000014B7  B800000000        mov eax,0x0
000014BC  E9A2000000        jmp 0x1563
000014C1  8975FC            mov [ebp-0x4],esi
000014C4  891E              mov [esi],ebx
000014C6  89F0              mov eax,esi
000014C8  01D8              add eax,ebx
000014CA  83C00C            add eax,byte +0xc
000014CD  894604            mov [esi+0x4],eax
000014D0  C7460801FFFFFF    mov dword [esi+0x8],0xffffff01
000014D7  89F7              mov edi,esi
000014D9  8B7604            mov esi,[esi+0x4]
000014DC  C7460800FFFFFF    mov dword [esi+0x8],0xffffff00
000014E3  C7460400000000    mov dword [esi+0x4],0x0
000014EA  A1F62600C0        mov eax,[0xc00026f6]
000014EF  29F0              sub eax,esi
000014F1  83E80C            sub eax,byte +0xc
000014F4  8906              mov [esi],eax
000014F6  8D470C            lea eax,[edi+0xc]
000014F9  E965000000        jmp 0x1563
000014FE  837E0400          cmp dword [esi+0x4],byte +0x0
00001502  7412              jz 0x1516
00001504  8B4608            mov eax,[esi+0x8]
00001507  0FBAE800          bts eax,0x0
0000150B  894608            mov [esi+0x8],eax
0000150E  8D460C            lea eax,[esi+0xc]
00001511  E94D000000        jmp 0x1563
00001516  8D430C            lea eax,[ebx+0xc]
00001519  3906              cmp [esi],eax
0000151B  0F8283FFFFFF      jc near 0x14a4
00001521  89F0              mov eax,esi
00001523  01D8              add eax,ebx
00001525  83C00C            add eax,byte +0xc
00001528  894604            mov [esi+0x4],eax
0000152B  891E              mov [esi],ebx
0000152D  8B4608            mov eax,[esi+0x8]
00001530  0FBAE800          bts eax,0x0
00001534  894608            mov [esi+0x8],eax
00001537  89F7              mov edi,esi
00001539  8B7604            mov esi,[esi+0x4]
0000153C  C7460400000000    mov dword [esi+0x4],0x0
00001543  C7460800FFFFFF    mov dword [esi+0x8],0xffffff00
0000154A  A1F62600C0        mov eax,[0xc00026f6]
0000154F  29F0              sub eax,esi
00001551  83E80C            sub eax,byte +0xc
00001554  8906              mov [esi],eax
00001556  8D470C            lea eax,[edi+0xc]
00001559  E905000000        jmp 0x1563
0000155E  B800000000        mov eax,0x0
00001563  5F                pop edi
00001564  5E                pop esi
00001565  5B                pop ebx
00001566  89EC              mov esp,ebp
00001568  5D                pop ebp
00001569  C3                ret
0000156A  55                push ebp
0000156B  89E5              mov ebp,esp
0000156D  56                push esi
0000156E  8B7508            mov esi,[ebp+0x8]
00001571  83EE0C            sub esi,byte +0xc
00001574  8B4608            mov eax,[esi+0x8]
00001577  2500FFFFFF        and eax,0xffffff00
0000157C  3D00FFFFFF        cmp eax,0xffffff00
00001581  740A              jz 0x158d
00001583  B800000000        mov eax,0x0
00001588  E90C000000        jmp 0x1599
0000158D  C7460800FFFFFF    mov dword [esi+0x8],0xffffff00
00001594  B801000000        mov eax,0x1
00001599  5E                pop esi
0000159A  5D                pop ebp
0000159B  C3                ret
0000159C  55                push ebp
0000159D  89E5              mov ebp,esp
0000159F  56                push esi
000015A0  6A08              push byte +0x8
000015A2  E8B4FEFFFF        call 0x145b
000015A7  59                pop ecx
000015A8  89C6              mov esi,eax
000015AA  85F6              test esi,esi
000015AC  750A              jnz 0x15b8
000015AE  B800000000        mov eax,0x0
000015B3  E941000000        jmp 0x15f9
000015B8  66C7060000        mov word [esi],0x0
000015BD  C6460607          mov byte [esi+0x6],0x7
000015C1  8A4508            mov al,[ebp+0x8]
000015C4  884607            mov [esi+0x7],al
000015C7  68A00F0000        push dword 0xfa0
000015CC  E88AFEFFFF        call 0x145b
000015D1  59                pop ecx
000015D2  894602            mov [esi+0x2],eax
000015D5  837E0200          cmp dword [esi+0x2],byte +0x0
000015D9  750A              jnz 0x15e5
000015DB  B800000000        mov eax,0x0
000015E0  E914000000        jmp 0x15f9
000015E5  68A00F0000        push dword 0xfa0
000015EA  6A00              push byte +0x0
000015EC  FF7602            push dword [esi+0x2]
000015EF  E812F8FFFF        call 0xe06
000015F4  83C40C            add esp,byte +0xc
000015F7  89F0              mov eax,esi
000015F9  5E                pop esi
000015FA  5D                pop ebp
000015FB  C3                ret
000015FC  55                push ebp
000015FD  89E5              mov ebp,esp
000015FF  56                push esi
00001600  8B7508            mov esi,[ebp+0x8]
00001603  FF7602            push dword [esi+0x2]
00001606  E85FFFFFFF        call 0x156a
0000160B  59                pop ecx
0000160C  56                push esi
0000160D  E858FFFFFF        call 0x156a
00001612  59                pop ecx
00001613  B801000000        mov eax,0x1
00001618  5E                pop esi
00001619  5D                pop ebp
0000161A  C3                ret
0000161B  68000F0000        push dword 0xf00
00001620  A1FE2600C0        mov eax,[0xc00026fe]
00001625  8B4002            mov eax,[eax+0x2]
00001628  05A0000000        add eax,0xa0
0000162D  50                push eax
0000162E  A1FE2600C0        mov eax,[0xc00026fe]
00001633  FF7002            push dword [eax+0x2]
00001636  E85EF7FFFF        call 0xd99
0000163B  83C40C            add esp,byte +0xc
0000163E  68A0000000        push dword 0xa0
00001643  6A00              push byte +0x0
00001645  A1FE2600C0        mov eax,[0xc00026fe]
0000164A  8B4002            mov eax,[eax+0x2]
0000164D  05000F0000        add eax,0xf00
00001652  50                push eax
00001653  E8AEF7FFFF        call 0xe06
00001658  83C40C            add esp,byte +0xc
0000165B  C3                ret
0000165C  A1FE2600C0        mov eax,[0xc00026fe]
00001661  0FB700            movzx eax,word [eax]
00001664  3DA00F0000        cmp eax,0xfa0
00001669  730E              jnc 0x1679
0000166B  A1FE2600C0        mov eax,[0xc00026fe]
00001670  66830002          add word [eax],byte +0x2
00001674  E90F000000        jmp 0x1688
00001679  E89DFFFFFF        call 0x161b
0000167E  A1FE2600C0        mov eax,[0xc00026fe]
00001683  66C700000F        mov word [eax],0xf00
00001688  C3                ret
00001689  55                push ebp
0000168A  89E5              mov ebp,esp
0000168C  53                push ebx
0000168D  56                push esi
0000168E  8B5D0C            mov ebx,[ebp+0xc]
00001691  8B7508            mov esi,[ebp+0x8]
00001694  4E                dec esi
00001695  4B                dec ebx
00001696  83FE4F            cmp esi,byte +0x4f
00001699  7F0D              jg 0x16a8
0000169B  85F6              test esi,esi
0000169D  7C09              jl 0x16a8
0000169F  83FB18            cmp ebx,byte +0x18
000016A2  7F04              jg 0x16a8
000016A4  85DB              test ebx,ebx
000016A6  7D05              jnl 0x16ad
000016A8  E917000000        jmp 0x16c4
000016AD  89F0              mov eax,esi
000016AF  D1E0              shl eax,1
000016B1  89D9              mov ecx,ebx
000016B3  69C9A0000000      imul ecx,ecx,0xa0
000016B9  01C8              add eax,ecx
000016BB  8B0DFE2600C0      mov ecx,[0xc00026fe]
000016C1  668901            mov [ecx],ax
000016C4  5E                pop esi
000016C5  5B                pop ebx
000016C6  5D                pop ebp
000016C7  C3                ret
000016C8  55                push ebp
000016C9  89E5              mov ebp,esp
000016CB  A1FE2600C0        mov eax,[0xc00026fe]
000016D0  8A4D08            mov cl,[ebp+0x8]
000016D3  884806            mov [eax+0x6],cl
000016D6  5D                pop ebp
000016D7  C3                ret
000016D8  55                push ebp
000016D9  89E5              mov ebp,esp
000016DB  8A4508            mov al,[ebp+0x8]
000016DE  240F              and al,0xf
000016E0  8B0DFE2600C0      mov ecx,[0xc00026fe]
000016E6  884106            mov [ecx+0x6],al
000016E9  5D                pop ebp
000016EA  C3                ret
000016EB  55                push ebp
000016EC  89E5              mov ebp,esp
000016EE  0FBE4508          movsx eax,byte [ebp+0x8]
000016F2  C1E004            shl eax,0x4
000016F5  8B0DFE2600C0      mov ecx,[0xc00026fe]
000016FB  084106            or [ecx+0x6],al
000016FE  5D                pop ebp
000016FF  C3                ret
00001700  68A00F0000        push dword 0xfa0
00001705  6A00              push byte +0x0
00001707  A1FE2600C0        mov eax,[0xc00026fe]
0000170C  FF7002            push dword [eax+0x2]
0000170F  E8F2F6FFFF        call 0xe06
00001714  83C40C            add esp,byte +0xc
00001717  C3                ret
00001718  55                push ebp
00001719  89E5              mov ebp,esp
0000171B  53                push ebx
0000171C  8B5D08            mov ebx,[ebp+0x8]
0000171F  81FB08000000      cmp ebx,0x8
00001725  0F845F000000      jz near 0x178a
0000172B  81FB0A000000      cmp ebx,0xa
00001731  7411              jz 0x1744
00001733  81FB0D000000      cmp ebx,0xd
00001739  0F842D000000      jz near 0x176c
0000173F  E95E000000        jmp 0x17a2
00001744  A1FE2600C0        mov eax,[0xc00026fe]
00001749  0FB700            movzx eax,word [eax]
0000174C  3D000F0000        cmp eax,0xf00
00001751  720A              jc 0x175d
00001753  E8C3FEFFFF        call 0x161b
00001758  E90A000000        jmp 0x1767
0000175D  A1FE2600C0        mov eax,[0xc00026fe]
00001762  668100A000        add word [eax],0xa0
00001767  E96E000000        jmp 0x17da
0000176C  A1FE2600C0        mov eax,[0xc00026fe]
00001771  668B00            mov ax,[eax]
00001774  29D2              sub edx,edx
00001776  66F735301800C0    div word [0xc0001830]
0000177D  A1FE2600C0        mov eax,[0xc00026fe]
00001782  662910            sub [eax],dx
00001785  E950000000        jmp 0x17da
0000178A  A1FE2600C0        mov eax,[0xc00026fe]
0000178F  66833800          cmp word [eax],byte +0x0
00001793  7408              jz 0x179d
00001795  A1FE2600C0        mov eax,[0xc00026fe]
0000179A  66FF08            dec word [eax]
0000179D  E938000000        jmp 0x17da
000017A2  A1FE2600C0        mov eax,[0xc00026fe]
000017A7  8B4002            mov eax,[eax+0x2]
000017AA  8B0DFE2600C0      mov ecx,[0xc00026fe]
000017B0  0FB709            movzx ecx,word [ecx]
000017B3  881C08            mov [eax+ecx],bl
000017B6  A1FE2600C0        mov eax,[0xc00026fe]
000017BB  8B0DFE2600C0      mov ecx,[0xc00026fe]
000017C1  8B4902            mov ecx,[ecx+0x2]
000017C4  8B15FE2600C0      mov edx,[0xc00026fe]
000017CA  0FB712            movzx edx,word [edx]
000017CD  01D1              add ecx,edx
000017CF  8A4006            mov al,[eax+0x6]
000017D2  884101            mov [ecx+0x1],al
000017D5  E882FEFFFF        call 0x165c
000017DA  89D8              mov eax,ebx
000017DC  5B                pop ebx
000017DD  5D                pop ebp
000017DE  C3                ret
000017DF  55                push ebp
000017E0  89E5              mov ebp,esp
000017E2  56                push esi
000017E3  8B7508            mov esi,[ebp+0x8]
000017E6  E90B000000        jmp 0x17f6
000017EB  0FBE06            movsx eax,byte [esi]
000017EE  50                push eax
000017EF  E824FFFFFF        call 0x1718
000017F4  59                pop ecx
000017F5  46                inc esi
000017F6  803E00            cmp byte [esi],0x0
000017F9  75F0              jnz 0x17eb
000017FB  5E                pop esi
000017FC  5D                pop ebp
000017FD  C3                ret
000017FE  55                push ebp
000017FF  89E5              mov ebp,esp
00001801  FF7508            push dword [ebp+0x8]
00001804  E80FFFFFFF        call 0x1718
00001809  59                pop ecx
0000180A  B800000000        mov eax,0x0
0000180F  5D                pop ebp
00001810  C3                ret
00001811  55                push ebp
00001812  89E5              mov ebp,esp
00001814  53                push ebx
00001815  8D5D08            lea ebx,[ebp+0x8]
00001818  6A00              push byte +0x0
0000181A  8D05FE1700C0      lea eax,[0xc00017fe]
00001820  50                push eax
00001821  53                push ebx
00001822  FF7508            push dword [ebp+0x8]
00001825  E803F6FFFF        call 0xe2d
0000182A  83C410            add esp,byte +0x10
0000182D  5B                pop ebx
0000182E  5D                pop ebp
0000182F  C3                ret
00001830  A000000055        mov al,[0x55000000]
00001835  89E5              mov ebp,esp
00001837  53                push ebx
00001838  56                push esi
00001839  57                push edi
0000183A  8B5D08            mov ebx,[ebp+0x8]
0000183D  85DB              test ebx,ebx
0000183F  750A              jnz 0x184b
00001841  B800000000        mov eax,0x0
00001846  E94F000000        jmp 0x189a
0000184B  8B3D062700C0      mov edi,[0xc0002706]
00001851  8B770B            mov esi,[edi+0xb]
00001854  395E06            cmp [esi+0x6],ebx
00001857  0F8526000000      jnz near 0x1883
0000185D  8B460B            mov eax,[esi+0xb]
00001860  89470B            mov [edi+0xb],eax
00001863  FF760F            push dword [esi+0xf]
00001866  E891FDFFFF        call 0x15fc
0000186B  59                pop ecx
0000186C  56                push esi
0000186D  E8F8FCFFFF        call 0x156a
00001872  59                pop ecx
00001873  FF0D022700C0      dec dword [0xc0002702]
00001879  B801000000        mov eax,0x1
0000187E  E917000000        jmp 0x189a
00001883  8B7F0B            mov edi,[edi+0xb]
00001886  8B760B            mov esi,[esi+0xb]
00001889  3935062700C0      cmp [0xc0002706],esi
0000188F  0F85BFFFFFFF      jnz near 0x1854
00001895  B800000000        mov eax,0x0
0000189A  5F                pop edi
0000189B  5E                pop esi
0000189C  5B                pop ebx
0000189D  5D                pop ebp
0000189E  C3                ret
0000189F  55                push ebp
000018A0  89E5              mov ebp,esp
000018A2  83EC04            sub esp,byte +0x4
000018A5  53                push ebx
000018A6  56                push esi
000018A7  57                push edi
000018A8  8B7D0C            mov edi,[ebp+0xc]
000018AB  8C4DFC            mov dword [ebp-0x4],cs
000018AE  8C55FE            mov dword [ebp-0x2],ss
000018B1  83EF04            sub edi,byte +0x4
000018B4  89F8              mov eax,edi
000018B6  83EF04            sub edi,byte +0x4
000018B9  C70002020000      mov dword [eax],0x202
000018BF  89F8              mov eax,edi
000018C1  83EF04            sub edi,byte +0x4
000018C4  0FB74DFC          movzx ecx,word [ebp-0x4]
000018C8  8908              mov [eax],ecx
000018CA  89F8              mov eax,edi
000018CC  83EF04            sub edi,byte +0x4
000018CF  8B4D08            mov ecx,[ebp+0x8]
000018D2  8908              mov [eax],ecx
000018D4  83EF18            sub edi,byte +0x18
000018D7  6A13              push byte +0x13
000018D9  E87DFBFFFF        call 0x145b
000018DE  59                pop ecx
000018DF  89C6              mov esi,eax
000018E1  85F6              test esi,esi
000018E3  750A              jnz 0x18ef
000018E5  B800000000        mov eax,0x0
000018EA  E950000000        jmp 0x193f
000018EF  A10A2700C0        mov eax,[0xc000270a]
000018F4  89700B            mov [eax+0xb],esi
000018F7  A1062700C0        mov eax,[0xc0002706]
000018FC  89460B            mov [esi+0xb],eax
000018FF  893E              mov [esi],edi
00001901  668B45FE          mov ax,[ebp-0x2]
00001905  66894604          mov [esi+0x4],ax
00001909  FF05DE2700C0      inc dword [0xc00027de]
0000190F  A1DE2700C0        mov eax,[0xc00027de]
00001914  894606            mov [esi+0x6],eax
00001917  C6460A02          mov byte [esi+0xa],0x2
0000191B  89350A2700C0      mov [0xc000270a],esi
00001921  6A03              push byte +0x3
00001923  E874FCFFFF        call 0x159c
00001928  59                pop ecx
00001929  89460F            mov [esi+0xf],eax
0000192C  8B5E0F            mov ebx,[esi+0xf]
0000192F  C7430200800B00    mov dword [ebx+0x2],0xb8000
00001936  FF05022700C0      inc dword [0xc0002702]
0000193C  8B4606            mov eax,[esi+0x6]
0000193F  5F                pop edi
00001940  5E                pop esi
00001941  5B                pop ebx
00001942  89EC              mov esp,ebp
00001944  5D                pop ebp
00001945  C3                ret
00001946  FA                cli
00001947  833D022700C002    cmp dword [0xc0002702],byte +0x2
0000194E  7D06              jnl 0x1956
00001950  FB                sti
00001951  E930000000        jmp 0x1986
00001956  A1122700C0        mov eax,[0xc0002712]
0000195B  80600AFE          and byte [eax+0xa],0xfe
0000195F  A1122700C0        mov eax,[0xc0002712]
00001964  8B400B            mov eax,[eax+0xb]
00001967  A30E2700C0        mov [0xc000270e],eax
0000196C  A10E2700C0        mov eax,[0xc000270e]
00001971  0FBA680A00        bts dword [eax+0xa],0x0
00001976  A10E2700C0        mov eax,[0xc000270e]
0000197B  8B400F            mov eax,[eax+0xf]
0000197E  A3FE2600C0        mov [0xc00026fe],eax
00001983  FB                sti
00001984  CD30              int 0x30
00001986  C3                ret
00001987  55                push ebp
00001988  89E5              mov ebp,esp
0000198A  53                push ebx
0000198B  56                push esi
0000198C  57                push edi
0000198D  8B5D08            mov ebx,[ebp+0x8]
00001990  85DB              test ebx,ebx
00001992  750A              jnz 0x199e
00001994  A1062700C0        mov eax,[0xc0002706]
00001999  E928000000        jmp 0x19c6
0000199E  8B3D062700C0      mov edi,[0xc0002706]
000019A4  8B770B            mov esi,[edi+0xb]
000019A7  395E06            cmp [esi+0x6],ebx
000019AA  7507              jnz 0x19b3
000019AC  89F0              mov eax,esi
000019AE  E913000000        jmp 0x19c6
000019B3  8B7F0B            mov edi,[edi+0xb]
000019B6  8B760B            mov esi,[esi+0xb]
000019B9  3B35062700C0      cmp esi,[0xc0002706]
000019BF  75E6              jnz 0x19a7
000019C1  B800000000        mov eax,0x0
000019C6  5F                pop edi
000019C7  5E                pop esi
000019C8  5B                pop ebx
000019C9  5D                pop ebp
000019CA  C3                ret
000019CB  55                push ebp
000019CC  89E5              mov ebp,esp
000019CE  53                push ebx
000019CF  56                push esi
000019D0  8B5D08            mov ebx,[ebp+0x8]
000019D3  85DB              test ebx,ebx
000019D5  7412              jz 0x19e9
000019D7  53                push ebx
000019D8  E8AAFFFFFF        call 0x1987
000019DD  59                pop ecx
000019DE  89C6              mov esi,eax
000019E0  85F6              test esi,esi
000019E2  7405              jz 0x19e9
000019E4  0FBA6E0A02        bts dword [esi+0xa],0x2
000019E9  5E                pop esi
000019EA  5B                pop ebx
000019EB  5D                pop ebp
000019EC  C3                ret
000019ED  55                push ebp
000019EE  89E5              mov ebp,esp
000019F0  53                push ebx
000019F1  56                push esi
000019F2  8B5D08            mov ebx,[ebp+0x8]
000019F5  85DB              test ebx,ebx
000019F7  7411              jz 0x1a0a
000019F9  53                push ebx
000019FA  E888FFFFFF        call 0x1987
000019FF  59                pop ecx
00001A00  89C6              mov esi,eax
00001A02  85F6              test esi,esi
00001A04  7404              jz 0x1a0a
00001A06  80660A03          and byte [esi+0xa],0x3
00001A0A  5E                pop esi
00001A0B  5B                pop ebx
00001A0C  5D                pop ebp
00001A0D  C3                ret
00001A0E  55                push ebp
00001A0F  89E5              mov ebp,esp
00001A11  83EC08            sub esp,byte +0x8
00001A14  53                push ebx
00001A15  BB00000000        mov ebx,0x0
00001A1A  8B450C            mov eax,[ebp+0xc]
00001A1D  C1E002            shl eax,0x2
00001A20  0B4508            or eax,[ebp+0x8]
00001A23  8845F8            mov [ebp-0x8],al
00001A26  6A1C              push byte +0x1c
00001A28  68F2030000        push dword 0x3f2
00001A2D  E808F1FFFF        call 0xb3a
00001A32  83C408            add esp,byte +0x8
00001A35  6A14              push byte +0x14
00001A37  E8AAE6FFFF        call 0xe6
00001A3C  59                pop ecx
00001A3D  68F4030000        push dword 0x3f4
00001A42  E80FF1FFFF        call 0xb56
00001A47  59                pop ecx
00001A48  8845F9            mov [ebp-0x7],al
00001A4B  0FB645F9          movzx eax,byte [ebp-0x7]
00001A4F  50                push eax
00001A50  8D053C1E00C0      lea eax,[0xc0001e3c]
00001A56  50                push eax
00001A57  E8B5FDFFFF        call 0x1811
00001A5C  83C408            add esp,byte +0x8
00001A5F  0FB645F9          movzx eax,byte [ebp-0x7]
00001A63  83E010            and eax,byte +0x10
00001A66  740A              jz 0x1a72
00001A68  BB13000000        mov ebx,0x13
00001A6D  E9F1020000        jmp 0x1d63
00001A72  6A07              push byte +0x7
00001A74  E821030000        call 0x1d9a
00001A79  59                pop ecx
00001A7A  FF7508            push dword [ebp+0x8]
00001A7D  E818030000        call 0x1d9a
00001A82  59                pop ecx
00001A83  E862030000        call 0x1dea
00001A88  6A0F              push byte +0xf
00001A8A  E80B030000        call 0x1d9a
00001A8F  59                pop ecx
00001A90  0FB645F8          movzx eax,byte [ebp-0x8]
00001A94  50                push eax
00001A95  E800030000        call 0x1d9a
00001A9A  59                pop ecx
00001A9B  FF7510            push dword [ebp+0x10]
00001A9E  E8F7020000        call 0x1d9a
00001AA3  59                pop ecx
00001AA4  6A08              push byte +0x8
00001AA6  E83BE6FFFF        call 0xe6
00001AAB  59                pop ecx
00001AAC  68F4030000        push dword 0x3f4
00001AB1  E8A0F0FFFF        call 0xb56
00001AB6  59                pop ecx
00001AB7  8845F9            mov [ebp-0x7],al
00001ABA  0FB645F9          movzx eax,byte [ebp-0x7]
00001ABE  2580000000        and eax,0x80
00001AC3  750A              jnz 0x1acf
00001AC5  BB12000000        mov ebx,0x12
00001ACA  E994020000        jmp 0x1d63
00001ACF  0FB645F9          movzx eax,byte [ebp-0x7]
00001AD3  50                push eax
00001AD4  8D05221E00C0      lea eax,[0xc0001e22]
00001ADA  50                push eax
00001ADB  E831FDFFFF        call 0x1811
00001AE0  83C408            add esp,byte +0x8
00001AE3  E802030000        call 0x1dea
00001AE8  6A08              push byte +0x8
00001AEA  E8AB020000        call 0x1d9a
00001AEF  59                pop ecx
00001AF0  E8D1020000        call 0x1dc6
00001AF5  8845F9            mov [ebp-0x7],al
00001AF8  E8C9020000        call 0x1dc6
00001AFD  8845FA            mov [ebp-0x6],al
00001B00  0FB645F9          movzx eax,byte [ebp-0x7]
00001B04  25C0000000        and eax,0xc0
00001B09  740E              jz 0x1b19
00001B0B  0FB645F9          movzx eax,byte [ebp-0x7]
00001B0F  C1F806            sar eax,0x6
00001B12  89C3              mov ebx,eax
00001B14  E94A020000        jmp 0x1d63
00001B19  0FB645F9          movzx eax,byte [ebp-0x7]
00001B1D  50                push eax
00001B1E  8D05161E00C0      lea eax,[0xc0001e16]
00001B24  50                push eax
00001B25  E8E7FCFFFF        call 0x1811
00001B2A  83C408            add esp,byte +0x8
00001B2D  0FB645FA          movzx eax,byte [ebp-0x6]
00001B31  50                push eax
00001B32  8D050A1E00C0      lea eax,[0xc0001e0a]
00001B38  50                push eax
00001B39  E8D3FCFFFF        call 0x1811
00001B3E  83C408            add esp,byte +0x8
00001B41  6A04              push byte +0x4
00001B43  E852020000        call 0x1d9a
00001B48  59                pop ecx
00001B49  0FB645F8          movzx eax,byte [ebp-0x8]
00001B4D  50                push eax
00001B4E  E847020000        call 0x1d9a
00001B53  59                pop ecx
00001B54  E86D020000        call 0x1dc6
00001B59  8845F9            mov [ebp-0x7],al
00001B5C  0FB645F9          movzx eax,byte [ebp-0x7]
00001B60  2580000000        and eax,0x80
00001B65  740A              jz 0x1b71
00001B67  BB04000000        mov ebx,0x4
00001B6C  E9F2010000        jmp 0x1d63
00001B71  0FB645F9          movzx eax,byte [ebp-0x7]
00001B75  83E040            and eax,byte +0x40
00001B78  740A              jz 0x1b84
00001B7A  BB05000000        mov ebx,0x5
00001B7F  E9DF010000        jmp 0x1d63
00001B84  0FB645F9          movzx eax,byte [ebp-0x7]
00001B88  50                push eax
00001B89  8D05FE1D00C0      lea eax,[0xc0001dfe]
00001B8F  50                push eax
00001B90  E87CFCFFFF        call 0x1811
00001B95  83C408            add esp,byte +0x8
00001B98  6A00              push byte +0x0
00001B9A  68F7030000        push dword 0x3f7
00001B9F  E896EFFFFF        call 0xb3a
00001BA4  83C408            add esp,byte +0x8
00001BA7  E8C8010000        call 0x1d74
00001BAC  6A66              push byte +0x66
00001BAE  E8E7010000        call 0x1d9a
00001BB3  59                pop ecx
00001BB4  0FB645F8          movzx eax,byte [ebp-0x8]
00001BB8  50                push eax
00001BB9  E8DC010000        call 0x1d9a
00001BBE  59                pop ecx
00001BBF  FF7510            push dword [ebp+0x10]
00001BC2  E8D3010000        call 0x1d9a
00001BC7  59                pop ecx
00001BC8  FF750C            push dword [ebp+0xc]
00001BCB  E8CA010000        call 0x1d9a
00001BD0  59                pop ecx
00001BD1  FF7514            push dword [ebp+0x14]
00001BD4  E8C1010000        call 0x1d9a
00001BD9  59                pop ecx
00001BDA  6A02              push byte +0x2
00001BDC  E8B9010000        call 0x1d9a
00001BE1  59                pop ecx
00001BE2  6A12              push byte +0x12
00001BE4  E8B1010000        call 0x1d9a
00001BE9  59                pop ecx
00001BEA  6A1B              push byte +0x1b
00001BEC  E8A9010000        call 0x1d9a
00001BF1  59                pop ecx
00001BF2  68FF000000        push dword 0xff
00001BF7  E89E010000        call 0x1d9a
00001BFC  59                pop ecx
00001BFD  E8E8010000        call 0x1dea
00001C02  E8BF010000        call 0x1dc6
00001C07  8845F9            mov [ebp-0x7],al
00001C0A  E8B7010000        call 0x1dc6
00001C0F  8845FA            mov [ebp-0x6],al
00001C12  E8AF010000        call 0x1dc6
00001C17  8845FB            mov [ebp-0x5],al
00001C1A  E8A7010000        call 0x1dc6
00001C1F  8845FC            mov [ebp-0x4],al
00001C22  E89F010000        call 0x1dc6
00001C27  8845FD            mov [ebp-0x3],al
00001C2A  E897010000        call 0x1dc6
00001C2F  8845FE            mov [ebp-0x2],al
00001C32  E88F010000        call 0x1dc6
00001C37  8845FF            mov [ebp-0x1],al
00001C3A  0FB645F9          movzx eax,byte [ebp-0x7]
00001C3E  25C0000000        and eax,0xc0
00001C43  740E              jz 0x1c53
00001C45  0FB645F9          movzx eax,byte [ebp-0x7]
00001C49  C1F806            sar eax,0x6
00001C4C  89C3              mov ebx,eax
00001C4E  E910010000        jmp 0x1d63
00001C53  807DFA00          cmp byte [ebp-0x6],0x0
00001C57  0F8474000000      jz near 0x1cd1
00001C5D  0FB645FA          movzx eax,byte [ebp-0x6]
00001C61  2580000000        and eax,0x80
00001C66  740A              jz 0x1c72
00001C68  BB06000000        mov ebx,0x6
00001C6D  E9F1000000        jmp 0x1d63
00001C72  0FB645FA          movzx eax,byte [ebp-0x6]
00001C76  83E020            and eax,byte +0x20
00001C79  740A              jz 0x1c85
00001C7B  BB07000000        mov ebx,0x7
00001C80  E9DE000000        jmp 0x1d63
00001C85  0FB645FA          movzx eax,byte [ebp-0x6]
00001C89  83E010            and eax,byte +0x10
00001C8C  740A              jz 0x1c98
00001C8E  BB08000000        mov ebx,0x8
00001C93  E9CB000000        jmp 0x1d63
00001C98  0FB645FA          movzx eax,byte [ebp-0x6]
00001C9C  83E004            and eax,byte +0x4
00001C9F  740A              jz 0x1cab
00001CA1  BB09000000        mov ebx,0x9
00001CA6  E9B8000000        jmp 0x1d63
00001CAB  0FB645FA          movzx eax,byte [ebp-0x6]
00001CAF  83E002            and eax,byte +0x2
00001CB2  740A              jz 0x1cbe
00001CB4  BB0A000000        mov ebx,0xa
00001CB9  E9A5000000        jmp 0x1d63
00001CBE  0FB645FA          movzx eax,byte [ebp-0x6]
00001CC2  83E001            and eax,byte +0x1
00001CC5  740A              jz 0x1cd1
00001CC7  BB0B000000        mov ebx,0xb
00001CCC  E992000000        jmp 0x1d63
00001CD1  807DFB00          cmp byte [ebp-0x5],0x0
00001CD5  0F8472000000      jz near 0x1d4d
00001CDB  0FB645FB          movzx eax,byte [ebp-0x5]
00001CDF  83E040            and eax,byte +0x40
00001CE2  740A              jz 0x1cee
00001CE4  BB0C000000        mov ebx,0xc
00001CE9  E975000000        jmp 0x1d63
00001CEE  0FB645FB          movzx eax,byte [ebp-0x5]
00001CF2  83E020            and eax,byte +0x20
00001CF5  740A              jz 0x1d01
00001CF7  BB0D000000        mov ebx,0xd
00001CFC  E962000000        jmp 0x1d63
00001D01  0FB645FB          movzx eax,byte [ebp-0x5]
00001D05  83E010            and eax,byte +0x10
00001D08  740A              jz 0x1d14
00001D0A  BB0E000000        mov ebx,0xe
00001D0F  E94F000000        jmp 0x1d63
00001D14  0FB645FB          movzx eax,byte [ebp-0x5]
00001D18  83E004            and eax,byte +0x4
00001D1B  740A              jz 0x1d27
00001D1D  BB0F000000        mov ebx,0xf
00001D22  E93C000000        jmp 0x1d63
00001D27  0FB645FB          movzx eax,byte [ebp-0x5]
00001D2B  83E002            and eax,byte +0x2
00001D2E  740A              jz 0x1d3a
00001D30  BB10000000        mov ebx,0x10
00001D35  E929000000        jmp 0x1d63
00001D3A  0FB645FB          movzx eax,byte [ebp-0x5]
00001D3E  83E001            and eax,byte +0x1
00001D41  740A              jz 0x1d4d
00001D43  BB11000000        mov ebx,0x11
00001D48  E916000000        jmp 0x1d63
00001D4D  6800020000        push dword 0x200
00001D52  FF35E62700C0      push dword [0xc00027e6]
00001D58  FF7518            push dword [ebp+0x18]
00001D5B  E8C4EFFFFF        call 0xd24
00001D60  83C40C            add esp,byte +0xc
00001D63  C705E22700C05000  mov dword [0xc00027e2],0x50
         -0000
00001D6D  89D8              mov eax,ebx
00001D6F  5B                pop ebx
00001D70  89EC              mov esp,ebp
00001D72  5D                pop ebp
00001D73  C3                ret
00001D74  FA                cli
00001D75  B046              mov al,0x46
00001D77  E60C              out 0xc,al
00001D79  E60B              out 0xb,al
00001D7B  66B80040          mov ax,0x4000
00001D7F  E604              out 0x4,al
00001D81  88E0              mov al,ah
00001D83  E604              out 0x4,al
00001D85  6631C0            xor ax,ax
00001D88  E681              out 0x81,al
00001D8A  66B8FF01          mov ax,0x1ff
00001D8E  E605              out 0x5,al
00001D90  88E0              mov al,ah
00001D92  E605              out 0x5,al
00001D94  B002              mov al,0x2
00001D96  E60A              out 0xa,al
00001D98  FB                sti
00001D99  C3                ret
00001D9A  55                push ebp
00001D9B  89E5              mov ebp,esp
00001D9D  68F4030000        push dword 0x3f4
00001DA2  E8AFEDFFFF        call 0xb56
00001DA7  59                pop ecx
00001DA8  0FB6C0            movzx eax,al
00001DAB  2580000000        and eax,0x80
00001DB0  74EB              jz 0x1d9d
00001DB2  0FB64508          movzx eax,byte [ebp+0x8]
00001DB6  50                push eax
00001DB7  68F5030000        push dword 0x3f5
00001DBC  E879EDFFFF        call 0xb3a
00001DC1  83C408            add esp,byte +0x8
00001DC4  5D                pop ebp
00001DC5  C3                ret
00001DC6  68F4030000        push dword 0x3f4
00001DCB  E886EDFFFF        call 0xb56
00001DD0  59                pop ecx
00001DD1  0FB6C0            movzx eax,al
00001DD4  2580000000        and eax,0x80
00001DD9  74EB              jz 0x1dc6
00001DDB  68F5030000        push dword 0x3f5
00001DE0  E871EDFFFF        call 0xb56
00001DE5  59                pop ecx
00001DE6  0FB6C0            movzx eax,al
00001DE9  C3                ret
00001DEA  833D9E2100C000    cmp dword [0xc000219e],byte +0x0
00001DF1  74F7              jz 0x1dea
00001DF3  C7059E2100C00000  mov dword [0xc000219e],0x0
         -0000
00001DFD  C3                ret
00001DFE  53                push ebx
00001DFF  54                push esp
00001E00  333A              xor edi,[edx]
00001E02  20253032580A      and [0xa583230],ah
00001E08  0D00504E43        or eax,0x434e5000
00001E0D  3A20              cmp ah,[eax]
00001E0F  253032580A        and eax,0xa583230
00001E14  0D00535430        or eax,0x30545300
00001E19  3A20              cmp ah,[eax]
00001E1B  253032580A        and eax,0xa583230
00001E20  0D00536565        or eax,0x65655300
00001E25  6B696E67          imul ebp,[ecx+0x6e],byte +0x67
00001E29  2E2E2E205374      and [cs:ebx+0x74],dl
00001E2F  61                popa
00001E30  7475              jz 0x1ea7
00001E32  733A              jnc 0x1e6e
00001E34  20253032580A      and [0xa583230],ah
00001E3A  0D004D6F74        or eax,0x746f4d00
00001E3F  6F                outsd
00001E40  7220              jc 0x1e62
00001E42  4F                dec edi
00001E43  4E                dec esi
00001E44  2E205374          and [cs:ebx+0x74],dl
00001E48  61                popa
00001E49  7475              jz 0x1ec0
00001E4B  733A              jnc 0x1e87
00001E4D  20253032580A      and [0xa583230],ah
00001E53  0D00464443        or eax,0x43444600
00001E58  202D20446973      and [0x73694420],ch
00001E5E  6B657474          imul esp,[ebp+0x74],byte +0x74
00001E62  6520636F          and [gs:ebx+0x6f],ah
00001E66  6E                outsb
00001E67  7472              jz 0x1edb
00001E69  6F                outsd
00001E6A  6C                insb
00001E6B  6C                insb
00001E6C  657220            gs jc 0x1e8f
00001E6F  69732062757379    imul esi,[ebx+0x20],0x79737562
00001E76  004644            add [esi+0x44],al
00001E79  43                inc ebx
00001E7A  202D20556E6B      and [0x6b6e5520],ch
00001E80  6E                outsb
00001E81  6F                outsd
00001E82  776E              ja 0x1ef2
00001E84  206572            and [ebp+0x72],ah
00001E87  726F              jc 0x1ef8
00001E89  7221              jc 0x1eac
00001E8B  004644            add [esi+0x44],al
00001E8E  43                inc ebx
00001E8F  202D204D6973      and [0x73694d20],ch
00001E95  7369              jnc 0x1f00
00001E97  6E                outsb
00001E98  67206461          and [si+0x61],ah
00001E9C  7461              jz 0x1eff
00001E9E  206164            and [ecx+0x64],ah
00001EA1  647265            fs jc 0x1f09
00001EA4  7373              jnc 0x1f19
00001EA6  206D61            and [ebp+0x61],ch
00001EA9  726B              jc 0x1f16
00001EAB  2100              and [eax],eax
00001EAD  46                inc esi
00001EAE  44                inc esp
00001EAF  43                inc ebx
00001EB0  202D20426164      and [0x64614220],ch
00001EB6  206379            and [ebx+0x79],ah
00001EB9  6C                insb
00001EBA  696E6465722C20    imul ebp,[esi+0x64],0x202c7265
00001EC1  49                dec ecx
00001EC2  44                inc esp
00001EC3  206E6F            and [esi+0x6f],ch
00001EC6  7420              jz 0x1ee8
00001EC8  666F              outsw
00001ECA  756E              jnz 0x1f3a
00001ECC  642100            and [fs:eax],eax
00001ECF  46                inc esi
00001ED0  44                inc esp
00001ED1  43                inc ebx
00001ED2  202D20536361      and [0x61635320],ch
00001ED8  6E                outsb
00001ED9  20636F            and [ebx+0x6f],ah
00001EDC  6D                insd
00001EDD  6D                insd
00001EDE  61                popa
00001EDF  6E                outsb
00001EE0  64206661          and [fs:esi+0x61],ah
00001EE4  696C656421004644  imul ebp,[ebp+0x64],0x44460021
00001EEC  43                inc ebx
00001EED  202D2057726F      and [0x6f725720],ch
00001EF3  6E                outsb
00001EF4  67206379          and [bp+di+0x79],ah
00001EF8  6C                insb
00001EF9  696E6465722064    imul ebp,[esi+0x64],0x64207265
00001F00  657465            gs jz 0x1f68
00001F03  63746564          arpl [ebp+0x64],si
00001F07  2100              and [eax],eax
00001F09  46                inc esi
00001F0A  44                inc esp
00001F0B  43                inc ebx
00001F0C  202D20435243      and [0x43524320],ch
00001F12  206572            and [ebp+0x72],ah
00001F15  726F              jc 0x1f86
00001F17  7220              jc 0x1f39
00001F19  696E2064617461    imul ebp,[esi+0x20],0x61746164
00001F20  2100              and [eax],eax
00001F22  46                inc esi
00001F23  44                inc esp
00001F24  43                inc ebx
00001F25  202D2044656C      and [0x6c654420],ch
00001F2B  657465            gs jz 0x1f93
00001F2E  6420646174        and [fs:ecx+0x74],ah
00001F33  61                popa
00001F34  206164            and [ecx+0x64],ah
00001F37  647265            fs jc 0x1f9f
00001F3A  7373              jnc 0x1faf
00001F3C  206D61            and [ebp+0x61],ch
00001F3F  726B              jc 0x1fac
00001F41  20646574          and [ebp+0x74],ah
00001F45  6563746564        arpl [gs:ebp+0x64],si
00001F4A  2100              and [eax],eax
00001F4C  46                inc esi
00001F4D  44                inc esp
00001F4E  43                inc ebx
00001F4F  202D20494420      and [0x20444920],ch
00001F55  61                popa
00001F56  64647265          fs jc 0x1fbf
00001F5A  7373              jnc 0x1fcf
00001F5C  206D61            and [ebp+0x61],ch
00001F5F  726B              jc 0x1fcc
00001F61  206E6F            and [esi+0x6f],ch
00001F64  7420              jz 0x1f86
00001F66  666F              outsw
00001F68  756E              jnz 0x1fd8
00001F6A  642100            and [fs:eax],eax
00001F6D  46                inc esi
00001F6E  44                inc esp
00001F6F  43                inc ebx
00001F70  202D20577269      and [0x69725720],ch
00001F76  7465              jz 0x1fdd
00001F78  207072            and [eax+0x72],dh
00001F7B  6F                outsd
00001F7C  7465              jz 0x1fe3
00001F7E  63746564          arpl [ebp+0x64],si
00001F82  2100              and [eax],eax
00001F84  46                inc esi
00001F85  44                inc esp
00001F86  43                inc ebx
00001F87  202D20536563      and [0x63655320],ch
00001F8D  746F              jz 0x1ffe
00001F8F  7220              jc 0x1fb1
00001F91  49                dec ecx
00001F92  44                inc esp
00001F93  206E6F            and [esi+0x6f],ch
00001F96  7420              jz 0x1fb8
00001F98  666F              outsw
00001F9A  756E              jnz 0x200a
00001F9C  642100            and [fs:eax],eax
00001F9F  46                inc esi
00001FA0  44                inc esp
00001FA1  43                inc ebx
00001FA2  202D204F7665      and [0x65764f20],ch
00001FA8  7272              jc 0x201c
00001FAA  756E              jnz 0x201a
00001FAC  2100              and [eax],eax
00001FAE  46                inc esi
00001FAF  44                inc esp
00001FB0  43                inc ebx
00001FB1  202D20435243      and [0x43524320],ch
00001FB7  206572            and [ebp+0x72],ah
00001FBA  726F              jc 0x202b
00001FBC  7220              jc 0x1fde
00001FBE  696E204944206F    imul ebp,[esi+0x20],0x6f204449
00001FC5  7220              jc 0x1fe7
00001FC7  6461              fs popa
00001FC9  7461              jz 0x202c
00001FCB  2100              and [eax],eax
00001FCD  46                inc esi
00001FCE  44                inc esp
00001FCF  43                inc ebx
00001FD0  202D20456E64      and [0x646e4520],ch
00001FD6  206F66            and [edi+0x66],ch
00001FD9  206369            and [ebx+0x69],ah
00001FDC  6C                insb
00001FDD  6E                outsb
00001FDE  64657221          gs jc 0x2003
00001FE2  004644            add [esi+0x44],al
00001FE5  43                inc ebx
00001FE6  202D204E6F20      and [0x206f4e20],ch
00001FEC  6469736B65747465  imul esi,[fs:ebx+0x6b],0x65747465
00001FF4  20696E            and [ecx+0x6e],ch
00001FF7  20647269          and [edx+esi*2+0x69],ah
00001FFB  7665              jna 0x2062
00001FFD  2100              and [eax],eax
00001FFF  46                inc esi
00002000  44                inc esp
00002001  43                inc ebx
00002002  202D20466175      and [0x75614620],ch
00002008  6C                insb
00002009  7420              jz 0x202b
0000200B  7374              jnc 0x2081
0000200D  61                popa
0000200E  7475              jz 0x2085
00002010  7320              jnc 0x2032
00002012  7369              jnc 0x207d
00002014  676E              a16 outsb
00002016  61                popa
00002017  6C                insb
00002018  2100              and [eax],eax
0000201A  46                inc esi
0000201B  44                inc esp
0000201C  43                inc ebx
0000201D  202D20436F6D      and [0x6d6f4320],ch
00002023  6D                insd
00002024  61                popa
00002025  6E                outsb
00002026  64206162          and [fs:ecx+0x62],ah
0000202A  6F                outsd
0000202B  7274              jc 0x20a1
0000202D  6564206279        and [fs:edx+0x79],ah
00002032  207265            and [edx+0x65],dh
00002035  61                popa
00002036  647920            fs jns 0x2059
00002039  636861            arpl [eax+0x61],bp
0000203C  6E                outsb
0000203D  6765207369        and [gs:bp+di+0x69],dh
00002042  676E              a16 outsb
00002044  61                popa
00002045  6C                insb
00002046  2100              and [eax],eax
00002048  46                inc esi
00002049  44                inc esp
0000204A  43                inc ebx
0000204B  202D20496E76      and [0x766e4920],ch
00002051  61                popa
00002052  6C                insb
00002053  696420636F6D6D61  imul esp,[eax+0x63],0x616d6d6f
0000205B  6E                outsb
0000205C  642100            and [fs:eax],eax
0000205F  46                inc esi
00002060  44                inc esp
00002061  43                inc ebx
00002062  202D20436F6D      and [0x6d6f4320],ch
00002068  6D                insd
00002069  61                popa
0000206A  6E                outsb
0000206B  6420746572        and [fs:ebp+0x72],dh
00002070  6D                insd
00002071  696E6174656420    imul ebp,[esi+0x61],0x20646574
00002078  61                popa
00002079  626E6F            bound ebp,[esi+0x6f]
0000207C  726D              jc 0x20eb
0000207E  61                popa
0000207F  6C                insb
00002080  6921004F4B00      imul esp,[ecx],0x4b4f00
00002086  0000              add [eax],al
00002088  0000              add [eax],al
0000208A  0000              add [eax],al
0000208C  0000              add [eax],al
0000208E  E208              loop 0x2098
00002090  00C0              add al,al
00002092  D208              ror byte [eax],cl
00002094  00C0              add al,al
00002096  BB0800C0A7        mov ebx,0xa7c00008
0000209B  0800              or [eax],al
0000209D  C0970800C08308    rcl byte [edi+0x83c00008],0x8
000020A4  00C0              add al,al
000020A6  7408              jz 0x20b0
000020A8  00C0              add al,al
000020AA  5A                pop edx
000020AB  0800              or [eax],al
000020AD  C04D0800          ror byte [ebp+0x8],0x0
000020B1  C0                db 0xC0
000020B2  3108              xor [eax],ecx
000020B4  00C0              add al,al
000020B6  250800C00F        and eax,0xfc00008
000020BB  0800              or [eax],al
000020BD  C0FF07            sar bh,0x7
000020C0  00C0              add al,al
000020C2  E607              out 0x7,al
000020C4  00C0              add al,al
000020C6  DB07              fild dword [edi]
000020C8  00C0              add al,al
000020CA  CD07              int 0x7
000020CC  00C0              add al,al
000020CE  BB0700C0A9        mov ebx,0xa9c00007
000020D3  07                pop es
000020D4  00C0              add al,al
000020D6  A90700C0A9        test eax,0xa9c00007
000020DB  07                pop es
000020DC  00C0              add al,al
000020DE  A90700C0A9        test eax,0xa9c00007
000020E3  07                pop es
000020E4  00C0              add al,al
000020E6  A90700C0A9        test eax,0xa9c00007
000020EB  07                pop es
000020EC  00C0              add al,al
000020EE  A90700C0A9        test eax,0xa9c00007
000020F3  07                pop es
000020F4  00C0              add al,al
000020F6  A90700C0A9        test eax,0xa9c00007
000020FB  07                pop es
000020FC  00C0              add al,al
000020FE  A90700C0A9        test eax,0xa9c00007
00002103  07                pop es
00002104  00C0              add al,al
00002106  A90700C0A9        test eax,0xa9c00007
0000210B  07                pop es
0000210C  00C0              add al,al
0000210E  A10700C099        mov eax,[0x99c00007]
00002113  07                pop es
00002114  00C0              add al,al
00002116  92                xchg eax,edx
00002117  07                pop es
00002118  00C0              add al,al
0000211A  8B07              mov eax,[edi]
0000211C  00C0              add al,al
0000211E  8407              test [edi],al
00002120  00C0              add al,al
00002122  7D07              jnl 0x212b
00002124  00C0              add al,al
00002126  7507              jnz 0x212f
00002128  00C0              add al,al
0000212A  6E                outsb
0000212B  07                pop es
0000212C  00C0              add al,al
0000212E  6707              a16 pop es
00002130  00C0              add al,al
00002132  60                pusha
00002133  07                pop es
00002134  00C0              add al,al
00002136  58                pop eax
00002137  07                pop es
00002138  00C0              add al,al
0000213A  50                push eax
0000213B  07                pop es
0000213C  00C0              add al,al
0000213E  48                dec eax
0000213F  07                pop es
00002140  00C0              add al,al
00002142  40                inc eax
00002143  07                pop es
00002144  00C0              add al,al
00002146  3807              cmp [edi],al
00002148  00C0              add al,al
0000214A  3007              xor [edi],al
0000214C  00C0              add al,al
0000214E  832000            and dword [eax],byte +0x0
00002151  C05F2000          rcr byte [edi+0x20],0x0
00002155  C0482000          ror byte [eax+0x20],0x0
00002159  C01A20            rcr byte [edx],0x20
0000215C  00C0              add al,al
0000215E  FF1F              call far [edi]
00002160  00C0              add al,al
00002162  E31F              jecxz 0x2183
00002164  00C0              add al,al
00002166  CD1F              int 0x1f
00002168  00C0              add al,al
0000216A  AE                scasb
0000216B  1F                pop ds
0000216C  00C0              add al,al
0000216E  9F                lahf
0000216F  1F                pop ds
00002170  00C0              add al,al
00002172  841F              test [edi],bl
00002174  00C0              add al,al
00002176  6D                insd
00002177  1F                pop ds
00002178  00C0              add al,al
0000217A  4C                dec esp
0000217B  1F                pop ds
0000217C  00C0              add al,al
0000217E  221F              and bl,[edi]
00002180  00C0              add al,al
00002182  091F              or [edi],ebx
00002184  00C0              add al,al
00002186  EA1E00C0CF1E00    jmp 0x1e:0xcfc0001e
0000218D  C0AD1E00C08C1E    shr byte [ebp+0x8cc0001e],0x1e
00002194  00C0              add al,al
00002196  771E              ja 0x21b6
00002198  00C0              add al,al
0000219A  55                push ebp
0000219B  1E                push ds
0000219C  00C0              add al,al
0000219E  0000              add [eax],al
000021A0  0000              add [eax],al
000021A2  0000              add [eax],al
000021A4  0000              add [eax],al
000021A6  0000              add [eax],al
000021A8  0000              add [eax],al
000021AA  0100              add [eax],eax
000021AC  0101              add [ecx],eax
000021AE  0101              add [ecx],eax
000021B0  0100              add [eax],eax
000021B2  0001              add [ecx],al
000021B4  0000              add [eax],al
000021B6  0000              add [eax],al
000021B8  0000              add [eax],al
000021BA  0000              add [eax],al
000021BC  0000              add [eax],al
000021BE  0000              add [eax],al
000021C0  0000              add [eax],al
000021C2  0F20D8            mov eax,cr3
000021C5  0F22D8            mov cr3,eax
000021C8  EB00              jmp short 0x21ca
000021CA  C3                ret
000021CB  3E0F011D5C2600C0  lidt [ds:0xc000265c]
000021D3  C3                ret
000021D4  FA                cli
000021D5  E464              in al,0x64
000021D7  A801              test al,0x1
000021D9  7508              jnz 0x21e3
000021DB  A802              test al,0x2
000021DD  75F6              jnz 0x21d5
000021DF  B0FE              mov al,0xfe
000021E1  E664              out 0x64,al
000021E3  E460              in al,0x60
000021E5  EBEE              jmp short 0x21d5
000021E7  FA                cli
000021E8  3E0F0115BC2400C0  lgdt [ds:0xc00024bc]
000021F0  C3                ret
000021F1  55                push ebp
000021F2  89E5              mov ebp,esp
000021F4  1E                push ds
000021F5  06                push es
000021F6  60                pusha
000021F7  66BB2000          mov bx,0x20
000021FB  8EDB              mov ds,ebx
000021FD  8EC3              mov es,ebx
000021FF  89C3              mov ebx,eax
00002201  80BBA22100C000    cmp byte [ebx+0xc00021a2],0x0
00002208  7413              jz 0x221d
0000220A  3666FF750C        push word [ss:ebp+0xc]
0000220F  36FF7510          push dword [ss:ebp+0x10]
00002213  3666FF7514        push word [ss:ebp+0x14]
00002218  E90D000000        jmp 0x222a
0000221D  66680000          push word 0x0
00002221  36FF750C          push dword [ss:ebp+0xc]
00002225  3666FF7510        push word [ss:ebp+0x10]
0000222A  6650              push ax
0000222C  A1122700C0        mov eax,[0xc0002712]
00002231  8B5806            mov ebx,[eax+0x6]
00002234  53                push ebx
00002235  E8CEE2FFFF        call 0x508
0000223A  81C40E000000      add esp,0xe
00002240  61                popa
00002241  07                pop es
00002242  1F                pop ds
00002243  5D                pop ebp
00002244  58                pop eax
00002245  CF                iret
00002246  50                push eax
00002247  B800000000        mov eax,0x0
0000224C  EBA3              jmp short 0x21f1
0000224E  50                push eax
0000224F  B801000000        mov eax,0x1
00002254  EB9B              jmp short 0x21f1
00002256  50                push eax
00002257  B802000000        mov eax,0x2
0000225C  EB93              jmp short 0x21f1
0000225E  50                push eax
0000225F  B803000000        mov eax,0x3
00002264  EB8B              jmp short 0x21f1
00002266  50                push eax
00002267  B804000000        mov eax,0x4
0000226C  EB83              jmp short 0x21f1
0000226E  50                push eax
0000226F  B805000000        mov eax,0x5
00002274  E978FFFFFF        jmp 0x21f1
00002279  50                push eax
0000227A  B806000000        mov eax,0x6
0000227F  E96DFFFFFF        jmp 0x21f1
00002284  50                push eax
00002285  B807000000        mov eax,0x7
0000228A  E962FFFFFF        jmp 0x21f1
0000228F  50                push eax
00002290  B808000000        mov eax,0x8
00002295  E957FFFFFF        jmp 0x21f1
0000229A  50                push eax
0000229B  B809000000        mov eax,0x9
000022A0  E94CFFFFFF        jmp 0x21f1
000022A5  50                push eax
000022A6  B80A000000        mov eax,0xa
000022AB  E941FFFFFF        jmp 0x21f1
000022B0  50                push eax
000022B1  B80B000000        mov eax,0xb
000022B6  E936FFFFFF        jmp 0x21f1
000022BB  50                push eax
000022BC  B80C000000        mov eax,0xc
000022C1  E92BFFFFFF        jmp 0x21f1
000022C6  50                push eax
000022C7  B80D000000        mov eax,0xd
000022CC  E920FFFFFF        jmp 0x21f1
000022D1  50                push eax
000022D2  B80E000000        mov eax,0xe
000022D7  E915FFFFFF        jmp 0x21f1
000022DC  50                push eax
000022DD  B80F000000        mov eax,0xf
000022E2  E90AFFFFFF        jmp 0x21f1
000022E7  50                push eax
000022E8  B810000000        mov eax,0x10
000022ED  E9FFFEFFFF        jmp 0x21f1
000022F2  50                push eax
000022F3  B811000000        mov eax,0x11
000022F8  E9F4FEFFFF        jmp 0x21f1
000022FD  50                push eax
000022FE  B812000000        mov eax,0x12
00002303  E9E9FEFFFF        jmp 0x21f1
00002308  50                push eax
00002309  B813000000        mov eax,0x13
0000230E  E9DEFEFFFF        jmp 0x21f1
00002313  50                push eax
00002314  B814000000        mov eax,0x14
00002319  E9D3FEFFFF        jmp 0x21f1
0000231E  50                push eax
0000231F  B815000000        mov eax,0x15
00002324  E9C8FEFFFF        jmp 0x21f1
00002329  50                push eax
0000232A  B816000000        mov eax,0x16
0000232F  E9BDFEFFFF        jmp 0x21f1
00002334  50                push eax
00002335  B817000000        mov eax,0x17
0000233A  E9B2FEFFFF        jmp 0x21f1
0000233F  50                push eax
00002340  B818000000        mov eax,0x18
00002345  E9A7FEFFFF        jmp 0x21f1
0000234A  50                push eax
0000234B  B819000000        mov eax,0x19
00002350  E99CFEFFFF        jmp 0x21f1
00002355  50                push eax
00002356  B81A000000        mov eax,0x1a
0000235B  E991FEFFFF        jmp 0x21f1
00002360  50                push eax
00002361  B81B000000        mov eax,0x1b
00002366  E986FEFFFF        jmp 0x21f1
0000236B  50                push eax
0000236C  B81C000000        mov eax,0x1c
00002371  E97BFEFFFF        jmp 0x21f1
00002376  50                push eax
00002377  B81D000000        mov eax,0x1d
0000237C  E970FEFFFF        jmp 0x21f1
00002381  50                push eax
00002382  B81E000000        mov eax,0x1e
00002387  E965FEFFFF        jmp 0x21f1
0000238C  50                push eax
0000238D  B81F000000        mov eax,0x1f
00002392  E95AFEFFFF        jmp 0x21f1
00002397  50                push eax
00002398  B822000000        mov eax,0x22
0000239D  E94FFEFFFF        jmp 0x21f1
000023A2  50                push eax
000023A3  B823000000        mov eax,0x23
000023A8  E944FEFFFF        jmp 0x21f1
000023AD  50                push eax
000023AE  B824000000        mov eax,0x24
000023B3  E939FEFFFF        jmp 0x21f1
000023B8  50                push eax
000023B9  B825000000        mov eax,0x25
000023BE  E92EFEFFFF        jmp 0x21f1
000023C3  50                push eax
000023C4  B827000000        mov eax,0x27
000023C9  E923FEFFFF        jmp 0x21f1
000023CE  50                push eax
000023CF  B828000000        mov eax,0x28
000023D4  E918FEFFFF        jmp 0x21f1
000023D9  50                push eax
000023DA  B829000000        mov eax,0x29
000023DF  E90DFEFFFF        jmp 0x21f1
000023E4  50                push eax
000023E5  B82A000000        mov eax,0x2a
000023EA  E902FEFFFF        jmp 0x21f1
000023EF  50                push eax
000023F0  B82B000000        mov eax,0x2b
000023F5  E9F7FDFFFF        jmp 0x21f1
000023FA  50                push eax
000023FB  B82C000000        mov eax,0x2c
00002400  E9ECFDFFFF        jmp 0x21f1
00002405  50                push eax
00002406  B82D000000        mov eax,0x2d
0000240B  E9E1FDFFFF        jmp 0x21f1
00002410  50                push eax
00002411  B82E000000        mov eax,0x2e
00002416  E9D6FDFFFF        jmp 0x21f1
0000241B  50                push eax
0000241C  B82F000000        mov eax,0x2f
00002421  E9CBFDFFFF        jmp 0x21f1
00002426  1E                push ds
00002427  06                push es
00002428  60                pusha
00002429  66B82000          mov ax,0x20
0000242D  8ED8              mov ds,eax
0000242F  8EC0              mov es,eax
00002431  E870E0FFFF        call 0x4a6
00002436  61                popa
00002437  07                pop es
00002438  1F                pop ds
00002439  CF                iret
0000243A  1E                push ds
0000243B  06                push es
0000243C  60                pusha
0000243D  66B82000          mov ax,0x20
00002441  8ED8              mov ds,eax
00002443  8EC0              mov es,eax
00002445  E8A4E0FFFF        call 0x4ee
0000244A  61                popa
0000244B  07                pop es
0000244C  1F                pop ds
0000244D  CF                iret
0000244E  50                push eax
0000244F  B801000000        mov eax,0x1
00002454  A39E2100C0        mov [0xc000219e],eax
00002459  B020              mov al,0x20
0000245B  E620              out 0x20,al
0000245D  58                pop eax
0000245E  CF                iret
0000245F  55                push ebp
00002460  57                push edi
00002461  56                push esi
00002462  52                push edx
00002463  51                push ecx
00002464  53                push ebx
00002465  50                push eax
00002466  FA                cli
00002467  66B82000          mov ax,0x20
0000246B  8ED8              mov ds,eax
0000246D  8EC0              mov es,eax
0000246F  8EC0              mov es,eax
00002471  8EE0              mov fs,eax
00002473  8EE8              mov gs,eax
00002475  8B1D122700C0      mov ebx,[0xc0002712]
0000247B  8923              mov [ebx],esp
0000247D  8B1D0E2700C0      mov ebx,[0xc000270e]
00002483  891D122700C0      mov [0xc0002712],ebx
00002489  8B23              mov esp,[ebx]
0000248B  FB                sti
0000248C  58                pop eax
0000248D  5B                pop ebx
0000248E  59                pop ecx
0000248F  5A                pop edx
00002490  5E                pop esi
00002491  5F                pop edi
00002492  5D                pop ebp
00002493  CF                iret
