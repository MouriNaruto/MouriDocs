/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20230628 (32-bit version)
 * Copyright (c) 2000 - 2023 Intel Corporation
 * 
 * Disassembly of ../srat.dat, Mon Jan 29 07:40:25 2024
 *
 * ACPI Data Table [SRAT]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
 */

[000h 0000 004h]                   Signature : "SRAT"    [System Resource Affinity Table]
[004h 0004 004h]                Table Length : 000002F0
[008h 0008 001h]                    Revision : 02
[009h 0009 001h]                    Checksum : 1E
[00Ah 0010 006h]                      Oem ID : "VRTUAL"
[010h 0016 008h]                Oem Table ID : "MICROSFT"
[018h 0024 004h]                Oem Revision : 00000001
[01Ch 0028 004h]             Asl Compiler ID : "MSFT"
[020h 0032 004h]       Asl Compiler Revision : 00000001

[024h 0036 004h]              Table Revision : 00000001
[028h 0040 008h]                    Reserved : 0000000000000000

[030h 0048 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[031h 0049 001h]                      Length : 10

[032h 0050 001h]     Proximity Domain Low(8) : 00
[033h 0051 001h]                     Apic ID : 00
[034h 0052 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[038h 0056 001h]             Local Sapic EID : 00
[039h 0057 003h]   Proximity Domain High(24) : 000000
[03Ch 0060 004h]                Clock Domain : 00000000

[040h 0064 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[041h 0065 001h]                      Length : 10

[042h 0066 001h]     Proximity Domain Low(8) : 00
[043h 0067 001h]                     Apic ID : 01
[044h 0068 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[048h 0072 001h]             Local Sapic EID : 00
[049h 0073 003h]   Proximity Domain High(24) : 000000
[04Ch 0076 004h]                Clock Domain : 00000000

[050h 0080 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[051h 0081 001h]                      Length : 10

[052h 0082 001h]     Proximity Domain Low(8) : 00
[053h 0083 001h]                     Apic ID : 02
[054h 0084 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[058h 0088 001h]             Local Sapic EID : 00
[059h 0089 003h]   Proximity Domain High(24) : 000000
[05Ch 0092 004h]                Clock Domain : 00000000

[060h 0096 001h]               Subtable Type : 00 [Processor Local APIC/SAPIC Affinity]
[061h 0097 001h]                      Length : 10

[062h 0098 001h]     Proximity Domain Low(8) : 00
[063h 0099 001h]                     Apic ID : 03
[064h 0100 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
[068h 0104 001h]             Local Sapic EID : 00
[069h 0105 003h]   Proximity Domain High(24) : 000000
[06Ch 0108 004h]                Clock Domain : 00000000

[070h 0112 001h]               Subtable Type : 01 [Memory Affinity]
[071h 0113 001h]                      Length : 28

[072h 0114 004h]            Proximity Domain : 00000000
[076h 0118 002h]                   Reserved1 : 0000
[078h 0120 008h]                Base Address : 0000000000000000
[080h 0128 008h]              Address Length : 00000000F8000000
[088h 0136 004h]                   Reserved2 : 00000000
[08Ch 0140 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0
[090h 0144 008h]                   Reserved3 : 0000000000000000

[098h 0152 001h]               Subtable Type : 01 [Memory Affinity]
[099h 0153 001h]                      Length : 28

[09Ah 0154 004h]            Proximity Domain : 00000000
[09Eh 0158 002h]                   Reserved1 : 0000
[0A0h 0160 008h]                Base Address : 0000000100000000
[0A8h 0168 008h]              Address Length : 0000000008000000
[0B0h 0176 004h]                   Reserved2 : 00000000
[0B4h 0180 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0
[0B8h 0184 008h]                   Reserved3 : 0000000000000000

[0C0h 0192 001h]               Subtable Type : 01 [Memory Affinity]
[0C1h 0193 001h]                      Length : 28

[0C2h 0194 004h]            Proximity Domain : 00000000
[0C6h 0198 002h]                   Reserved1 : 0000
[0C8h 0200 008h]                Base Address : 0000000108000000
[0D0h 0208 008h]              Address Length : 0000000AF8000000
[0D8h 0216 004h]                   Reserved2 : 00000000
[0DCh 0220 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0
[0E0h 0224 008h]                   Reserved3 : 0000000000000000

[0E8h 0232 001h]               Subtable Type : 01 [Memory Affinity]
[0E9h 0233 001h]                      Length : 28

[0EAh 0234 004h]            Proximity Domain : 00000000
[0EEh 0238 002h]                   Reserved1 : 0000
[0F0h 0240 008h]                Base Address : 0000001000000000
[0F8h 0248 008h]              Address Length : 000000F000000000
[100h 0256 004h]                   Reserved2 : 00000000
[104h 0260 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0
[108h 0264 008h]                   Reserved3 : 0000000000000000

[110h 0272 001h]               Subtable Type : 01 [Memory Affinity]
[111h 0273 001h]                      Length : 28

[112h 0274 004h]            Proximity Domain : 00000000
[116h 0278 002h]                   Reserved1 : 0000
[118h 0280 008h]                Base Address : 0000010000000000
[120h 0288 008h]              Address Length : 0000010000000000
[128h 0296 004h]                   Reserved2 : 00000000
[12Ch 0300 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0
[130h 0304 008h]                   Reserved3 : 0000000000000000

[138h 0312 001h]               Subtable Type : 01 [Memory Affinity]
[139h 0313 001h]                      Length : 28

[13Ah 0314 004h]            Proximity Domain : 00000000
[13Eh 0318 002h]                   Reserved1 : 0000
[140h 0320 008h]                Base Address : 0000020000000000
[148h 0328 008h]              Address Length : 0000020000000000
[150h 0336 004h]                   Reserved2 : 00000000
[154h 0340 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0
[158h 0344 008h]                   Reserved3 : 0000000000000000

[160h 0352 001h]               Subtable Type : 01 [Memory Affinity]
[161h 0353 001h]                      Length : 28

[162h 0354 004h]            Proximity Domain : 00000000
[166h 0358 002h]                   Reserved1 : 0000
[168h 0360 008h]                Base Address : 0000040000000000
[170h 0368 008h]              Address Length : 0000040000000000
[178h 0376 004h]                   Reserved2 : 00000000
[17Ch 0380 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0
[180h 0384 008h]                   Reserved3 : 0000000000000000

[188h 0392 001h]               Subtable Type : 01 [Memory Affinity]
[189h 0393 001h]                      Length : 28

[18Ah 0394 004h]            Proximity Domain : 00000000
[18Eh 0398 002h]                   Reserved1 : 0000
[190h 0400 008h]                Base Address : 0000080000000000
[198h 0408 008h]              Address Length : 0000080000000000
[1A0h 0416 004h]                   Reserved2 : 00000000
[1A4h 0420 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0
[1A8h 0424 008h]                   Reserved3 : 0000000000000000

[1B0h 0432 001h]               Subtable Type : 01 [Memory Affinity]
[1B1h 0433 001h]                      Length : 28

[1B2h 0434 004h]            Proximity Domain : 00000000
[1B6h 0438 002h]                   Reserved1 : 0000
[1B8h 0440 008h]                Base Address : 0000100000000000
[1C0h 0448 008h]              Address Length : 0000100000000000
[1C8h 0456 004h]                   Reserved2 : 00000000
[1CCh 0460 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0
[1D0h 0464 008h]                   Reserved3 : 0000000000000000

[1D8h 0472 001h]               Subtable Type : 01 [Memory Affinity]
[1D9h 0473 001h]                      Length : 28

[1DAh 0474 004h]            Proximity Domain : 00000000
[1DEh 0478 002h]                   Reserved1 : 0000
[1E0h 0480 008h]                Base Address : 0000200000000000
[1E8h 0488 008h]              Address Length : 0000200000000000
[1F0h 0496 004h]                   Reserved2 : 00000000
[1F4h 0500 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0
[1F8h 0504 008h]                   Reserved3 : 0000000000000000

[200h 0512 001h]               Subtable Type : 01 [Memory Affinity]
[201h 0513 001h]                      Length : 28

[202h 0514 004h]            Proximity Domain : 00000000
[206h 0518 002h]                   Reserved1 : 0000
[208h 0520 008h]                Base Address : 0000400000000000
[210h 0528 008h]              Address Length : 0000400000000000
[218h 0536 004h]                   Reserved2 : 00000000
[21Ch 0540 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0
[220h 0544 008h]                   Reserved3 : 0000000000000000

[228h 0552 001h]               Subtable Type : 01 [Memory Affinity]
[229h 0553 001h]                      Length : 28

[22Ah 0554 004h]            Proximity Domain : 00000000
[22Eh 0558 002h]                   Reserved1 : 0000
[230h 0560 008h]                Base Address : 0000800000000000
[238h 0568 008h]              Address Length : 0000800000000000
[240h 0576 004h]                   Reserved2 : 00000000
[244h 0580 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0
[248h 0584 008h]                   Reserved3 : 0000000000000000

[250h 0592 001h]               Subtable Type : 01 [Memory Affinity]
[251h 0593 001h]                      Length : 28

[252h 0594 004h]            Proximity Domain : 00000000
[256h 0598 002h]                   Reserved1 : 0000
[258h 0600 008h]                Base Address : 0001000000000000
[260h 0608 008h]              Address Length : 0001000000000000
[268h 0616 004h]                   Reserved2 : 00000000
[26Ch 0620 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0
[270h 0624 008h]                   Reserved3 : 0000000000000000

[278h 0632 001h]               Subtable Type : 01 [Memory Affinity]
[279h 0633 001h]                      Length : 28

[27Ah 0634 004h]            Proximity Domain : 00000000
[27Eh 0638 002h]                   Reserved1 : 0000
[280h 0640 008h]                Base Address : 0002000000000000
[288h 0648 008h]              Address Length : 0002000000000000
[290h 0656 004h]                   Reserved2 : 00000000
[294h 0660 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0
[298h 0664 008h]                   Reserved3 : 0000000000000000

[2A0h 0672 001h]               Subtable Type : 01 [Memory Affinity]
[2A1h 0673 001h]                      Length : 28

[2A2h 0674 004h]            Proximity Domain : 00000000
[2A6h 0678 002h]                   Reserved1 : 0000
[2A8h 0680 008h]                Base Address : 0004000000000000
[2B0h 0688 008h]              Address Length : 0004000000000000
[2B8h 0696 004h]                   Reserved2 : 00000000
[2BCh 0700 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0
[2C0h 0704 008h]                   Reserved3 : 0000000000000000

[2C8h 0712 001h]               Subtable Type : 01 [Memory Affinity]
[2C9h 0713 001h]                      Length : 28

[2CAh 0714 004h]            Proximity Domain : 00000000
[2CEh 0718 002h]                   Reserved1 : 0000
[2D0h 0720 008h]                Base Address : 0008000000000000
[2D8h 0728 008h]              Address Length : 0008000000000000
[2E0h 0736 004h]                   Reserved2 : 00000000
[2E4h 0740 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0
[2E8h 0744 008h]                   Reserved3 : 0000000000000000

Raw Table Data: Length 752 (0x2F0)

    0000: 53 52 41 54 F0 02 00 00 02 1E 56 52 54 55 41 4C  // SRAT......VRTUAL
    0010: 4D 49 43 52 4F 53 46 54 01 00 00 00 4D 53 46 54  // MICROSFT....MSFT
    0020: 01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0030: 00 10 00 00 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0040: 00 10 00 01 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0050: 00 10 00 02 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0060: 00 10 00 03 01 00 00 00 00 00 00 00 00 00 00 00  // ................
    0070: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // .(..............
    0080: 00 00 00 F8 00 00 00 00 00 00 00 00 03 00 00 00  // ................
    0090: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    00A0: 00 00 00 00 01 00 00 00 00 00 00 08 00 00 00 00  // ................
    00B0: 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00  // ................
    00C0: 01 28 00 00 00 00 00 00 00 00 00 08 01 00 00 00  // .(..............
    00D0: 00 00 00 F8 0A 00 00 00 00 00 00 00 03 00 00 00  // ................
    00E0: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    00F0: 00 00 00 00 10 00 00 00 00 00 00 00 F0 00 00 00  // ................
    0100: 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00  // ................
    0110: 01 28 00 00 00 00 00 00 00 00 00 00 00 01 00 00  // .(..............
    0120: 00 00 00 00 00 01 00 00 00 00 00 00 03 00 00 00  // ................
    0130: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    0140: 00 00 00 00 00 02 00 00 00 00 00 00 00 02 00 00  // ................
    0150: 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00  // ................
    0160: 01 28 00 00 00 00 00 00 00 00 00 00 00 04 00 00  // .(..............
    0170: 00 00 00 00 00 04 00 00 00 00 00 00 03 00 00 00  // ................
    0180: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    0190: 00 00 00 00 00 08 00 00 00 00 00 00 00 08 00 00  // ................
    01A0: 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00  // ................
    01B0: 01 28 00 00 00 00 00 00 00 00 00 00 00 10 00 00  // .(..............
    01C0: 00 00 00 00 00 10 00 00 00 00 00 00 03 00 00 00  // ................
    01D0: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    01E0: 00 00 00 00 00 20 00 00 00 00 00 00 00 20 00 00  // ..... ....... ..
    01F0: 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00  // ................
    0200: 01 28 00 00 00 00 00 00 00 00 00 00 00 40 00 00  // .(...........@..
    0210: 00 00 00 00 00 40 00 00 00 00 00 00 03 00 00 00  // .....@..........
    0220: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    0230: 00 00 00 00 00 80 00 00 00 00 00 00 00 80 00 00  // ................
    0240: 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00  // ................
    0250: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 01 00  // .(..............
    0260: 00 00 00 00 00 00 01 00 00 00 00 00 03 00 00 00  // ................
    0270: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    0280: 00 00 00 00 00 00 02 00 00 00 00 00 00 00 02 00  // ................
    0290: 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00  // ................
    02A0: 01 28 00 00 00 00 00 00 00 00 00 00 00 00 04 00  // .(..............
    02B0: 00 00 00 00 00 00 04 00 00 00 00 00 03 00 00 00  // ................
    02C0: 00 00 00 00 00 00 00 00 01 28 00 00 00 00 00 00  // .........(......
    02D0: 00 00 00 00 00 00 08 00 00 00 00 00 00 00 08 00  // ................
    02E0: 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00  // ................
