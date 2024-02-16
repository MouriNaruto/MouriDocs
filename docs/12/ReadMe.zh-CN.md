# MD12: 探讨 Windows 真正的最低硬件要求

注：本文现阶段仅讨论基于 NT 内核的 Windows 版本

我希望本文能帮助为 Windows 开发软件的开发人员更轻松地确定其软件的最低硬件要求

当然，对于那些使用旧设备的用户也有帮助

## 处理器

注：这一部分比微软的规范更真实、更详细，因为他们在这方面谈得太少了

### x86 (32 位)

- NT 3.1 / NT 3.5x (仅限单处理器)
  - 与步进 D1 的 80386 (i386) 兼容的 x86 处理器
  - 参考资料: https://www.geoffchappell.com/studies/windows/km/cpu/precpuid.htm
- NT 3.5x (多处理器) / NT 4.0 / 2000
  - 与 80486 (i486) 兼容的 x86 处理器
  - 参考资料: https://www.geoffchappell.com/studies/windows/km/cpu/precpuid.htm
- XP (NT 5.1) / Server 2003 / Vista / Server 2008 / 7 (2018 年之前)
  - 与初代 Pentium（i586 / P5）兼容的 x86 处理器，因为需要 CPUID 和 CMPXCHG8B
  - 参考资料: https://winhistory.de/more/386/xpmini.htm
  - 参考资料: https://winhistory.de/more/386/vistamini.htm
  - 参考资料: https://www.youtube.com/watch?v=Zs8-rQKvptM
- 7 (2018 年开始)
  - 继承 7（2018 年之前）的处理器要求
  - 需要 SSE2.
- 8 / 8.1 / 10 (除了 1809, 2004, 20H2, 21H1, 21H2 和 22H2 之外的所有版本)
  - 继承 7 的处理器要求
  - 需要 PAE, NX 和 SSE2
  - 参考资料: https://support.microsoft.com/en-us/windows/system-requirements-2f327e5a-2bae-4011-8848-58180a4353a7
  - 参考资料: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
- 10 (1809, 2004, 20H2, 21H1, 21H2 和 22H2)
  - 最低处理器要求与对应的 x86（64 位）版本相同
  - 参考资料: https://www.tenforums.com/performance-maintenance/6909-lets-run-win10-really-really-old-hardware.html

### x86 (64 位)

- XP x64 / Server 2003 / Vista / Server 2008 / 7 / Server 2008 R2
  - x86 processors compatible with the original x86-64 design (a.k.a except
    processors which only support x86S)
- 8 / Server 2012
  - Inherit the processor requirements from 7 / Server 2008 R2 (PAE and SSE2 are
    existed in all of them)
  - NX is required (Only care about that when you have early Intel CPUs with
    Intel 64 support. It was added in the stepping E0 (0F41h) Pentium 4 in
    October 2004.)
  - 参考资料: https://en.wikipedia.org/wiki/X86-64
  - 参考资料: https://support.microsoft.com/en-us/windows/system-requirements-2f327e5a-2bae-4011-8848-58180a4353a7
- 8.1 / Server 2012 R2 / 10 (All Versions) / Server 2016 / Server 2019 / Server
  2022 / 11 (21H2, 22H2, 23H2) 
  - Inherit the processor requirements from 8 / Server 2012
  - CMPXCHG16B, LAHF/SAHF and PREFETCHW are required
  - 参考资料: https://support.microsoft.com/en-us/windows/system-requirements-2f327e5a-2bae-4011-8848-58180a4353a7
  - 参考资料: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
- 11 (24H2 or later)
  - Inherit the processor requirements from 11 (21H2, 22H2, 23H2)
  - POPCNT is required
  - 参考资料: https://en.wikipedia.org/wiki/X86-64
  - 参考资料: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
  - 参考资料: https://twitter.com/TheBobPony/status/1756771051634135277
  - 参考资料: https://twitter.com/TheBobPony/status/1758023533064565076
  - 参考资料: https://twitter.com/MouriNaruto/status/1758082961570955523
  - 参考资料: https://www.cpu-world.com/cgi-bin/CPUID.pl?CPUID=74119
  - 参考资料: https://www.cpu-world.com/cgi-bin/CPUID.pl?CPUID=74121

