# MD5: Notes for building Windows 10 Enterprise LTSC 2021 x64 ISO

Work In Progress.

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
