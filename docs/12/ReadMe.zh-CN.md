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
  - 需要 SSE2
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
  - 与原始 x86-64 设计兼容的 x86 处理器 (即只支持 x86S 的处理器除外)
- 8 / Server 2012
  - 继承 7 / Server 2008 R2 的处理器要求 (PAE 和 SSE2 在符合条件的处理器都存在)
  - 需要 NX (只有你手头有早期 Intel x86-64 处理器的情况才需要考虑这个问题。
    该特性于 2004 年 10 月在 E0 (0F41h) 步进的 Pentium 4 引入。)
  - 参考资料: https://en.wikipedia.org/wiki/X86-64
  - 参考资料: https://support.microsoft.com/en-us/windows/system-requirements-2f327e5a-2bae-4011-8848-58180a4353a7
- 8.1 / Server 2012 R2 / 10 (所有版本) / Server 2016 / Server 2019 / Server
  2022 / 11 (21H2, 22H2, 23H2) 
  - 继承 8 / Server 2012 的处理器要求
  - 需要 CMPXCHG16B, LAHF/SAHF 和 PREFETCHW
  - 参考资料: https://support.microsoft.com/en-us/windows/system-requirements-2f327e5a-2bae-4011-8848-58180a4353a7
  - 参考资料: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
- 11 (24H2 及之后版本)
  - 继承 11 (21H2, 22H2, 23H2) 的处理器要求
  - 需要 POPCNT
  - 参考资料: https://en.wikipedia.org/wiki/X86-64
  - 参考资料: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
  - 参考资料: https://twitter.com/TheBobPony/status/1756771051634135277
  - 参考资料: https://twitter.com/TheBobPony/status/1758023533064565076
  - 参考资料: https://twitter.com/MouriNaruto/status/1758082961570955523
  - 参考资料: https://www.cpu-world.com/cgi-bin/CPUID.pl?CPUID=74119
  - 参考资料: https://www.cpu-world.com/cgi-bin/CPUID.pl?CPUID=74121

### ARM (64 位)

- 10 (1709 开始)
  - 与 ARMv8-A 指令集兼容的 ARM 处理器
  - 参考资料: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
- 11 (所有版本)
  - 继承 10 (Since 1709) 的处理器要求
  - 需要 Large System Extensions (原子操作)
  - 参考资料: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
  - 参考资料: https://en.wikipedia.org/wiki/Comparison_of_ARM_processors#ARMv8-A
  - 参考资料: https://en.wikichip.org/wiki/arm/armv8#ARMv8_Extensions_and_Processor_Features
  - 参考资料: https://learn.arm.com/learning-paths/servers-and-cloud-computing/lse/intro/

## 内存

遵循微软规定的最小内存大小要求是不错的选择，因为内存大小对于 Windows 体验的可用
性非常重要

不过，如果你真的想超越限制，我也会在本节中添加一些低于微软规定的实际值

### 32 位 (微软的规范)

- NT 3.1 / NT 3.5x 为 12 MiB
- NT 4.0 为 16 MiB
- 2000 为 32 MiB
- XP (NT 5.1) 为 64 MiB 
- Server 2003 为 128 MiB
  - 参考资料: https://web.archive.org/web/20101225000120/http://technet.microsoft.com/en-us/windowsserver/bb430827
- Vista / Server 2008 为 512 MiB 
  - 参考资料: https://web.archive.org/web/20080101144743/http://www.microsoft.com/windows/products/windowsvista/editions/systemrequirements.mspx
  - 参考资料: https://web.archive.org/web/20080923012137/http://www.microsoft.com:80/windowsserver2008/en/us/system-requirements.aspx
- 7 / 8 / 8.1 / 10 (所有版本) 为 1 GiB
  - 参考资料: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview

### 32 位 (实际情况)

- NT 3.1 / NT 3.5x / NT 4.0 为 8 MiB
  - 参考资料: https://winhistory.de/more/386/winq.htm
- 2000 为 12 MiB
  - 参考资料: https://winhistory.de/more/386/winq.htm
- XP (NT 5.1) 为 16 MiB
  - 参考资料: https://www.youtube.com/watch?v=oMnABjaDbhE
- Server 2003 为 32 MiB
  - 参考资料: https://winhistory.de/more/386/winq.htm
- Vista 为 224 MiB
  - 参考资料: https://winhistory.de/more/386/vistamini.htm
- 7 为 32 MiB
  - 参考资料: https://www.youtube.com/watch?v=ezympDfJolA
- 10 为 132 MiB
  - 参考资料: https://www.youtube.com/watch?v=celWaRRf8uw

### 64 位 (微软的规范)

