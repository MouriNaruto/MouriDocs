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
- \Windows\System32\wdmaud.drv
- \Windows\System32\{Tag of your Windows language and region}\wdmaud.drv.mui
  - For example: \Windows\System32\en-US\wdmaud.drv.mui
  - For more information about the tag of your Windows language and region,
    please refer: https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/available-language-packs-for-windows
- \Windows\SysWOW64\wdmaud.drv
- \Windows\System32\Drivers\gm.dls
- \Windows\System32\midimap.dll
- \Windows\SysWOW64\Drivers\gm.dls
- \Windows\SysWOW64\midimap.dll

I also suggest you to copy the volume mixer application for easier volume
control:

- \Windows\System32\SndVol.exe
- \Windows\System32\{Tag of your Windows language and region}\SndVol.exe.mui
  - For example: \Windows\System32\en-US\SndVol.exe.mui
  - For more information about the tag of your Windows language and region,
    please refer: https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/available-language-packs-for-windows
- \Windows\SysWOW64\SndVol.exe
- \Windows\SysWOW64\{Tag of your Windows language and region}\SndVol.exe.mui
  - For example: \Windows\System32\en-US\SndVol.exe.mui
  - For more information about the tag of your Windows language and region,
    please refer: https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/available-language-packs-for-windows

After copying the files, you need to set the theme to Aero theme by modifying
the registry, here is the commands you can run in an elevated Command Prompt
window:

```
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Drivers32" /v "aux" /t REG_SZ /d "wdmaud.drv" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Drivers32" /v "midi" /t REG_SZ /d "wdmaud.drv" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Drivers32" /v "midimapper" /t REG_SZ /d "midimap.dll" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Drivers32" /v "mixer" /t REG_SZ /d "wdmaud.drv" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Drivers32" /v "wave" /t REG_SZ /d "wdmaud.drv" /f
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Drivers32" /v "aux" /t REG_SZ /d "wdmaud.drv" /f
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Drivers32" /v "midi" /t REG_SZ /d "wdmaud.drv" /f
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Drivers32" /v "midimapper" /t REG_SZ /d "midimap.dll" /f
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Drivers32" /v "mixer" /t REG_SZ /d "wdmaud.drv" /f
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows NT\CurrentVersion\Drivers32" /v "wave" /t REG_SZ /d "wdmaud.drv" /f
```

After modifying the registry, you need to enable and start the Windows Audio
service:

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
the registry, here is the commands you can run in an elevated Command Prompt
window:

```
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ThemeManager" /v "DllName" /t REG_EXPAND_SZ /d "%SystemRoot%\Resources\Themes\aero\aero.msstyles" /f
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\ThemeManager" /v "DllName" /t REG_EXPAND_SZ /d "%SystemRoot%\Resources\Themes\aero\aero.msstyles" /f
reg load HKU\DEFAULT %SystemDrive%\Users\Default\NTUSER.DAT
reg add "HKU\DEFAULT\Software\Microsoft\Windows\CurrentVersion\ThemeManager" /v "DllName" /t REG_EXPAND_SZ /d "%SystemRoot%\Resources\Themes\aero\aero.msstyles" /f
reg unload HKU\DEFAULT
```

After modifying the registry, you need to sign out and sign in again to apply
the theme change.

### Workaround for enabling Chinese (Simplified) IME

For Windows Server Core which build is 19041 or later, you need to use this
workaround if you want to use Chinese (Simplified) IME.

You need to enable Server Core App Compatibility Feature on Demand (FOD) first.

Then, you need to set the theme to Aero theme by modifying the registry, for the
registry file content, please refer to [ServerCoreMicrosoftImeFixes.reg](ServerCoreMicrosoftImeFixes.reg).

For importing the registry file, you need to run the following commands in an
elevated Command Prompt window:

```
reg load HKU\DEFAULT %SystemDrive%\Users\Default\NTUSER.DAT
reg import {The full path of the ServerCoreMicrosoftImeFixes.reg file}
reg unload HKU\DEFAULT
```

After importing the registry file, you need to sign out and sign in again to
apply the theme change.
