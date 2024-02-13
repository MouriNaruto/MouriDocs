# MD12: Talk about the real minimum hardware requirements for Windows

Note: This document only talk about NT-based Windows in the current stage.

## Processor

### x86 (32-Bit)

- NT 3.1 / NT 3.5 (Uniprocessor Only)
  - 80386 (i386) compatible beginning with D1 Stepping, or compatible.
- NT 3.5 (Multiprocessor) / NT 4.0 / 2000
  - 80486 (i486) or compatible.
- XP (NT 5.1) / Server 2003 / Vista / Server 2008 / 7 (Before 2018)
  - Original Pentium (i586 / P5) or compatible, because CPUID and CMPXCHG8B are
    needed.
- 7 (Since 2018)
  - x86 processors since the original Pentium (i586 / P5) or compatible, with 
    16-Bit and 32-Bit mode available.
  - SSE2 is required.
- 8 / 8.1 / 10 (All Versions)
  - x86 processors since the original Pentium (i586 / P5) or compatible, with
    32-Bit mode available.
  - If you boot these versions via the legacy BIOS firmware, 16-Bit mode for x86
    processors is required.
  - PAE, NX and SSE2 are required.
