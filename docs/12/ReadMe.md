# MD12: Talk about the real minimum hardware requirements for Windows

Note: This document only talk about NT-based Windows in the current stage.

I hope this document will help developers decide the base minimum hardware
requirements for their softwares adapted for Windows easier. It's also helpful
for users who have old devices.

## Processor

Note: This section is more real and detailed than Microsoft's specification 
because they talk so less about that.

### x86 (32-Bit)

- NT 3.1 / NT 3.5x (Uniprocessor Only)
  - Stepping D1 80386 (i386) or compatible.
  - Reference: https://www.geoffchappell.com/studies/windows/km/cpu/precpuid.htm
- NT 3.5x (Multiprocessor) / NT 4.0 / 2000
  - 80486 (i486) or compatible.
  - Reference: https://www.geoffchappell.com/studies/windows/km/cpu/precpuid.htm
- XP (NT 5.1) / Server 2003 / Vista / Server 2008 / 7 (Before 2018)
  - x86 processors since the original Pentium (i586 / P5) or compatible, with 
    16-Bit and 32-Bit mode available, because CPUID and CMPXCHG8B are
    required.
  - Reference: https://winhistory.de/more/386/xpmini.htm
  - Reference: https://winhistory.de/more/386/vistamini.htm
  - Reference: https://www.youtube.com/watch?v=Zs8-rQKvptM
- 7 (Since 2018)
  - x86 processors since the original Pentium (i586 / P5) or compatible, with 
    16-Bit and 32-Bit mode available.
  - SSE2 is required.
- 8 / 8.1 / 10 (All Versions except 1809, 2004, 20H2, 21H1, 21H2 and 22H2)
  - x86 processors since the original Pentium (i586 / P5) or compatible, with
    16-Bit and 32-Bit mode available.
  - PAE, NX and SSE2 are required.
  - Reference: https://support.microsoft.com/en-us/windows/system-requirements-2f327e5a-2bae-4011-8848-58180a4353a7
  - Reference: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
- 10 (All Versions except 1809, 2004, 20H2, 21H1, 21H2 and 22H2)
  - x86 processors since the original Pentium (i586 / P5) or compatible, with
    16-Bit and 32-Bit mode available.
  - PAE, NX and SSE2 are required.
  - Reference: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
  - Reference: https://www.tenforums.com/performance-maintenance/6909-lets-run-win10-really-really-old-hardware.html

### x86 (64-Bit)

- XP x64 / Server 2003 / Vista / Server 2008 / 7 / Server 2008 R2
  - x86 processors or compatible, with 16-Bit, 32-Bit and 64-Bit mode available.
- 8 / Server 2012
  - x86 processors or compatible, with 16-Bit, 32-Bit and 64-Bit mode available.
    So, PAE and SSE2 are existed in all of them.
  - NX is required. Only care about that when you have early Intel CPUs with
    Intel 64 support. It was added in the stepping E0 (0F41h) Pentium 4 in
    October 2004.
  - Reference: https://en.wikipedia.org/wiki/X86-64
  - Reference: https://support.microsoft.com/en-us/windows/system-requirements-2f327e5a-2bae-4011-8848-58180a4353a7
- 8.1 / Server 2012 R2 / 10 (All Versions) / Server 2016 / Server 2019 / Server
  2022 / 11 (21H2, 22H2, 23H2) 
  - x86 processors or compatible, with 16-Bit, 32-Bit and 64-Bit mode available.
    So, PAE and SSE2 are existed in all of them.
  - NX is required. Only care about that when you have early Intel CPUs with
    Intel 64 support. It was added in the stepping E0 (0F41h) Pentium 4 in
    October 2004.
  - CMPXCHG16B, LAHF/SAHF and PREFETCHW are required.
  - Reference: https://en.wikipedia.org/wiki/X86-64
  - Reference: https://support.microsoft.com/en-us/windows/system-requirements-2f327e5a-2bae-4011-8848-58180a4353a7
  - Reference: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
- 11 (24H2 or later)
  - x86 processors or compatible, with 16-Bit, 32-Bit and 64-Bit mode available.
    So, PAE and SSE2 are existed in all of them.
  - NX is required. Only care about that when you have early Intel CPUs with
    Intel 64 support. It was added in the stepping E0 (0F41h) Pentium 4 in
    October 2004.
  - CMPXCHG16B, LAHF/SAHF, PREFETCHW and POPCNT are required.
  - Reference: https://en.wikipedia.org/wiki/X86-64
  - Reference: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
  - Reference: https://twitter.com/TheBobPony/status/1756771051634135277

