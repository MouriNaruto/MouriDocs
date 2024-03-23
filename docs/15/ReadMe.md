# MD15: Windows System Restore Internals

[简体中文](ReadMe.zh-CN.md)

Work In Progress.

## References

- https://learn.microsoft.com/en-us/windows/win32/sr/system-restore-portal

## WMI Classes

### SystemRestore

> PowerShell -NoLogo -NoProfile -NonInteractive -InputFormat None -ExecutionPolicy Bypass Get-WmiObject -Class SystemRestore -Namespace "Root\Default"

- String CreationTime
- String Description
- UInt32 SequenceNumber
- UInt32 EventType
- UInt32 RestorePointType
- UInt32 CreateRestorePoint(String Description, UInt32 RestorePointType, UInt32 EventType)
- UInt32 Enable(String Drive, Boolean WaitTillEnabled)
- UInt32 Disable(String Drive)
- UInt32 Restore(UInt32 SequenceNumber)
- UInt32 GetLastRestoreStatus()

### SystemRestoreConfig

> PowerShell -NoLogo -NoProfile -NonInteractive -InputFormat None -ExecutionPolicy Bypass Get-WmiObject -Class SystemRestoreConfig -Namespace "Root\Default"

- UInt32 DiskPercent
  - Registry Key: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore\cfg
  - Registry Value: DiskPercent (REG_DWORD)
  - Default Value: 15
- String MyKey
  - Value: "SR" (Constant)
- UInt32 RPGlobalInterval
  - Registry Key: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore
  - Registry Value: RPGlobalInterval (REG_DWORD)
  - Default Value: 86400
- UInt32 RPLifeInterval
  - Registry Key: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore
  - Registry Value: RPLifeInterval (REG_DWORD)
  - Default Value: (None)
- UInt32 RPSessionInterval
  - Registry Key: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore
  - Registry Value: RPSessionInterval (REG_DWORD)
  - Default Value: (None)
