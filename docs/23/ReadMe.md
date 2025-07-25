# MD23: The baselines of Windows targets for all my open-source projects

Last Updated: July 25, 2025

## Baselines

### 2025 Baseline

- Supported Operating Systems:
  - Windows 10, version 2004 (Build 19041) or later
  - Windows Server 2022 (Build 20348) or later
- Supported Platforms:
  - x86 (64-bit)
  - ARM (64-bit)

Here are some several benefits of the 2025 baseline, read the
[related FAQ section](#benefits-of-2025-baseline) for more information.

For the reasons for removing x86 (32-bit) support, read the
[related FAQ section](#why-x86-32-bit-support-is-removed-in-the-2025-baseline).

### 2021 Baseline

- Supported Operating Systems:
  - Windows Vista (Build 6000) or later
  - Windows Server 2008 (Build 6000) or later
- Supported Platforms:
  - x86 (64-bit)
  - x86 (32-bit)
  - ARM (64-bit)

This is the baseline since [NSudo 8.2], which removed ARM (32-bit) support. Read
[related FAQ section](#why-arm-32-bit-support-is-removed-in-the-2021-baseline)
for more information.

[NSudo 8.2]: https://github.com/M2TeamArchived/NSudo/releases/tag/8.2

### 2017 Baseline

- Supported Operating Systems:
  - Windows Vista (Build 6000) or later
  - Windows Server 2008 (Build 6000) or later
- Supported Platforms:
  - x86 (64-bit)
  - x86 (32-bit)
  - ARM (64-bit)
  - ARM (32-bit)

This is the baseline since [NSudo 5.2], which added support for ARM targets due
to Microsoft MSVC toolchain for ARM (64-bit) and ARM (32-bit) is available.

[NSudo 5.2]: https://github.com/M2TeamArchived/NSudo/releases/tag/5.2

### 2014 Baseline

- Supported Operating Systems:
  - Windows Vista (Build 6000) or later
  - Windows Server 2008 (Build 6000) or later
- Supported Platforms:
  - x86 (64-bit)
  - x86 (32-bit)

This is the initial baseline when I started to use C and C++ in my open-source
projects.

### Benefits of 2025 Baseline

- Windows Universal C Runtime (UCRT) has added the C++ FH4 (__CxxFrameHandler4)
  support since Windows 10, version 2004 (Build 19041), which we can reuse that
  for all x86 (64-bit) targets to save about 15 KiB size for each binary.
- We can use Windows Runtime XAML Islands to build modern but lightweight user
  interfaces for non Windows Server Core, Windows PE, and Windows RE scenarios.
- We can reduce many fallback implementations in the codebase, which will reduce
  the size of release package, simplify the codebase, and make the continuous
  integration faster.
- It seems that Microsoft STL no longer supports targeting Windows 7 / Server
  2008 R2, Windows 8 / Server 2012, and Windows 8.1 / Server 2012 R2 in the
  [next major version]. They also set the minimum supported version to Windows
  10 / Server 2016, I guess they will also modify the policy of the default
  subsystem version to 10.0 and limit the minimum subsystem version developers
  can set without hacking the binaries in the next MSVC major version.
- It has already been the baseline for [NanaBox], and [NanaZip] modern flavor,
  and it will be applied to all components in [NanaZip], even all my open-source
  projects in the near future.

[next major version]: https://github.com/microsoft/STL/wiki/Changelog/0ce45c7fa09f7857f52d8497790b26dc126bb250#upcoming-changes-preview-1
[NanaBox]: https://github.com/M2Team/NanaBox
[NanaZip]: https://github.com/M2Team/NanaZip

Originally, the prototype of the 2025 baseline is actually the 2027 baseline due
to the minimum supported version is Windows 11 (Build 22000) and Windows Server
2022 (Build 20348), but I have decided to add support for Windows 10, version
2004 (Build 19041) because of the following reasons:

- I hope I can use the new baseline for all my open-source projects as soon as
  possible, and I don't want to wait until the end of 2027.
- Windows 10, version 22H2 (Build 19045) will have at least 3 years of Extended
  Security Updates (ESU) program.
- Although Windows 10 Enterprise LTSC 2021 (Build 19044) will be end of life in
  2027, but I think I still need this version for several years may after 2027.

For [NanaZip], it will have more benefits to use the 2025 baseline, for example,
we also can migrate the Self Extracting Executables (SFX) to x86 (64-bit), and
it gives us chances to use Self Extracting Executables (SFX) archives under
64-bit Microsoft official Windows PE and Windows RE instances:

- For ARM (64-bit) Microsoft official Windows PE and Windows RE, you need to
  make sure you Windows PE and Windows RE images are built with Windows ADK
  Build 25398 or later and integrated the [x64 emulation optional component].
- For ARM (64-bit) Windows 10, I suggest you to upgrade to Windows 11 because
  ARM (64-bit) Windows 11 provides x64 emulation support, and Windows 10 is
  nearly end of support from Microsoft.

[x64 emulation optional component]: https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/winpe-add-packages--optional-components-reference?#32

## Frequently Asked Questions (FAQ)

### Why ARM (32-bit) support is removed in the 2021 baseline?

- The last ARM (32-bit) insider build of Windows desktop is Windows 10 Build
  15035 which is released in 2017, and the last ARM (32-bit) stable build is
  Windows RT 8.1 Update 3 which is released in 2015 and has been already
  end of support in 2023. Although Windows 10 IoT Core is still supported, but
  there are some better solutions for ARM (32-bit) IoT devices a.k.a. use Linux.
  Raspberry Pi devices should migrate to ARM (64-bit) Windows desktop for better
  user experience if you want to continue to use Windows on these devices.
- The newer ARM processors are deprecating ARM (32-bit) ISA support, and Apple
  Silicon M1 had removed the ARM (32-bit) ISA support at all. So we can't run
  ARM (32-bit) ISA version of Windows desktop applications on these devices.
- Windows has removed ARM (32-bit) application support since Windows 11 Build
  25905, and Windows 11, version 24H2 (Build 26100) SDK has removed ARM (32-bit)
  libraries.
- Reduce the size of release package and make the continuous integration faster.

### Why x86 (32-bit) support is removed in the 2025 baseline?

- Windows Server has removed x86 (32-bit) builds since Windows Server 2008 R2
  (Build 7600), and client SKUs has removed x86 (32-bit) builds since Windows
  11, version 21H2 (Build 22000).
- The last x86 (32-bit) long-term support Windows version is Windows 10, version
  1607 (Build 14393), which is end of support in 2026. Although Windows 10,
  version 1809 (Build 17763) and Windows 10, version 21H2 (Build 19044) are
  claimed to have x86 (32-bit) versions, but they are actually unable to boot on
  the last generation ISA of pure x86 (32-bit) machines a.k.a. Yonah, or called
  Intel Core, the next generation is well-known Intel Core 2.
- The ARM (64-bit) Windows 11 provides x86 (64-bit) emulation support, makes us
  can run x86 (64-bit) Windows desktop applications on ARM (64-bit) devices. So,
  we can ensure all components follow the 2025 baseline are 64-bit.

I'm one of users with a the last generation ISA of pure x86 (32-bit) machine. My
related machines uses Intel Celeron M 420, which is Yonah-based, I have tested
several Windows 10 builds after Windows 10, version 1607 (Build 14393), here are
the results:

- Windows 10, version 1703 (Build 15063): No issues, but end of life in 2019.
- Windows 10, version 1709 (Build 16299): No issues, but end of life in 2020.
- Windows 10, version 1803 (Build 17134): No issues, but end of life in 2021.
- Windows 10, version 1809 (Build 17763): Unable to boot which hungs at logo.
- Windows 10, version 1903 (Build 18362): No issues, but end of life in 2020.
- Windows 10, version 1909 (Build 18363): No issues, but end of life in 2022.
- Windows 10, version 2004 (Build 19041): You need to bypass OOBE to install,
  because the OOBE is much slower and makes everything timeout. You can see the
  desktop, but the system is very slow even you disable Windows Defender.
- Windows 10, version 20H2 (Build 19042): I don't know, but end of life in 2023.
- Windows 10, version 21H1 (Build 19043): I don't know, but end of life in 2022.
- Windows 10, version 21H2 (Build 19044): Unable to boot which hungs at logo.
- Windows 10, version 22H2 (Build 19045): I don't know, but I don't think it
  can boot.

Other guys which have the old machines have the same issues in some cases, read
https://msfn.org/board/topic/177957-unsupported-hardware-in-1803-and-1809 for
more information.

So, I think removing x86 (32-bit) support will be OK for supporting Windows 10,
version 2004 (Build 19041) or later.
