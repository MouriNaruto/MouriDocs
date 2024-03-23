# MD15: Windows System Restore Internals

[简体中文](ReadMe.zh-CN.md)

Work In Progress.

## References

- https://learn.microsoft.com/en-us/windows/win32/sr/system-restore-portal

## System Restore WMI Classes Internals

### SystemRestore class

> PowerShell -NoLogo -NoProfile -NonInteractive -InputFormat None -ExecutionPolicy Bypass Get-WmiObject -Class SystemRestore -Namespace "Root\Default"

- CreationTime (String)
- Description (String)
- SequenceNumber (UInt32)
- EventType (UInt32)
- RestorePointType (UInt32)
- UInt32 CreateRestorePoint(String Description, UInt32 RestorePointType, UInt32 EventType);
- UInt32 Enable(String Drive, Boolean WaitTillEnabled);
- UInt32 Disable(String Drive);
- UInt32 Restore(UInt32 SequenceNumber);
- UInt32 GetLastRestoreStatus();

### SystemRestoreConfig class

> PowerShell -NoLogo -NoProfile -NonInteractive -InputFormat None -ExecutionPolicy Bypass Get-WmiObject -Class SystemRestoreConfig -Namespace "Root\Default"

- DiskPercent (UInt32)
  - Registry Key: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore\cfg
  - Registry Value: DiskPercent (REG_DWORD)
  - Default Value: 15
- RPGlobalInterval (UInt32)
  - Registry Key: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore
  - Registry Value: RPGlobalInterval (REG_DWORD)
  - Default Value: 86400
- RPLifeInterval (UInt32)
  - Registry Key: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore
  - Registry Value: RPLifeInterval (REG_DWORD)
  - Default Value: (None)
- RPSessionInterval (UInt32)
  - Registry Key: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore
  - Registry Value: RPSessionInterval (REG_DWORD)
  - Default Value: (None)
