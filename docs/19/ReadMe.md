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
