/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20230628 (32-bit version)
 * Copyright (c) 2000 - 2023 Intel Corporation
 * 
 * Disassembly of ../apic.dat, Mon Jan 29 07:40:25 2024
 *
 * ACPI Data Table [APIC]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
 */

[000h 0000 004h]                   Signature : "APIC"    [Multiple APIC Description Table (MADT)]
[004h 0004 004h]                Table Length : 00000068
[008h 0008 001h]                    Revision : 04
[009h 0009 001h]                    Checksum : DE
[00Ah 0010 006h]                      Oem ID : "VRTUAL"
[010h 0016 008h]                Oem Table ID : "MICROSFT"
[018h 0024 004h]                Oem Revision : 00000001
[01Ch 0028 004h]             Asl Compiler ID : "MSFT"
[020h 0032 004h]       Asl Compiler Revision : 00000001

[024h 0036 004h]          Local Apic Address : FEE00000
[028h 0040 004h]       Flags (decoded below) : 00000000
                         PC-AT Compatibility : 0

[02Ch 0044 001h]               Subtable Type : 01 [I/O APIC]
[02Dh 0045 001h]                      Length : 0C
[02Eh 0046 001h]                 I/O Apic ID : 04
[02Fh 0047 001h]                    Reserved : 00
[030h 0048 004h]                     Address : FEC00000
[034h 0052 004h]                   Interrupt : 00000000

[038h 0056 001h]               Subtable Type : 02 [Interrupt Source Override]
[039h 0057 001h]                      Length : 0A
[03Ah 0058 001h]                         Bus : 00
[03Bh 0059 001h]                      Source : 09
[03Ch 0060 004h]                   Interrupt : 00000009
[040h 0064 002h]       Flags (decoded below) : 000D
                                    Polarity : 1
                                Trigger Mode : 3

[042h 0066 001h]               Subtable Type : 04 [Local APIC NMI]
[043h 0067 001h]                      Length : 06
[044h 0068 001h]                Processor ID : 01
[045h 0069 002h]       Flags (decoded below) : 0000
                                    Polarity : 0
                                Trigger Mode : 0
[047h 0071 001h]        Interrupt Input LINT : 01

[048h 0072 001h]               Subtable Type : 00 [Processor Local APIC]
[049h 0073 001h]                      Length : 08
[04Ah 0074 001h]                Processor ID : 01
[04Bh 0075 001h]               Local Apic ID : 00
[04Ch 0076 004h]       Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[050h 0080 001h]               Subtable Type : 00 [Processor Local APIC]
[051h 0081 001h]                      Length : 08
[052h 0082 001h]                Processor ID : 02
[053h 0083 001h]               Local Apic ID : 01
[054h 0084 004h]       Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[058h 0088 001h]               Subtable Type : 00 [Processor Local APIC]
[059h 0089 001h]                      Length : 08
[05Ah 0090 001h]                Processor ID : 03
[05Bh 0091 001h]               Local Apic ID : 02
[05Ch 0092 004h]       Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[060h 0096 001h]               Subtable Type : 00 [Processor Local APIC]
[061h 0097 001h]                      Length : 08
[062h 0098 001h]                Processor ID : 04
[063h 0099 001h]               Local Apic ID : 03
[064h 0100 004h]       Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

Raw Table Data: Length 104 (0x68)

    0000: 41 50 49 43 68 00 00 00 04 DE 56 52 54 55 41 4C  // APICh.....VRTUAL
    0010: 4D 49 43 52 4F 53 46 54 01 00 00 00 4D 53 46 54  // MICROSFT....MSFT
    0020: 01 00 00 00 00 00 E0 FE 00 00 00 00 01 0C 04 00  // ................
    0030: 00 00 C0 FE 00 00 00 00 02 0A 00 09 09 00 00 00  // ................
    0040: 0D 00 04 06 01 00 00 01 00 08 01 00 01 00 00 00  // ................
    0050: 00 08 02 01 01 00 00 00 00 08 03 02 01 00 00 00  // ................
    0060: 00 08 04 03 01 00 00 00                          // ........