### ARM (64 位)

- 10 (Since 1709)
  - ARM processors compatible with the ARMv8-A instruction set
  - 参考资料: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
- 11 (All Versions)
  - Inherit the processor requirements from 10 (Since 1709)
  - Large System Extensions (atomic instructions) are required
  - 参考资料: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
  - 参考资料: https://en.wikipedia.org/wiki/Comparison_of_ARM_processors#ARMv8-A
  - 参考资料: https://en.wikichip.org/wiki/arm/armv8#ARMv8_Extensions_and_Processor_Features
  - 参考资料: https://learn.arm.com/learning-paths/servers-and-cloud-computing/lse/intro/

## 内存

遵循微软规定的最小内存大小要求是不错的选择，因为内存大小对于 Windows 体验的可用
性非常重要

不过，如果你真的想超越限制，我也会在本节中添加一些低于微软规定的实际值

### 32 位 (微软的规范)

- 12 MiB for NT 3.1 / NT 3.5x
- 16 MiB for NT 4.0
- 32 MiB for 2000
- 64 MiB for XP (NT 5.1)
- 128 MiB for Server 2003
  - 参考资料: https://web.archive.org/web/20101225000120/http://technet.microsoft.com/en-us/windowsserver/bb430827
- 512 MiB for Vista / Server 2008
  - 参考资料: https://web.archive.org/web/20080101144743/http://www.microsoft.com/windows/products/windowsvista/editions/systemrequirements.mspx
  - 参考资料: https://web.archive.org/web/20080923012137/http://www.microsoft.com:80/windowsserver2008/en/us/system-requirements.aspx
- 1 GiB for 7 / 8 / 8.1 / 10 (All Versions)
  - 参考资料: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview

### 32 位 (实际情况)

- 8 MiB for NT 3.1 / NT 3.5x / NT 4.0
  - 参考资料: https://winhistory.de/more/386/winq.htm
- 12 MiB for 2000
  - 参考资料: https://winhistory.de/more/386/winq.htm
- 16 MiB for XP (NT 5.1)
  - 参考资料: https://www.youtube.com/watch?v=oMnABjaDbhE
- 32 MiB for Server 2003
  - 参考资料: https://winhistory.de/more/386/winq.htm
- 224 MiB for Vista
  - 参考资料: https://winhistory.de/more/386/vistamini.htm
- 32 MiB for 7
  - 参考资料: https://www.youtube.com/watch?v=ezympDfJolA
- 132 MiB for 10
  - 参考资料: https://www.youtube.com/watch?v=celWaRRf8uw

### 64 位 (微软的规范)

- 256 MiB for XP x64 / Server 2003
- 512 MiB for Vista / Server 2008 / Server 2008 R2 / Server 2012 / Server 2012
  R2 / Server 2016 (Server Core) / Server 2019 (Server Core) / Server 2022
  (Server Core)
  - 参考资料: https://web.archive.org/web/20080101144743/http://www.microsoft.com/windows/products/windowsvista/editions/systemrequirements.mspx
  - 参考资料: https://web.archive.org/web/20080923012137/http://www.microsoft.com:80/windowsserver2008/en/us/system-requirements.aspx
  - 参考资料: https://web.archive.org/web/20091002082955/http://www.microsoft.com/windowsserver2008/en/us/system-requirements.aspx
  - 参考资料: https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134246(v=ws.11)
  - 参考资料: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
  - 参考资料: https://learn.microsoft.com/en-us/windows-server/get-started/hardware-requirements
