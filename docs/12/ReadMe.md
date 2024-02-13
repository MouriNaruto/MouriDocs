# MD12: Talk about the real minimum hardware requirements for Windows

Note: This document only talk about NT-based Windows in the current stage.

## Processor

### x86 (32-Bit)

- NT 3.1 / NT 3.5 (Uniprocessor Only)
  - Stepping D1 80386 (i386) or compatible.
- NT 3.5 (Multiprocessor) / NT 4.0 / 2000
  - 80486 (i486) or compatible.
- XP (NT 5.1) / Server 2003 / Vista / Server 2008 / 7 (Before 2018)
  - x86 processors since the original Pentium (i586 / P5) or compatible, with 
    16-Bit and 32-Bit mode available, because CPUID and CMPXCHG8B are
    required.
- 7 (Since 2018)
  - x86 processors since the original Pentium (i586 / P5) or compatible, with 
    16-Bit and 32-Bit mode available.
  - SSE2 is required.
- 8 / 8.1 / 10 (All Versions except 1809, 2004, 20H2, 21H1, 21H2 and 22H2)
  - x86 processors since the original Pentium (i586 / P5) or compatible, with
    16-Bit and 32-Bit mode available.
  - PAE, NX and SSE2 are required.
- 10 (All Versions except 1809, 2004, 20H2, 21H1, 21H2 and 22H2)
  - x86 processors since the original Pentium (i586 / P5) or compatible, with
    16-Bit and 32-Bit mode available.
  - PAE, NX and SSE2 are required.

### x86 (64-Bit)

- XP x64 / Server 2003 / Vista / Server 2008 / 7 / Server 2008 R2
  - x86 processors or compatible, with 16-Bit, 32-Bit and 64-Bit mode available.
- 8 / Server 2012
  - x86 processors or compatible, with 16-Bit, 32-Bit and 64-Bit mode available.
    So, PAE and SSE2 are existed in all of them.
  - NX is required. Only care about that when you have early Intel CPUs with
    Intel 64 support. It was added in the stepping E0 (0F41h) Pentium 4 in
    October 2004.
- 8.1 / Server 2012 R2 / 10 (All Versions) / Server 2016 / Server 2019 / Server
  2022 / 11 (21H2, 22H2, 23H2) 
  - x86 processors or compatible, with 16-Bit, 32-Bit and 64-Bit mode available.
    So, PAE and SSE2 are existed in all of them.
  - NX is required. Only care about that when you have early Intel CPUs with
    Intel 64 support. It was added in the stepping E0 (0F41h) Pentium 4 in
    October 2004.
  - CMPXCHG16B, LAHF/SAHF and PREFETCHW are required.
- 11 (24H2 or later)
  - x86 processors or compatible, with 16-Bit, 32-Bit and 64-Bit mode available.
    So, PAE and SSE2 are existed in all of them.
  - NX is required. Only care about that when you have early Intel CPUs with
    Intel 64 support. It was added in the stepping E0 (0F41h) Pentium 4 in
    October 2004.
  - CMPXCHG16B, LAHF/SAHF, PREFETCHW and POPCNT are required.

### ARM (64-Bit)

- 10 (Since 1709)
  - Compatible with ARMv8-A instruction set.
- 11 (All Versions)
  - Compatible with ARMv8-A instruction set.
  - Large System Extensions (atomic instructions) are required.

### References

- https://www.geoffchappell.com/studies/windows/km/cpu/precpuid.htm
- https://www.geoffchappell.com/studies/windows/km/cpu/cx8.htm
- https://winhistory.de/more/386/winq.htm
- https://winhistory.de/more/386/xpmini.htm
- https://winhistory.de/more/386/vistamini.htm
- https://en.wikipedia.org/wiki/X86-64
- https://support.microsoft.com/en-us/windows/system-requirements-2f327e5a-2bae-4011-8848-58180a4353a7
- https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
- https://twitter.com/TheBobPony/status/1756771051634135277
- https://en.wikipedia.org/wiki/Comparison_of_ARM_processors#ARMv8-A
- https://en.wikichip.org/wiki/arm/armv8#ARMv8_Extensions_and_Processor_Features
- https://learn.arm.com/learning-paths/servers-and-cloud-computing/lse/intro/
