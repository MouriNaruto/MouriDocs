/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20230628 (32-bit version)
 * Copyright (c) 2000 - 2023 Intel Corporation
 * 
 * Disassembly of ../waet.dat, Mon Jan 29 07:40:25 2024
 *
 * ACPI Data Table [WAET]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
 */

[000h 0000 004h]                   Signature : "WAET"    [Windows ACPI Emulated Devices Table]
[004h 0004 004h]                Table Length : 00000028
[008h 0008 001h]                    Revision : 01
[009h 0009 001h]                    Checksum : 22
[00Ah 0010 006h]                      Oem ID : "VRTUAL"
[010h 0016 008h]                Oem Table ID : "MICROSFT"
[018h 0024 004h]                Oem Revision : 00000001
[01Ch 0028 004h]             Asl Compiler ID : "MSFT"
[020h 0032 004h]       Asl Compiler Revision : 00000001

[024h 0036 004h]       Flags (decoded below) : 00000003
                        RTC needs no INT ack : 1
                     PM timer, one read only : 1

Raw Table Data: Length 40 (0x28)

    0000: 57 41 45 54 28 00 00 00 01 22 56 52 54 55 41 4C  // WAET(...."VRTUAL
    0010: 4D 49 43 52 4F 53 46 54 01 00 00 00 4D 53 46 54  // MICROSFT....MSFT
    0020: 01 00 00 00 03 00 00 00                          // ........
