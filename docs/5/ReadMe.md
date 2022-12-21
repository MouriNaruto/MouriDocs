# MD5: Notes for building Windows 10 Enterprise LTSC 2021 x64 ISO

## Preparation

Open the Command Prompt which is run as administrator and change current
directory to the your defined workspace folder.

## Update boot.wim

```
DISM /Mount-Wim /WimFile:ISO\Sources\boot.wim /Index:2 /MountDir:MountPE
DISM /Image:MountPE /Add-Package /PackagePath:ssu-19041.1704-x64_70e350118b85fdae082ab7fde8165a947341ba1a.msu
DISM /Image:MountPE /Add-Package /PackagePath:windows10.0-kb5021233-x64_00bbf75a829a2cb4f37e4a2b876ea9503acfaf4d.msu
DISM /Image:MountPE /Cleanup-Image /StartComponentCleanup /ResetBase
DISM /Unmount-Image /MountDir:MountPE /Commit
DISM /Export-Image /SourceImageFile:ISO\Sources\boot.wim /SourceIndex:2 /Bootable /DestinationImageFile:ISO\Sources\boot.new.wim
del ISO\Sources\boot.wim
rename ISO\Sources\boot.new.wim boot.wim
```

## Update Setup Media

Extract windows10.0-kb5020377-x64_aa63fed981cc761dd28de9e0a0a204f6b7003d23.cab
to ISO\Sources.

## Update Windows\System32\Recovery\Winre.wim in install.wim

```
DISM /Mount-Wim /WimFile:ISO\Sources\install.wim /Index:1 /MountDir:Mount
DISM /Mount-Wim /WimFile:Mount\Windows\System32\Recovery\Winre.wim /Index:1 /MountDir:MountRE
DISM /Image:MountRE /Add-Package /PackagePath:ssu-19041.1704-x64_70e350118b85fdae082ab7fde8165a947341ba1a.msu
DISM /Image:MountRE /Add-Package /PackagePath:windows10.0-kb5021233-x64_00bbf75a829a2cb4f37e4a2b876ea9503acfaf4d.msu
DISM /Image:MountRE /Cleanup-Image /StartComponentCleanup /ResetBase
DISM /Unmount-Image /MountDir:MountRE /Commit
DISM /Export-Image /SourceImageFile:Mount\Windows\System32\Recovery\Winre.wim /SourceIndex:1 /Bootable /DestinationImageFile:Mount\Windows\System32\Recovery\Winre.new.wim
del Mount\Windows\System32\Recovery\Winre.wim
DISM /Unmount-Image /MountDir:Mount /Commit
DISM /Export-Image /SourceImageFile:ISO\Sources\install.wim /SourceIndex:1 /DestinationImageFile:ISO\Sources\install.new.wim
del ISO\Sources\install.wim
rename ISO\Sources\install.new.wim install.wim
```

## Update install.wim

```
DISM /Mount-Wim /WimFile:ISO\Sources\install.wim /Index:1 /MountDir:Mount
DISM /Image:Mount /Add-Package /PackagePath:ssu-19041.1704-x64_70e350118b85fdae082ab7fde8165a947341ba1a.msu
DISM /Image:Mount /Add-Package /PackagePath:windows10.0-kb5021233-x64_00bbf75a829a2cb4f37e4a2b876ea9503acfaf4d.msu
DISM /Image:Mount /Cleanup-Image /StartComponentCleanup /ResetBase
DISM /Image:Mount /Disable-Feature /FeatureName:Windows-Defender-Default-Definitions /Remove
DISM /Image:Mount /Add-Package /PackagePath:ISO\Sources\sxs
DISM /Image:Mount /Add-Package /PackagePath:dotnetfx481
DISM /Image:Mount /Add-Package /PackagePath:windows10.0-kb5020881-x64-ndp481_6f6447528c9634510aa1bc83b8f9003bc5bb6ab6.msu
DISM /Image:Mount /Add-Package /PackagePath:windows10.0-kb5021233-x64_00bbf75a829a2cb4f37e4a2b876ea9503acfaf4d.msu
DISM /Image:Mount /Add-ProvisionedAppxPackage /PackagePath:AppX\Microsoft.ScreenSketch_8wekyb3d8bbwe.appxbundle /LicensePath:AppX\Microsoft.ScreenSketch_8wekyb3d8bbwe.xml /DependencyPackagePath:AppX\Microsoft.VCLibs.x64.14.00.appx /DependencyPackagePath:AppX\Microsoft.UI.Xaml.x64.2.4.appx
DISM /Image:Mount /Add-ProvisionedAppxPackage /PackagePath:AppX\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle /LicensePath:AppX\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml /DependencyPackagePath:AppX\Microsoft.VCLibs.x64.14.00.appx /DependencyPackagePath:AppX\Microsoft.VCLibs.x64.14.00.Desktop.appx /DependencyPackagePath:AppX\Microsoft.UI.Xaml.x64.2.7.appx
DISM /Image:Mount /Add-ProvisionedAppxPackage /PackagePath:AppX\Microsoft.StorePurchaseApp_8wekyb3d8bbwe.appxbundle /LicensePath:AppX\Microsoft.StorePurchaseApp_8wekyb3d8bbwe.xml /DependencyPackagePath:AppX\Microsoft.VCLibs.x64.14.00.appx /DependencyPackagePath:AppX\Microsoft.NET.Native.Runtime.x64.2.2.appx /DependencyPackagePath:AppX\Microsoft.NET.Native.Framework.x64.2.2.appx
DISM /Image:Mount /Add-ProvisionedAppxPackage /PackagePath:AppX\Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.appxbundle /LicensePath:AppX\Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml /DependencyPackagePath:AppX\Microsoft.VCLibs.x64.14.00.appx /DependencyPackagePath:AppX\Microsoft.NET.Native.Runtime.x64.2.2.appx /DependencyPackagePath:AppX\Microsoft.NET.Native.Framework.x64.2.2.appx
DISM /Image:Mount /Add-ProvisionedAppxPackage /PackagePath:AppX\Microsoft.WindowsStore_8wekyb3d8bbwe.msixbundle /LicensePath:AppX\Microsoft.WindowsStore_8wekyb3d8bbwe.xml /DependencyPackagePath:AppX\Microsoft.VCLibs.x64.14.00.appx /DependencyPackagePath:AppX\Microsoft.NET.Native.Runtime.x64.2.2.appx /DependencyPackagePath:AppX\Microsoft.NET.Native.Framework.x64.2.2.appx /DependencyPackagePath:AppX\Microsoft.UI.Xaml.x64.2.7.appx
DISM /Unmount-Image /MountDir:Mount /Commit
DISM /Export-Image /SourceImageFile:ISO\Sources\install.wim /SourceIndex:1 /DestinationImageFile:ISO\Sources\install.new.wim
del ISO\Sources\install.wim
rename ISO\Sources\install.new.wim install.wim
rd /s /q ISO\Sources\sxs
```