- XP x64 / Server 2003 为 256 MiB
- Vista / Server 2008 / Server 2008 R2 / Server 2012 / Server 2012 R2 / Server
  2016 (服务器核心安装) / Server 2019 (服务器核心安装) / Server 2022
  (服务器核心安装) 为 512 MiB
  - 参考资料: https://web.archive.org/web/20080101144743/http://www.microsoft.com/windows/products/windowsvista/editions/systemrequirements.mspx
  - 参考资料: https://web.archive.org/web/20080923012137/http://www.microsoft.com:80/windowsserver2008/en/us/system-requirements.aspx
  - 参考资料: https://web.archive.org/web/20091002082955/http://www.microsoft.com/windowsserver2008/en/us/system-requirements.aspx
  - 参考资料: https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134246(v=ws.11)
  - 参考资料: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
  - 参考资料: https://learn.microsoft.com/en-us/windows-server/get-started/hardware-requirements
- 7 / 8 / 8.1 / 10 (所有版本) / Server 2016 (带桌面体验的服务器安装) / Server
  2019 (带桌面体验的服务器安装) / Server 2022 (带桌面体验的服务器安装) 为 2 GiB
  - 参考资料: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview
- 11 (所有版本) 为 4 GiB
  - 参考资料: https://learn.microsoft.com/en-us/windows-hardware/design/minimum/minimum-hardware-requirements-overview

### 64 位 (实际情况)

- 11 为 176 MiB
  - 参考资料: https://www.youtube.com/watch?v=bVTZMP-F98s

## 存储

最小存储大小应根据 Windows WIM 映像大小、
根据内存大小设定的分页文件和你使用的压缩方法来确定

在生产环境中使用 Vista / Server 2008 或更高版本时，强烈建议系统分区大于 50 GiB

## 固件

### x86 (32 位)

- 所有 x86（32 位）Windows 版本支持传统 BIOS 固件
- 8 / 8.1 / 10 (所有版本) 支持 UEFI 固件
- 自 Vista / Server 2008 开始，需使用 1999 年 1 月 1 日或之后的兼容 ACPI 的固件
- 参考资料: https://learn.microsoft.com/en-us/windows-hardware/drivers/kernel/acpi-bios
- 参考资料: https://www.geoffchappell.com/studies/windows/km/hal/history/index.htm

### x86 (64 位)

- 所有 x86（64 位）Windows 版本支持传统 BIOS 固件
- Vista SP1 and SP2 / Server 2008 / 7 / Server 2008 R2 支持启用 CSM 的 UEFI 固件
  (除非您尝试使用一些类似 https://github.com/manatails/uefiseven 的变通方法)
- 自 8 / Server 2012 起支持 UEFI 固件
- 需要兼容 ACPI 的固件
- 参考资料: https://download.microsoft.com/download/7/e/7/7e7662cf-cbea-470b-a97e-ce7ce0d98dc2/uefi_windows.docx
- 参考资料: https://www.geoffchappell.com/studies/windows/km/hal/history/index.htm

### ARM (64 位)

- 需要兼容 ACPI 的 UEFI 固件

## 特定于 Hyper-V 虚拟机的需求

- 除非通过 PowerShell 的 Set-VMProcessor 命令为你的 1 代虚拟机设置
  CompatibilityForOlderOperatingSystemsEnabled 选项为 $true，否则 XP (NT 5.1)
  之前的旧版本可能无法在虚拟机中运行。
  - 参考资料: https://blacktree.nl/2020/07/16/windows-2000-on-hyper-v/
- 独立版 Hyper-V 集成组件适用于 2000 至 8 / Server 2012
  - 最旧的 Hyper-V 集成组件: https://dl.bobpony.com/vmtools/hyperv/legacy/Hyper-V2008-vmguest.iso
  - 最新的 Hyper-V 集成组件: https://dl.bobpony.com/vmtools/hyperv/vmguest.iso
- 由于 2 代虚拟机使用符合 UEFI Class 3 规范的固件，于是仅支持在 x86 (64 位)
  宿主机的虚拟机运行 x86 (64 位) 操作系统和在 ARM (64 位) 宿主机的虚拟机运行
  ARM (64 位) 操作系统
  - 参考资料: https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn282285(v=ws.11)
- 自 8 / Server 2012 起支持在 2 代虚拟机中运行
  - 参考资料: https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn282285(v=ws.11)

下面的一些说明可能会对想让 x86 (64 位) 的 XP x64 / Server 2003 / Vista / Server
2008 / 7 / Server 2008 R2 在 2 代虚拟机中运行的人有所帮助

- 适配 UEFI Graphics Output Protocol
- 由于传统的可编程中断控制器 (PIC) 和传统的可编程间隔定时器 (PIT) 在 2
  代虚拟机中不可用，这个特性也导致了 RTC 时钟可用但 RTC 定时器不可用；
  因此，如果不想使用 Hyper-V 特定的客户基础架构，就需要使用本地 APIC
  定时器，并使用 RTC 时钟以暴力方式实现定时器校准
  - 参考资料: https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn282285(v=ws.11)
  - 参考资料: https://github.com/MouriNaruto/MouriDocs/blob/main/docs/11/ReadMe.md
