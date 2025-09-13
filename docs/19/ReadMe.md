# MD19: Notes for building a minimal Windows guest environment via Server Core

## Hotfixes

Reference: https://github.com/adavak/Win_ISO_Patching_Scripts

Here is the .NET Framework 4.8 for Windows Server 2019.

- Windows10.0-KB4486153-x64.cab
- Windows10.0-KB4486155-x64.cab

Here is the July 2024 Cumulative Update for Windows Server 2019.

- SSU-17763.6040-x64.cab
- Windows10.0-KB5040430-x64.cab

Here is the July 2024 Cumulative Update for .NET Framework 4.8 for Windows
Server 2019.

- Windows10.0-KB5039886-x64-NDP48.cab

## Integration Commands

This document uses Hyper-V Server 2019 as the example because it's free and
actually a Server Core SKU with Hyper-V role enabled.

### Mount the image

```
DISM /English /Mount-Wim /WimFile:install.wim /Index:1 /MountDir:Mount
```

### Remove all disabled roles/features with payloads

Reference: https://forums.mydigitallife.net/threads/80939/page-779#post-1833246

```
DISM /English /Image:Mount /Disable-Feature /FeatureName:BitLocker /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:Bitlocker-Utilities /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:BITS /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:CoreFileServer /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:DataCenterBridging /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:DataCenterBridging-LLDP-Tools /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:DiskIo-QoS /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:EnhancedStorage /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:FailoverCluster-AdminPak /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:FailoverCluster-AutomationServer /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:FailoverCluster-CmdInterface /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:FailoverCluster-FullServer /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:FailoverCluster-PowerShell /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:File-Services /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:File-Services-Search-Service /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:HypervisorPlatform /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:iSCSITargetServer-PowerShell /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:LightweightServer /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:MicrosoftWindowsPowerShellV2 /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux /Remove 
DISM /English /Image:Mount /Disable-Feature /FeatureName:MultipathIo /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:NetFx2-ServerCore /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:NetFx2-ServerCore-WOW64 /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:NetFx3 /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:NetFx3ServerFeatures /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:NetFx4Extended-ASPNET45 /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:PKIClient-PSH-Cmdlets /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:Remote-Desktop-Services /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:RSAT-Hyper-V-Tools-Feature /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:SecureBoot-PSH-Cmdlets /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:ServerManager-Core-RSAT /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:ServerManager-Core-RSAT-Feature-Tools /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:ServerManager-Core-RSAT-Role-Tools /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:ServerMediaFoundation /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:SMB1Protocol /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:SMB1Protocol-Client /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:SMB1Protocol-Server /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:SMBBW /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:SNMP /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:TelnetClient /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:VirtualMachinePlatform /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:WCF-HTTP-Activation /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:WCF-HTTP-Activation45 /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:WCF-MSMQ-Activation45 /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:WCF-NonHTTP-Activation /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:WCF-Pipe-Activation45 /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:WCF-TCP-Activation45 /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:WindowsServerBackup /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:WindowsStorageManagementService /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:WMISnmpProvider /Remove
```

### Integrate Servicing Stack Update (SSU)

```
DISM /English /Image:Mount /Add-Package /PackagePath:cu\SSU-17763.6040-x64.cab
```

### Integrate the latest Cumulative Update (Stage 1)

```
DISM /English /Image:Mount /Add-Package /PackagePath:cu\Windows10.0-KB5040430-x64.cab
```

### Cleanup the Windows Component Store

```
DISM /English /Image:Mount /Cleanup-Image /StartComponentCleanup /ResetBase
```

### Remove unnecessary roles/features with payloads for building a minimal guest

```
DISM /English /Image:Mount /Disable-Feature /FeatureName:Windows-Defender /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:Microsoft-Hyper-V-Configuration /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:Microsoft-Hyper-V-Management-PowerShell /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:Microsoft-Hyper-V-Offline /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:Microsoft-Hyper-V-Online /Remove
DISM /English /Image:Mount /Disable-Feature /FeatureName:Microsoft-Hyper-V /Remove
```

### Integrate Server Core App Compatibility Feature on Demand (FOD) 