## Disable Windows Defender

```
DISM /Mount-Wim /WimFile:ISO\Sources\install.wim /Index:1 /MountDir:Mount
reg load HKLM\OfflineSystem Mount\Windows\System32\config\SYSTEM
reg add HKLM\OfflineSystem\ControlSet001\Services\SecurityHealthService /t REG_DWORD /v Start /d 4 /f
reg add HKLM\OfflineSystem\ControlSet001\Services\WdBoot /t REG_DWORD /v Start /d 4 /f
reg add HKLM\OfflineSystem\ControlSet001\Services\WdFilter /t REG_DWORD /v Start /d 4 /f
reg add HKLM\OfflineSystem\ControlSet001\Services\WdNisDrv /t REG_DWORD /v Start /d 4 /f
reg add HKLM\OfflineSystem\ControlSet001\Services\WdNisSvc /t REG_DWORD /v Start /d 4 /f
reg add HKLM\OfflineSystem\ControlSet001\Services\WinDefend /t REG_DWORD /v Start /d 4 /f
reg unload HKLM\OfflineSystem
reg load HKLM\OfflineSoftware Mount\Windows\System32\config\SOFTWARE
reg add HKLM\OfflineSoftware\Microsoft\PolicyManager\default\Defender\AllowArchiveScanning /t REG_DWORD /v value /d 0 /f
reg add HKLM\OfflineSoftware\Microsoft\PolicyManager\default\Defender\AllowBehaviorMonitoring /t REG_DWORD /v value /d 0 /f
reg add HKLM\OfflineSoftware\Microsoft\PolicyManager\default\Defender\AllowCloudProtection /t REG_DWORD /v value /d 0 /f
reg add HKLM\OfflineSoftware\Microsoft\PolicyManager\default\Defender\AllowEmailScanning /t REG_DWORD /v value /d 0 /f
reg add HKLM\OfflineSoftware\Microsoft\PolicyManager\default\Defender\AllowFullScanOnMappedNetworkDrives /t REG_DWORD /v value /d 0 /f
reg add HKLM\OfflineSoftware\Microsoft\PolicyManager\default\Defender\AllowFullScanRemovableDriveScanning /t REG_DWORD /v value /d 0 /f
reg add HKLM\OfflineSoftware\Microsoft\PolicyManager\default\Defender\AllowIntrusionPreventionSystem /t REG_DWORD /v value /d 0 /f
reg add HKLM\OfflineSoftware\Microsoft\PolicyManager\default\Defender\AllowIOAVProtection /t REG_DWORD /v value /d 0 /f
reg add HKLM\OfflineSoftware\Microsoft\PolicyManager\default\Defender\AllowOnAccessProtection /t REG_DWORD /v value /d 0 /f
reg add HKLM\OfflineSoftware\Microsoft\PolicyManager\default\Defender\AllowRealtimeMonitoring /t REG_DWORD /v value /d 0 /f
reg add HKLM\OfflineSoftware\Microsoft\PolicyManager\default\Defender\AllowScanningNetworkFiles /t REG_DWORD /v value /d 0 /f
reg add HKLM\OfflineSoftware\Microsoft\PolicyManager\default\Defender\AllowScriptScanning /t REG_DWORD /v value /d 0 /f
reg unload HKLM\OfflineSoftware
DISM /Unmount-Image /MountDir:Mount /Commit
DISM /Export-Image /SourceImageFile:ISO\Sources\install.wim /SourceIndex:1 /DestinationImageFile:ISO\Sources\install.new.wim
del ISO\Sources\install.wim
rename ISO\Sources\install.new.wim install.wim
```

## Update ISO

Use UltraISO or similar tools.
