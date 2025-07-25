# MD23: The baselines of Windows targets for all my open-source projects

Work In Progress.

## Baselines

### 2025 Baseline

- Supported Operating Systems:
  - Windows 10, version 2004 (Build 19041) or later
- Supported Platforms:
  - x86 (64-bit)
  - ARM (64-bit)

This has already been the baseline for [NanaBox] and [NanaZip] modern flavor,
and it will be applied to all components in [NanaZip], even all my open-source
projects in the near future. Here are the reasons why I set this baseline:

[NanaBox]: https://github.com/M2Team/NanaBox
[NanaZip]: https://github.com/M2Team/NanaZip

- It seems that Microsoft STL no longer supports targeting Windows 7 / Server
  2008 R2, Windows 8 / Server 2012, and Windows 8.1 / Server 2012 R2 in the
  [next major version]. They also set the minimum supported version to Windows
  10 / Server 2016, I guess they will also modify the policy of the default
  subsystem version to 10.0 and limit the minimum subsystem version developers
  can set without hacking the binaries in the next MSVC major version.
- Here are some benefits for [NanaZip]:
  - We can use 19041 Universal CRT (UCRT), which we can reuse the C++ FH4 in x86
    (64-bit) targets to save 15 KiB size for each binary.
  - We also can migrate the Self Extracting Executables (SFX) to x86 (64-bit).
    - It can give us a chance to use Self Extracting Executables (SFX) archives
      under 64-bit Microsoft official Windows PE and Windows RE instances.
    - For ARM (64-bit) Microsoft official Windows PE and Windows RE, you need to
      make sure you Windows PE and Windows RE images are built with Windows ADK
      Build 25398 and integrated the [x64 emulation optional component].
    - For ARM (64-bit) Windows 10, I suggest you to upgrade to Windows 11
      because ARM (64-bit) Windows 11 provides x64 emulation support, and
      Windows 10 is nearly end of support from Microsoft.
  - We can reduce many fallbacks in the codebase, which will simplify the
    codebase and reduce the size of binaries.

[next major version]: https://github.com/microsoft/STL/wiki/Changelog/0ce45c7fa09f7857f52d8497790b26dc126bb250#upcoming-changes-preview-1
[x64 emulation optional component]: https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/winpe-add-packages--optional-components-reference?#32

### 2021 Baseline

- Supported Operating Systems:
  - Windows Vista and Windows Server 2008 (Build 6000) or later
- Supported Platforms:
  - x86 (64-bit)
  - x86 (32-bit)
  - ARM (64-bit)

This is the baseline since [NSudo 8.2], which removed support for ARM (32-bit)
due to the following reasons in 2021 as historical reference:

[NSudo 8.2]: https://github.com/M2TeamArchived/NSudo/releases/tag/8.2

- The latest version of ARM32 version for Windows desktop is Redstone 2 Insider
  Build 15035. I know Windows RT 8.1 and Windows 10 IoT Core aren't in the 
  stage of end of support, but most of daily users are drop their devices 
  (Windows RT 8.x tablets) or have a better solution (Windows 10 IoT Core users
  on Raspberry Pi devices should migrate to Linux or ARM64 version for Windows
  10 desktop).
- Future ARM processors are deprecating ARM32 ISA support, and Apple Silicon M1
  had dropped the ARM32 support at all. So we can't run ARM32 version of 
  Windows desktop applications on these devices.
- I'm considering the possibility of using Rust, .NET, and Project Reunion to
  write a part of the implementation of some projects in the future, and these
  infrastructures will not reconsider support for ARM32 support on Windows.
- Reduce the size of release package and make the continuous integration
  faster.

### 2017 Baseline

- Supported Operating Systems:
  - Windows Vista and Windows Server 2008 (Build 6000) or later
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
  - Windows Vista and Windows Server 2008 (Build 6000) or later
- Supported Platforms:
  - x86 (64-bit)
  - x86 (32-bit)

This is the initial baseline when I started to use C and C++ in my open-source
projects.