- 2 GiB for 7 / 8 / 8.1 / 10 (All Versions) / Server 2016 (Server with Desktop
  Experience) / Server 2019 (Server with Desktop Experience) / Server 2022
  (Server with Desktop Experience)
  - 参考资料: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
- 4 GiB for 11 (All Versions)
  - 参考资料: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview

### 64 位 (实际情况)

- 176 MiB for 11
  - 参考资料: https://www.youtube.com/watch?v=bVTZMP-F98s)

## 存储

最小存储大小应根据 Windows WIM 映像大小、根据内存大小设定的分页文件和你使用的压
缩方法来确定

在生产环境中使用 Vista / Server 2008 或更高版本时，强烈建议系统分区大于 50 GiB

## 固件

### x86 (32 位)

- Legacy BIOS firmware is supported for all x86 (32 位) Windows versions.
- UEFI firmware is supported for 8 / 8.1 / 10 (All Versions).
- Beginning with Vista / Server 2008, ACPI-compliant firmware is required that
  is dated January 1, 1999 or later.
- 参考资料: https://learn.microsoft.com/en-us/windows-hardware/drivers/kernel/acpi-bios
- 参考资料: https://www.geoffchappell.com/studies/windows/km/hal/history/index.htm

### x86 (64 位)

- Legacy BIOS firmware is supported for all x86 (64 位) Windows versions.
- UEFI firmware with CSM enabled is supported for Vista SP1 or later / Server
  2008 / 7 / Server 2008 R2 unless you try to use some workarounds like
  https://github.com/manatails/uefiseven.
- 自 8 / Server 2012 起支持 UEFI 固件
- 需要兼容 ACPI 的固件
- 参考资料: https://download.microsoft.com/download/7/e/7/7e7662cf-cbea-470b-a97e-ce7ce0d98dc2/uefi_windows.docx
- 参考资料: https://www.geoffchappell.com/studies/windows/km/hal/history/index.htm

### ARM (64 位)

- 需要兼容 ACPI 的 UEFI 固件

## Hyper-V Guest Specific

- Legacy versions before XP (NT 5.1) may not be able to run as the guest
  unless setting CompatibilityForOlderOperatingSystemsEnabled to $true via 
  Set-VMProcessor PowerShell cmdlet for Generation 1 Virtual Machines.
  - 参考资料: https://blacktree.nl/2020/07/16/windows-2000-on-hyper-v/
- The standalone Hyper-V Integration Components is available from 2000 to
  8 / Server 2012.
  - Earliest Hyper-V Integration Components: https://dl.bobpony.com/vmtools/hyperv/legacy/Hyper-V2008-vmguest.iso
  - Latest Hyper-V Integration Components: https://dl.bobpony.com/vmtools/hyperv/vmguest.iso
- Generation 2 Virtual Machines only support x86 (64 位) guest OS on x86
  (64 位) host and ARM (64 位) guest OS on ARM (64 位) host because it's
  using UEFI Class 3 compliant firmware.
  - 参考资料: https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn282285(v=ws.11)
- Running as the guest in Generation 2 Virtual Machines is available since
  8 / Server 2012.
  - 参考资料: https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn282285(v=ws.11)

Here are some notes may be helpful for people who want to make x86 (64 位) of
XP x64 / Server 2003 / Vista / Server 2008 / 7 / Server 2008 R2 be able to run
in Generation 2 Virtual Machines.

- Adapt for UEFI Graphics Output Protocol.
- The legacy Programmable Interrupt Controller (PIC) and the legacy Programmable
  Interval Timer (PIT) is not available in Generation 2 Virtual Machines. It
  also caused the RTC clock is available but the RTC timer not. So, you need the
  local APIC timer, and use the RTC clock to do something brute-force way for
  implementing the timer calibration if you don't want to use Hyper-V specific
  guest infrastructures.
  - 参考资料: https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn282285(v=ws.11)
  - 参考资料: https://github.com/MouriNaruto/MouriDocs/blob/main/docs/11/ReadMe.md
