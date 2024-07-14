# MD19: Notes for building a minimal Windows guest environment via Server Core

This document uses Hyper-V Server 2019 as the example because it's free and
actually a Server Core SKU with Hyper-V role enabled.

## Remove all disabled roles/features with payloads

Reference: https://forums.mydigitallife.net/threads/80939/page-779#post-1833246

Here is the commands list to remove all roles/features payload for Hyper-V
Server 2019 image.

```
DISM /English /Image:F:\ /Disable-Feature /FeatureName:BitLocker /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:Bitlocker-Utilities /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:BITS /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:CoreFileServer /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:DataCenterBridging /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:DataCenterBridging-LLDP-Tools /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:DiskIo-QoS /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:EnhancedStorage /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:FailoverCluster-AdminPak /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:FailoverCluster-AutomationServer /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:FailoverCluster-CmdInterface /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:FailoverCluster-FullServer /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:FailoverCluster-PowerShell /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:File-Services /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:File-Services-Search-Service /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:HypervisorPlatform /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:iSCSITargetServer-PowerShell /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:LightweightServer /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:MicrosoftWindowsPowerShellV2 /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux /Remove 
DISM /English /Image:F:\ /Disable-Feature /FeatureName:MultipathIo /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:NetFx2-ServerCore /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:NetFx2-ServerCore-WOW64 /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:NetFx3 /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:NetFx3ServerFeatures /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:NetFx4Extended-ASPNET45 /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:PKIClient-PSH-Cmdlets /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:Remote-Desktop-Services /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:RSAT-Hyper-V-Tools-Feature /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:SecureBoot-PSH-Cmdlets /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:ServerManager-Core-RSAT /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:ServerManager-Core-RSAT-Feature-Tools /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:ServerManager-Core-RSAT-Role-Tools /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:ServerMediaFoundation /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:SMB1Protocol /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:SMB1Protocol-Client /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:SMB1Protocol-Server /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:SMBBW /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:SNMP /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:TelnetClient /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:VirtualMachinePlatform /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:WCF-HTTP-Activation /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:WCF-HTTP-Activation45 /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:WCF-MSMQ-Activation45 /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:WCF-NonHTTP-Activation /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:WCF-Pipe-Activation45 /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:WCF-TCP-Activation45 /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:WindowsServerBackup /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:WindowsStorageManagementService /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:WMISnmpProvider /Remove
```

## Remove unnecessary roles/features with payloads for building a minimal guest

Here is the commands list to remove all roles/features payload for Hyper-V
Server 2019 image.

```
DISM /English /Image:F:\ /Disable-Feature /FeatureName:Windows-Defender /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:Microsoft-Hyper-V-Configuration /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:Microsoft-Hyper-V-Management-PowerShell /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:Microsoft-Hyper-V-Offline /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:Microsoft-Hyper-V-Online /Remove
DISM /English /Image:F:\ /Disable-Feature /FeatureName:Microsoft-Hyper-V /Remove
```

## Integrate Server Core App Compatibility Feature on Demand (FOD) 

```
DISM /English /Image:F:\ /Add-Capability /CapabilityName:ServerCore.AppCompatibility~~~~0.0.1.0 /Source:H:\ /LimitAccess
```

## Integrate .NET Framework 3.5 and Internet Explorer 11

```
DISM /English /Image:F:\ /Add-Package /PackagePath:G:\sources\sxs
```