```
DISM /English /Image:Mount /Add-Capability /CapabilityName:ServerCore.AppCompatibility~~~~0.0.1.0 /Source:E:\ /LimitAccess
```

### Integrate .NET Framework 3.5

```
DISM /English /Image:Mount /Add-Package /PackagePath:netfx35
```

### Integrate Internet Explorer 11

```
DISM /English /Image:Mount /Add-Package /PackagePath:ie
```

### Integrate .NET Framework 4.8

```
DISM /English /Image:Mount /Add-Package /PackagePath:netfx48
```

### Integrate the latest Cumulative Update (Stage 2)

```
DISM /English /Image:Mount /Add-Package /PackagePath:cu\Windows10.0-KB5040430-x64.cab
```

### Remove unnecessary folders

- \ProgramData\Microsoft\Windows Defender

### Unmount the image

```
DISM /English /Unmount-Image /MountDir:Mount /Commit
```

### Shrink the image

```
DISM /English /Export-Image /SourceImageFile:install.wim /SourceIndex:1 /DestinationImageFile:install.new.wim
del install.wim
rename install.new.wim install.wim
```

## Additional essential notes for better experience

### Enable minimal audio support

You need to enable Server Core App Compatibility Feature on Demand (FOD) first.

Then, you should copying the following files from a same build version of the
Windows image to the respective folders of your Server Core installation.

- \Windows\System32\AudioSrvPolicyManager.dll
- \Windows\System32\coreaudiopolicymanagerext.dll

I also suggest you to copy the volume mixer application for easier volume
control:

- \Windows\System32\SndVol.exe
- \Windows\System32\{Tag of your Windows language and region}\SndVol.exe.mui
  - For example: \Windows\System32\en-US\SndVol.exe.mui
  - For more information about the tag of your Windows language and region,
    please refer: https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/available-language-packs-for-windows

After copying the files, you need to enable and start the Windows Audio service:

```
sc config Audiosrv start= auto
sc start Audiosrv
```

If you want to use MPC-HC to play audio, you need to set the Audio Renderer to
Internal Audio Renderer in the "Playback -> Output" page of MPC-HC's options,
because we only have a minimal audio support.

### Using Aero theme instead of Aero Lite theme

You need to enable Server Core App Compatibility Feature on Demand (FOD) first.

Then, you should copying the following files from a same build version of the
Windows image to the respective folders of your Server Core installation.

- \Windows\Resources\Themes\aero\aero.msstyles
- \Windows\Resources\Themes\aero\{Tag of your Windows language and region}\aero.msstyles.mui
  - For example: \Windows\Resources\Themes\aero\en-US\aero.msstyles.mui
  - For more information about the tag of your Windows language and region,
    please refer: https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/available-language-packs-for-windows

After copying the files, you need to set the theme to Aero theme by modifying
the registry, here is the registry file which you can save as a .reg file and
import it:

```reg
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ThemeManager]
"DllName"=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,\
  74,00,25,00,5c,00,72,00,65,00,73,00,6f,00,75,00,72,00,63,00,65,00,73,00,5c,\
  00,74,00,68,00,65,00,6d,00,65,00,73,00,5c,00,41,00,65,00,72,00,6f,00,5c,00,\
  41,00,65,00,72,00,6f,00,2e,00,6d,00,73,00,73,00,74,00,79,00,6c,00,65,00,73,\
  00,00,00

[HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ThemeManager]
"DllName"=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,\
  74,00,25,00,5c,00,72,00,65,00,73,00,6f,00,75,00,72,00,63,00,65,00,73,00,5c,\
  00,74,00,68,00,65,00,6d,00,65,00,73,00,5c,00,41,00,65,00,72,00,6f,00,5c,00,\
  41,00,65,00,72,00,6f,00,2e,00,6d,00,73,00,73,00,74,00,79,00,6c,00,65,00,73,\
  00,00,00
```

After importing the registry file, you need to sign out and sign in again to
apply the theme change.

### Workaround for enabling Chinese (Simplified) IME

For Windows Server Core which build is 19041 or later, you need to use this
workaround if you want to use Chinese (Simplified) IME.