### ARM (64-Bit)

- 10 (Since 1709)
  - Compatible with ARMv8-A instruction set.
  - Reference: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
- 11 (All Versions)
  - Compatible with ARMv8-A instruction set.
  - Large System Extensions (atomic instructions) are required.
  - Reference: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
  - Reference: https://en.wikipedia.org/wiki/Comparison_of_ARM_processors#ARMv8-A
  - Reference: https://en.wikichip.org/wiki/arm/armv8#ARMv8_Extensions_and_Processor_Features
  - Reference: https://learn.arm.com/learning-paths/servers-and-cloud-computing/lse/intro/

## Memory

Follow the Microsoft's specification of the minimum memory size requirement is
good choice because memory size is important for a usable Windows experience.

But I will also add some real values which below the Microsoft's specification
for this section if you really want to beyond the limitation.

### 32-Bit (Microsoft's specification)

- 12 MiB for NT 3.1 / NT 3.5x
- 16 MiB for NT 4.0
- 32 MiB for 2000
- 64 MiB for XP (NT 5.1)
- 128 MiB for Server 2003
  - Reference: https://web.archive.org/web/20101225000120/http://technet.microsoft.com/en-us/windowsserver/bb430827
- 512 MiB for Vista / Server 2008
  - Reference: https://web.archive.org/web/20080101144743/http://www.microsoft.com/windows/products/windowsvista/editions/systemrequirements.mspx
  - Reference: https://web.archive.org/web/20080923012137/http://www.microsoft.com:80/windowsserver2008/en/us/system-requirements.aspx
- 1 GiB for 7 / 8 / 8.1 / 10 (All Versions)
  - Reference: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview

### 32-Bit (Actually)

- 8 MiB for NT 3.1 / NT 3.5x / NT 4.0
  - Reference: https://winhistory.de/more/386/winq.htm
- 12 MiB for 2000
  - Reference: https://winhistory.de/more/386/winq.htm
- 16 MiB for XP (NT 5.1)
  - Reference: https://www.youtube.com/watch?v=oMnABjaDbhE
- 32 MiB for Server 2003
  - Reference: https://winhistory.de/more/386/winq.htm
- 224 MiB for Vista
  - Reference: https://winhistory.de/more/386/vistamini.htm
- 32 MiB for 7
  - Reference: https://www.youtube.com/watch?v=ezympDfJolA
- 132 MiB for 10
  - Reference: https://www.youtube.com/watch?v=celWaRRf8uw

### 64-Bit (Microsoft's specification)

- 256 MiB for XP x64 / Server 2003
- 512 MiB for Vista / Server 2008 / Server 2008 R2 / Server 2012 / Server 2012
  R2 / Server 2016 (Server Core) / Server 2019 (Server Core) / Server 2022
  (Server Core)
  - Reference: https://web.archive.org/web/20080101144743/http://www.microsoft.com/windows/products/windowsvista/editions/systemrequirements.mspx
  - Reference: https://web.archive.org/web/20080923012137/http://www.microsoft.com:80/windowsserver2008/en/us/system-requirements.aspx
  - Reference: https://web.archive.org/web/20091002082955/http://www.microsoft.com/windowsserver2008/en/us/system-requirements.aspx
  - Reference: https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134246(v=ws.11)
  - Reference: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
  - Reference: https://learn.microsoft.com/en-us/windows-server/get-started/hardware-requirements
- 2 GiB for 7 / 8 / 8.1 / 10 (All Versions) / Server 2016 (Server with Desktop
  Experience) / Server 2019 (Server with Desktop Experience) / Server 2022
  (Server with Desktop Experience)
  - Reference: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
- 4 GiB for 11 (All Versions)
  - Reference: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview

### 64-Bit (Actually)

- 176 MiB for 11
  - Reference: https://www.youtube.com/watch?v=bVTZMP-F98s)

## Storage

The minimal storage size should be determined by your Windows WIM image size,
memory size for paging file, and compression method you are using.

System partition bigger than 50 GiB is highly recommend when you are using
Vista / Server 2008 or later in the production environments.
