# MD15: Windows System Restore Internals

[简体中文](ReadMe.zh-CN.md)

Work In Progress.

## References

- https://learn.microsoft.com/en-us/windows/win32/sr/system-restore-portal

## Registry

### HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore

#### RestoreStatusResult (REG_DWORD)

The status of the last system restore.

| Status | Description                       |
| ------ | --------------------------------- |
|      0 | The last restore failed.          |
|      1 | The last restore was successful.  |
|      2 | The last restore was interrupted. |

#### RPGlobalInterval (REG_DWORD)

The absolute time interval at which scheduled system checkpoints are created,
in seconds. The default value is 86,400 (24 hours).

Windows Vista: Receives a value from the task scheduler for System Restore.
Zero if the task is disabled.

#### RPLifeInterval (REG_DWORD)

The time interval for which restore points are preserved, in seconds. When a
restore point becomes older than this specified interval, it is deleted. The
default age limit is 90 days.

Windows Vista: Receives a value of UINTMAX.

#### RPSessionInterval (REG_DWORD)

The time interval at which scheduled system checkpoints are created during the
session, in seconds. The default value is zero, indicating that the feature is
turned off.

Windows Vista: Receives zero if System Restore is disabled.

### HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore\cfg

#### DiskPercent (REG_DWORD)

The maximum amount of disk space on each drive that can be used by System
Restore. This value is specified as a percentage of the total drive space.
The default value is 12 percent.

Windows Vista: Receives a value from the Volume Shadow Copy Service (VSS).
This is the maximum amount of disk space on each drive that can be used by
System Restore. The default value is 15 percent of the total drive space or
30 percent of the available free space, whichever is smaller.

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
  - See [RestoreStatusResult (REG_DWORD)](#RestoreStatusResult-REG_DWORD).

### SystemRestoreConfig

> PowerShell -NoLogo -NoProfile -NonInteractive -InputFormat None -ExecutionPolicy Bypass Get-WmiObject -Class SystemRestoreConfig -Namespace "Root\Default"

- UInt32 DiskPercent
  - See [DiskPercent (REG_DWORD)](#DiskPercent-REG_DWORD).
- String MyKey
  - Value: "SR" (Constant)
- UInt32 RPGlobalInterval
  - See [RPGlobalInterval (REG_DWORD)](#RPGlobalInterval-REG_DWORD).
- UInt32 RPLifeInterval
  - See [RPLifeInterval (REG_DWORD)](#RPLifeInterval-REG_DWORD).
- UInt32 RPSessionInterval
  - See [RPSessionInterval (REG_DWORD)](#RPSessionInterval-REG_DWORD).