You need to enable Server Core App Compatibility Feature on Demand (FOD) first.

Then, you need to set the theme to Aero theme by modifying the registry, here is
the registry file which you can save as a .reg file and import it:

```reg
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SOFTWARE]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{046B8C80-1647-40F7-9B21-B93B81AABC1B}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{046B8C80-1647-40F7-9B21-B93B81AABC1B}\{6a498709-e00b-4c45-a018-8f9e4081ae40}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{13A016DF-560B-46CD-947A-4C3AF1E0E35D}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{13A016DF-560B-46CD-947A-4C3AF1E0E35D}\{6a498709-e00b-4c45-a018-8f9e4081ae40}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{25504FB4-7BAB-4BC1-9C69-CF81890F0EF5}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{25504FB4-7BAB-4BC1-9C69-CF81890F0EF5}\{6a498709-e00b-4c45-a018-8f9e4081ae40}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{34745C63-B2F0-4784-8B67-5E12C8701A31}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{34745C63-B2F0-4784-8B67-5E12C8701A31}\{6a498709-e00b-4c45-a018-8f9e4081ae40}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{364215D9-75BC-11D7-A6EF-00065B84435C}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{364215D9-75BC-11D7-A6EF-00065B84435C}\{6a498709-e00b-4c45-a018-8f9e4081ae40}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{3AF314A2-D79F-4B1B-9992-15086D339B05}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{3AF314A2-D79F-4B1B-9992-15086D339B05}\{6a498709-e00b-4c45-a018-8f9e4081ae40}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{49D2F9CE-1F5E-11D7-A6D3-00065B84435C}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{49D2F9CE-1F5E-11D7-A6D3-00065B84435C}\{6a498709-e00b-4c45-a018-8f9e4081ae40}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{49D2F9CF-1F5E-11D7-A6D3-00065B84435C}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{49D2F9CF-1F5E-11D7-A6D3-00065B84435C}\{6a498709-e00b-4c45-a018-8f9e4081ae40}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{74769ee9-4a66-4f9d-90d6-bf8b7c3eb461}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{74769ee9-4a66-4f9d-90d6-bf8b7c3eb461}\{6a498709-e00b-4c45-a018-8f9e4081ae40}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{CCF05DD7-4A87-11D7-A6E2-00065B84435C}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Category\{CCF05DD7-4A87-11D7-A6E2-00065B84435C}\{6a498709-e00b-4c45-a018-8f9e4081ae40}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Item]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Item\{6a498709-e00b-4c45-a018-8f9e4081ae40}]
"Description"="ChsIME.EXE"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Item\{6a498709-e00b-4c45-a018-8f9e4081ae40}\{046B8C80-1647-40F7-9B21-B93B81AABC1B}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Item\{6a498709-e00b-4c45-a018-8f9e4081ae40}\{13A016DF-560B-46CD-947A-4C3AF1E0E35D}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Item\{6a498709-e00b-4c45-a018-8f9e4081ae40}\{25504FB4-7BAB-4BC1-9C69-CF81890F0EF5}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Item\{6a498709-e00b-4c45-a018-8f9e4081ae40}\{34745C63-B2F0-4784-8B67-5E12C8701A31}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Item\{6a498709-e00b-4c45-a018-8f9e4081ae40}\{364215D9-75BC-11D7-A6EF-00065B84435C}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Item\{6a498709-e00b-4c45-a018-8f9e4081ae40}\{3AF314A2-D79F-4B1B-9992-15086D339B05}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Item\{6a498709-e00b-4c45-a018-8f9e4081ae40}\{49D2F9CE-1F5E-11D7-A6D3-00065B84435C}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Item\{6a498709-e00b-4c45-a018-8f9e4081ae40}\{49D2F9CF-1F5E-11D7-A6D3-00065B84435C}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Item\{6a498709-e00b-4c45-a018-8f9e4081ae40}\{74769ee9-4a66-4f9d-90d6-bf8b7c3eb461}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\Category\Item\{6a498709-e00b-4c45-a018-8f9e4081ae40}\{CCF05DD7-4A87-11D7-A6E2-00065B84435C}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\LanguageProfile]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\LanguageProfile\0x00000804]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{6a498709-e00b-4c45-a018-8f9e4081ae40}\LanguageProfile\0x00000804\{82590C13-F4DD-44f4-BA1D-8667246FDF8E}]
"Description"="Microsoft Wubi"
"Display Description"=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,\
  52,00,6f,00,6f,00,74,00,25,00,5c,00,53,00,59,00,53,00,54,00,45,00,4d,00,33,\
  00,32,00,5c,00,69,00,6e,00,70,00,75,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,\
  2d,00,35,00,33,00,30,00,32,00,00,00
"Enable"=dword:00000000
"IconFile"=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,\
  74,00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,49,\
  00,6e,00,70,00,75,00,74,00,4d,00,65,00,74,00,68,00,6f,00,64,00,5c,00,53,00,\
  68,00,61,00,72,00,65,00,64,00,5c,00,52,00,65,00,73,00,6f,00,75,00,72,00,63,\
  00,65,00,44,00,6c,00,6c,00,2e,00,64,00,6c,00,6c,00,00,00
"IconIndex"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{046B8C80-1647-40F7-9B21-B93B81AABC1B}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{046B8C80-1647-40F7-9B21-B93B81AABC1B}\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{13A016DF-560B-46CD-947A-4C3AF1E0E35D}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{13A016DF-560B-46CD-947A-4C3AF1E0E35D}\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{25504FB4-7BAB-4BC1-9C69-CF81890F0EF5}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{25504FB4-7BAB-4BC1-9C69-CF81890F0EF5}\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{34745C63-B2F0-4784-8B67-5E12C8701A31}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{34745C63-B2F0-4784-8B67-5E12C8701A31}\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{364215D9-75BC-11D7-A6EF-00065B84435C}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{364215D9-75BC-11D7-A6EF-00065B84435C}\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{3AF314A2-D79F-4B1B-9992-15086D339B05}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{3AF314A2-D79F-4B1B-9992-15086D339B05}\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{49D2F9CE-1F5E-11D7-A6D3-00065B84435C}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{49D2F9CE-1F5E-11D7-A6D3-00065B84435C}\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{49D2F9CF-1F5E-11D7-A6D3-00065B84435C}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{49D2F9CF-1F5E-11D7-A6D3-00065B84435C}\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{74769ee9-4a66-4f9d-90d6-bf8b7c3eb461}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{74769ee9-4a66-4f9d-90d6-bf8b7c3eb461}\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{CCF05DD7-4A87-11D7-A6E2-00065B84435C}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Category\{CCF05DD7-4A87-11D7-A6E2-00065B84435C}\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Item]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Item\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}]
"Description"="ChsIME.exe"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Item\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\{046B8C80-1647-40F7-9B21-B93B81AABC1B}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Item\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\{13A016DF-560B-46CD-947A-4C3AF1E0E35D}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Item\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\{25504FB4-7BAB-4BC1-9C69-CF81890F0EF5}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Item\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\{34745C63-B2F0-4784-8B67-5E12C8701A31}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Item\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\{364215D9-75BC-11D7-A6EF-00065B84435C}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Item\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\{3AF314A2-D79F-4B1B-9992-15086D339B05}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Item\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\{49D2F9CE-1F5E-11D7-A6D3-00065B84435C}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Item\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\{49D2F9CF-1F5E-11D7-A6D3-00065B84435C}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Item\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\{74769ee9-4a66-4f9d-90d6-bf8b7c3eb461}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\Category\Item\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\{CCF05DD7-4A87-11D7-A6E2-00065B84435C}]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\LanguageProfile]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\LanguageProfile\0x00000804]

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CTF\TIP\{81d4e9c9-1d3b-41bc-9e6c-4b40bf79e35e}\LanguageProfile\0x00000804\{FA550B04-5AD7-411f-A5AC-CA038EC515D7}]
"Description"="Microsoft Pinyin"
"Display Description"=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,\
  52,00,6f,00,6f,00,74,00,25,00,5c,00,53,00,59,00,53,00,54,00,45,00,4d,00,33,\
  00,32,00,5c,00,69,00,6e,00,70,00,75,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,\
  2d,00,35,00,33,00,30,00,30,00,00,00
"Enable"=dword:00000000
"IconFile"=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,\
  74,00,25,00,5c,00,53,00,59,00,53,00,54,00,45,00,4d,00,33,00,32,00,5c,00,49,\
  00,6e,00,70,00,75,00,74,00,4d,00,65,00,74,00,68,00,6f,00,64,00,5c,00,53,00,\
  68,00,61,00,72,00,65,00,64,00,5c,00,52,00,65,00,73,00,6f,00,75,00,72,00,63,\
  00,65,00,44,00,6c,00,6c,00,2e,00,64,00,6c,00,6c,00,00,00
"IconIndex"=dword:00000000

[HKEY_CURRENT_USER\Keyboard Layout]

[HKEY_CURRENT_USER\Keyboard Layout\Preload]
"1"="00000804"
"2"="00000409"

[HKEY_CURRENT_USER\SOFTWARE]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\CTF]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\CTF\TIP]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\CTF\TIP\{81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\CTF\TIP\{81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E}\LanguageProfile]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\CTF\TIP\{81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E}\LanguageProfile\0x00000804]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\CTF\TIP\{81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E}\LanguageProfile\0x00000804\{FA550B04-5AD7-411F-A5AC-CA038EC515D7}]
"Enable"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\CTF\HiddenDummyLayouts]
"00000804"="00000804"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\CTF\Assemblies]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\CTF\Assemblies\0x00000804]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\CTF\Assemblies\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31}]
"Default"="{81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E}"
"Profile"="{FA550B04-5AD7-411F-A5AC-CA038EC515D7}"
"KeyboardLayout"=dword:08040804

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputMethod]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputMethod\Settings]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\InputMethod\Settings\CHS]
"Default Mode"=dword:00000001

[HKEY_USERS\.DEFAULT]

[HKEY_USERS\.DEFAULT\Keyboard Layout]

[HKEY_USERS\.DEFAULT\Keyboard Layout\Preload]
"1"="00000804"
"2"="00000409"

[HKEY_USERS\.DEFAULT\Software]

[HKEY_USERS\.DEFAULT\Software\Microsoft]

[HKEY_USERS\.DEFAULT\Software\Microsoft\CTF]

[HKEY_USERS\.DEFAULT\Software\Microsoft\CTF\TIP]

[HKEY_USERS\.DEFAULT\Software\Microsoft\CTF\TIP\{81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E}]

[HKEY_USERS\.DEFAULT\Software\Microsoft\CTF\TIP\{81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E}\LanguageProfile]

[HKEY_USERS\.DEFAULT\Software\Microsoft\CTF\TIP\{81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E}\LanguageProfile\0x00000804]

[HKEY_USERS\.DEFAULT\Software\Microsoft\CTF\TIP\{81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E}\LanguageProfile\0x00000804\{FA550B04-5AD7-411F-A5AC-CA038EC515D7}]
"Enable"=dword:00000001

[HKEY_USERS\.DEFAULT\Software\Microsoft\CTF\HiddenDummyLayouts]
"00000804"="00000804"

[HKEY_USERS\.DEFAULT\Software\Microsoft\CTF\Assemblies]

[HKEY_USERS\.DEFAULT\Software\Microsoft\CTF\Assemblies\0x00000804]

[HKEY_USERS\.DEFAULT\Software\Microsoft\CTF\Assemblies\0x00000804\{34745C63-B2F0-4784-8B67-5E12C8701A31}]
"Default"="{81D4E9C9-1D3B-41BC-9E6C-4B40BF79E35E}"
"Profile"="{FA550B04-5AD7-411F-A5AC-CA038EC515D7}"
"KeyboardLayout"=dword:08040804

[HKEY_USERS\.DEFAULT\Software\Microsoft\InputMethod]

[HKEY_USERS\.DEFAULT\Software\Microsoft\InputMethod\Settings]

[HKEY_USERS\.DEFAULT\Software\Microsoft\InputMethod\Settings\CHS]
"Default Mode"=dword:00000001
```

After importing the registry file, you need to sign out and sign in again to
apply the theme change.
