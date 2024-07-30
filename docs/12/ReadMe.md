# MD12: Talk about the real minimum hardware requirements for Windows

[简体中文](ReadMe.zh-CN.md)

Note: This document only talk about NT-based Windows in the current stage.

I hope this document will help developers decide the base minimum hardware
requirements for their software adapted for Windows more easily. It's also
helpful for users who have old devices.

## Processor

Note: This section is more real and detailed than Microsoft's specification 
because they talk so less about that.

### x86 (32-Bit)

- NT 3.1 / NT 3.5x (Uniprocessor Only)
  - x86 processors compatible with the Stepping D1 80386 (i386)
  - Reference: https://www.geoffchappell.com/studies/windows/km/cpu/precpuid.htm
- NT 3.5x (Multiprocessor) / NT 4.0 / 2000
  - x86 processors compatible with the 80486 (i486)
  - Reference: https://www.geoffchappell.com/studies/windows/km/cpu/precpuid.htm
- XP (NT 5.1) / Server 2003 / Vista / Server 2008 / 7 (Before 2018)
  - x86 processors compatible with the original Pentium (i586 / P5) because
    CPUID and CMPXCHG8B are required
  - Reference: https://winhistory.de/more/386/xpmini.htm
  - Reference: https://winhistory.de/more/386/vistamini.htm
  - Reference: https://www.youtube.com/watch?v=Zs8-rQKvptM
- 7 (Since 2018)
  - Inherit the processor requirements from 7 (Before 2018)
  - SSE2 is required
- 8 / 8.1 / 10 (All Versions except 1809, 2004, 20H2, 21H1, 21H2 and 22H2)
  - Inherit the processor requirements from 7
  - PAE, NX and SSE2 are required
  - Reference: https://support.microsoft.com/en-us/windows/system-requirements-2f327e5a-2bae-4011-8848-58180a4353a7
  - Reference: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
- 10 (1809, 2004, 20H2, 21H1, 21H2 and 22H2)
  - The minimum processor requirement is as same as their x86 (64-Bit) versions
  - Reference: https://www.tenforums.com/performance-maintenance/6909-lets-run-win10-really-really-old-hardware.html

### x86 (64-Bit)

- XP x64 / Server 2003 / Vista / Server 2008 / 7 / Server 2008 R2
  - x86 processors compatible with the x86-64 (a.k.a x86-64-v1) instruction set
  - Except processors which only support x86S
  - Reference: https://en.wikipedia.org/wiki/X86-64
- 8 / Server 2012
  - Inherit the processor requirements from 7 / Server 2008 R2 (PAE and SSE2 are
    existed in all of them)
  - NX is required (Only care about that when you have early Intel CPUs with
    Intel 64 support. It was added in the stepping E0 (0F41h) Pentium 4 in
    October 2004.)
  - Reference: https://en.wikipedia.org/wiki/X86-64
  - Reference: https://support.microsoft.com/en-us/windows/system-requirements-2f327e5a-2bae-4011-8848-58180a4353a7
- 8.1 / Server 2012 R2 / 10 (All Versions) / Server 2016 / Server 2019 / Server
  2022 / 11 (21H2, 22H2, 23H2)
  - Inherit the processor requirements from 8 / Server 2012
  - CMPXCHG16B, LAHF/SAHF and PREFETCHW are required
  - Reference: https://support.microsoft.com/en-us/windows/system-requirements-2f327e5a-2bae-4011-8848-58180a4353a7
  - Reference: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
- 11 (24H2 or later)
  - x86 processors compatible with the x86-64-v2 instruction set because POPCNT
    and SSE4.2 are required
  - Except processors which only support x86S
  - Reference: https://en.wikipedia.org/wiki/X86-64
  - Reference: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
  - Reference: https://twitter.com/MouriNaruto/status/1761945388280598984

### ARM (64-Bit)

- 10 (Since 1709) / 11 (21H2, 22H2, 23H2) 
  - ARM processors compatible with the ARMv8-A instruction set
  - Reference: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
  - Reference: https://en.wikichip.org/wiki/arm/armv8
  - Reference: http://www.emulators.com/docs/abc_history_of_woa.htm
