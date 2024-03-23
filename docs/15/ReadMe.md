# MD15: Windows System Restore Internals

[简体中文](ReadMe.zh-CN.md)

Work In Progress.

## References

- https://learn.microsoft.com/en-us/windows/win32/sr/system-restore-portal

## System Restore C API (SrClient.dll)

### RESTOREPOINTINFOA

```cpp
typedef struct _RESTOREPTINFOA
{
    DWORD dwEventType;
    DWORD dwRestorePtType;
    INT64 llSequenceNumber;
    CHAR szDescription[MAX_DESC];
} RESTOREPOINTINFOA, *PRESTOREPOINTINFOA;
```

### RESTOREPOINTINFOW

```cpp
typedef struct _RESTOREPTINFOW
{
    DWORD dwEventType;
    DWORD dwRestorePtType;
    INT64 llSequenceNumber;
    WCHAR szDescription[MAX_DESC_W];
} RESTOREPOINTINFOW, *PRESTOREPOINTINFOW;
```

Contains information used by the [SRSetRestorePoint] function.

**dwEventType**

**dwRestorePtType**

**llSequenceNumber**

The sequence number of the restore point. To end a system change, set this to
the sequence number returned by the previous call to [SRSetRestorePoint].

**szDescription**

The description to be displayed so the user can easily identify a restore 
point. The maximum length of an ANSI string is MAX_DESC. The maximum length
of a Unicode string is MAX_DESC_W.

The following table shows the recommended description text.

| System modification        | Restore point type    | Description          |
| -------------------------- | --------------------- | -------------------- |
| Application installation   | APPLICATION_INSTALL   | Installed AppName    |
| Application modification   | MODIFY_SETTINGS       | Configured AppName   |
| Application removal        | APPLICATION_UNINSTALL | Removed AppName      |
| Device driver installation | DEVICE_DRIVER_INSTALL | Installed DriverName |

### STATEMGRSTATUS

```cpp
typedef struct _SMGRSTATUS 
{
    DWORD nStatus;
    INT64 llSequenceNumber;
} STATEMGRSTATUS, *PSTATEMGRSTATUS;
```

Contains status information used by the [SRSetRestorePoint] function.

**nStatus**

The status code. The following table lists the status codes returned. Note that
all the status codes indicate failure except ERROR_SUCCESS.

- ERROR_SUCCESS
  - If the call succeeded (return value will be TRUE).
- ERROR_TIMEOUT
  - If the call timed out due to a wait on a mutex for setting restore points.
- ERROR_INVALID_DATA
  - If the cancel restore point is called with an invalid sequence number.
- ERROR_INTERNAL_ERROR
  - If an internal error occurred.
- ERROR_BAD_ENVIRONMENT
  - If the function was called in safe mode.
- ERROR_SERVICE_DISABLED
  - If System Restore is disabled.
- ERROR_DISK_FULL
  - System Restore is in standby mode because disk space is low.
- ERROR_ALREADY_EXISTS
  - If this is a nested restore point.

**llSequenceNumber**

The sequence number of the restore point.

### DisableSR (Undocumented)

### DisableSRInternal (Undocumented)

### EnableSR (Undocumented)

### EnableSREx (Undocumented)

### EnableSRInternal (Undocumented)

### SRNewSystemId (Undocumented)

### SRRemoveRestorePoint

```cpp
EXTERN_C DWORD WINAPI SRRemoveRestorePoint(
    _In_ DWORD dwRPNum);
```

Deletes the specified restore point.

If the function succeeds, the return value is ERROR_SUCCESS.

If the specified restore point does not exist or cannot be removed, the return
value is ERROR_INVALID_DATA. All other error codes indicate an internal error.

**dwRPNum**

The sequence number of the restore point.

### SRSetRestorePointA

```cpp
EXTERN_C BOOL WINAPI SRSetRestorePointA(
    _In_ PRESTOREPOINTINFOA pRestorePtSpec,
    _Out_ PSTATEMGRSTATUS pSMgrStatus);
```

### SRSetRestorePointInternal (Undocumented)

### SRSetRestorePointW

```cpp
EXTERN_C BOOL WINAPI SRSetRestorePointW(
    _In_ PRESTOREPOINTINFOW pRestorePtSpec,
    _Out_ PSTATEMGRSTATUS pSMgrStatus);
```

Specifies the beginning and the ending of a set of changes so that System 
Restore can create a restore point.

If the function succeeds, the return value is TRUE. The llSequenceNumber member
of pSMgrStatus receives the sequence number of the restore point.

If the function fails, the return value is FALSE. The nStatus member of
pSMgrStatus receives error information.

**pRestorePtSpec**

A pointer to a [RESTOREPOINTINFO] structure that specifies the restore point.

**pSMgrStatus**

A pointer to a [STATEMGRSTATUS] structure that receives the status information.

Read https://learn.microsoft.com/en-us/windows/win32/api/srrestoreptapi/nf-srrestoreptapi-srsetrestorepointw#remarks
for more detailed usage.

### SetSRStateAfterSetup (Undocumented)

### SysprepCleanup (Undocumented)

### SysprepGeneralize (Undocumented)

## Registry

### HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore

#### DisableConfig (REG_DWORD)

If this registry key value is 1, the option to configure System Restore through
System Protection is disabled. If this value is 0 or deleted, users can change
the System Restore settings through System Protection. 

#### DisableSR (REG_DWORD)

If this registry key value is 1, System Restore is turned off, and the System
Restore Wizard cannot be accessed. The option to configure System Restore or
create a restore point through System Protection is also disabled. If this
value is 0 or deleted, users can perform System Restore and configure System
Restore settings through System Protection.

### HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore

#### FirstRun (REG_DWORD)

#### LastIndex (REG_DWORD)

The last sequence number of the restore point.

#### LastMainenanceTaskRunTimeStamp (REG_QWORD)

#### LastRestoreId

#### RestoreStatusDescription

#### RestoreStatusDetails

#### RestoreStatusRestore

#### RestoreStatusResult

#### RestoreStatusSource

#### RestoreStatusTimeStamp

#### RestoreStatusUndo

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

#### ScopeSnapshots (REG_DWORD)

This option is available starting with Windows 8.

System Restore running on Windows 8 monitors files in the boot volume that 
are relevant for system restore only. Snapshots of the boot volume created 
by System Restore running on Windows 8 may be deleted if the snapshot is 
subsequently exposed by an earlier version of Windows. Note that although
there is only one system volume, there is one boot volume for each operating
system in a multi-boot system.

If this registry key value is 0, System Restore creates snapshots of the boot
volume in the same way as in earlier versions of Windows. If this value is
deleted, System Restore running on Windows 8 resumes creating snapshots that
monitor files in the boot volume that are relevant for system restore only.

#### SRInitDone (REG_DWORD)

#### SystemRestorePointCreationFrequency (REG_DWORD)

This option is available starting with Windows 8.

The value of this registry key can change the frequency of restore point
creation. The value of this registry key can change the frequency of restore
point creation.

If the application calls SRSetRestorePoint to create a restore point, and the
registry key value is 0, system restore does not skip creating the new restore
point.

If the application calls SRSetRestorePoint to create a restore point, and the
registry key value is the integer N, system restore skips creating a new restore
point if any restore points were created in the previous N minutes.

Applications should create this key to use it because it will not preexist in
the system. The following will apply by default if the key does not exist. If 
an application calls the SRSetRestorePoint function to create a restore point,
Windows skips creating this new restore point if any restore points have been
created in the last 24 hours. System Restore sets the IISequenceNumber member
of the STATEMGRSTATUS structure to the sequence number for the restore point
created previously in the day and sets the value of the nStatus member to
ERROR_SUCCESS. The SRSetRestorePoint function returns TRUE.

### HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore\cfg

#### DiskPercent (REG_DWORD)

The maximum amount of disk space on each drive that can be used by System
Restore. This value is specified as a percentage of the total drive space.
The default value is 12 percent.

Windows Vista: Receives a value from the Volume Shadow Copy Service (VSS).
This is the maximum amount of disk space on each drive that can be used by
System Restore. The default value is 15 percent of the total drive space or
30 percent of the available free space, whichever is smaller.

### HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore\Setup

### HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore\Setup\Generalize

#### DisableSR (REG_DWORD)

See [DisableSR (REG_DWORD)] for more information.

### HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore\Setup\PreviousOSUpgrade

### HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore\Setup\Unattend

#### DisableSR (REG_DWORD)

See [DisableSR (REG_DWORD)] for more information.

### HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore\Setup_Last

#### AoACAPIError (REG_DWORD)

#### AoACAPIResult (REG_DWORD)

#### Generalize_DisableSR (REG_DWORD)

See [DisableSR (REG_DWORD)] for more information.

#### Unattend_DisableSR (REG_DWORD)

See [DisableSR (REG_DWORD)] for more information.

#### Upgrade_DisableSR (REG_DWORD)

See [DisableSR (REG_DWORD)] for more information.

#### Upgrade_\{GUID\} (REG_MULTI_SZ)

Here is the example of the name:

> Upgrade_{09F7EDC5-294E-4180-AF6A-FB0E6A0E9513}

Here is the example of the value:

```
\\?\Volume{e4ceb3cd-d963-421f-b738-34e52a27670e}\:Windows (C%3A)
```

Here is the format may for the each line I guess.

> \{VolumeName\}:\{DriveLabel\} (\{DriveLetter\}%3A)

### HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore\Volatile

#### NestingLevel (REG_DWORD)

#### StartNesting (REG_QWORD)

### HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VSS\Diag\SystemRestore

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
  - See [RestoreStatusResult (REG_DWORD)] for more information.

### SystemRestoreConfig

> PowerShell -NoLogo -NoProfile -NonInteractive -InputFormat None -ExecutionPolicy Bypass Get-WmiObject -Class SystemRestoreConfig -Namespace "Root\Default"

- UInt32 DiskPercent
  - See [DiskPercent (REG_DWORD)] for more information.
- String MyKey
  - Value: "SR" (Constant)
- UInt32 RPGlobalInterval
  - See [RPGlobalInterval (REG_DWORD)] for more information.
- UInt32 RPLifeInterval
  - See [RPLifeInterval (REG_DWORD)] for more information.
- UInt32 RPSessionInterval
  - See [RPSessionInterval (REG_DWORD)] for more information.

[SRSetRestorePoint]: #SRSetRestorePointW
[RESTOREPOINTINFO]: #RESTOREPOINTINFOW
[STATEMGRSTATUS]: #STATEMGRSTATUS

[DisableSR (REG_DWORD)]: #DisableSR-REG_DWORD
[DiskPercent (REG_DWORD)]: #DiskPercent-REG_DWORD
[RestoreStatusResult (REG_DWORD)]: #RestoreStatusResult-REG_DWORD
[RPGlobalInterval (REG_DWORD)]: #RPGlobalInterval-REG_DWORD
[RPLifeInterval (REG_DWORD)]: #RPLifeInterval-REG_DWORD
[RPSessionInterval (REG_DWORD)]: #RPSessionInterval-REG_DWORD