- 11 (24H2 or later)
  - ARM processors compatible with the ARMv8.1-A instruction set
  - Reference: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
  - Reference: https://en.wikichip.org/wiki/arm/armv8.1
  - Reference: http://www.emulators.com/docs/abc_history_of_woa.htm

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
  - Reference: https://www.youtube.com/watch?v=bVTZMP-F98s

## Storage

The minimal storage size should be determined by your Windows WIM image size,
memory size for paging file, and compression method you are using.

System partition bigger than 50 GiB is highly recommend when you are using
Vista / Server 2008 or later in the production environments.

## Firmware

### x86 (32-Bit)

- Legacy BIOS firmware is supported for all x86 (32-Bit) Windows versions
- UEFI firmware is supported for 8 / 8.1 / 10 (All Versions)
- Beginning with Vista / Server 2008, ACPI-compliant firmware is required that
  is dated January 1, 1999 or later
- Reference: https://learn.microsoft.com/en-us/windows-hardware/drivers/kernel/acpi-bios
- Reference: https://www.geoffchappell.com/studies/windows/km/hal/history/index.htm

### x86 (64-Bit)

- Legacy BIOS firmware is supported for all x86 (64-Bit) Windows versions
- UEFI firmware with CSM enabled is supported for Vista SP1 and SP2 / Server
  2008 / 7 / Server 2008 R2 (unless you try to use some workarounds like
  https://github.com/manatails/uefiseven)
- UEFI firmware is supported since 8 / Server 2012
- ACPI-compliant firmware is required
- Reference: https://download.microsoft.com/download/7/e/7/7e7662cf-cbea-470b-a97e-ce7ce0d98dc2/uefi_windows.docx
- Reference: https://www.geoffchappell.com/studies/windows/km/hal/history/index.htm

### ARM (64-Bit)

- ACPI-compliant UEFI firmware is required

## Hyper-V Guest Specific

- Legacy versions before XP (NT 5.1) may not be able to run as the guest
  unless setting CompatibilityForOlderOperatingSystemsEnabled to $true via 
  Set-VMProcessor PowerShell cmdlet for Generation 1 Virtual Machines.
  - Reference: https://blacktree.nl/2020/07/16/windows-2000-on-hyper-v/
- The standalone Hyper-V Integration Components is available from 2000 to
  8 / Server 2012.
  - Earliest Hyper-V Integration Components: https://dl.bobpony.com/vmtools/hyperv/legacy/Hyper-V2008-vmguest.iso
  - Latest Hyper-V Integration Components: https://dl.bobpony.com/vmtools/hyperv/vmguest.iso
- Generation 2 Virtual Machines only support x86 (64-Bit) guest OS on x86
  (64-Bit) host and ARM (64-Bit) guest OS on ARM (64-Bit) host because it's
  using UEFI Class 3 compliant firmware.
  - Reference: https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn282285(v=ws.11)
- Running as the guest in Generation 2 Virtual Machines is available since
  8 / Server 2012. Windows 8 Build 8032 should be the earliest leaked Windows
  build that can boot in a Hyper-V Generation 2 Virtual Machine.
  - Reference: https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn282285(v=ws.11)
  - Reference: https://x.com/MouriNaruto/status/1818300982226465109

Here are some notes may be helpful for people who want to make x86 (64-Bit) of
XP x64 / Server 2003 / Vista / Server 2008 / 7 / Server 2008 R2 be able to run
in Generation 2 Virtual Machines.

- Adapt for UEFI Graphics Output Protocol.
- The legacy Programmable Interrupt Controller (PIC) and the legacy Programmable
  Interval Timer (PIT) is not available in Generation 2 Virtual Machines. It
  also caused the RTC clock is available but the RTC timer not. So, you need the
  local APIC timer, and use the RTC clock to do something brute-force way for
  implementing the timer calibration if you don't want to use Hyper-V specific
  guest infrastructures.
  - Reference: https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn282285(v=ws.11)
  - Reference: https://github.com/MouriNaruto/MouriDocs/blob/main/docs/11/ReadMe.md
