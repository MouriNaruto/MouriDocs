# MD2: Host Compute System API JSON configuration dump samples

## Dump method

https://gist.github.com/steffengy/62a0b5baa124830a4b0fe4334ccc2606

## Windows Sandbox (WSB)

```
{
  "Owner": "Madrid",
  "SchemaVersion": {
    "Major": 2,
    "Minor": 4
  },
  "VirtualMachine": {
    "StopOnReset": true,
    "Chipset": {
      "Uefi": {
        "BootThis": {
          "DeviceType": "VmbFs",
          "DevicePath": "\\EFI\\Microsoft\\Boot\\bootmgfw.efi"
        }
      }
    },
    "ComputeTopology": {
      "Memory": {
        "SizeInMB": 1024,
        "Backing": "Virtual",
        "BackingPageSize": "Small",
        "FaultClusterSizeShift": 4,
        "DirectMapFaultClusterSizeShift": 4,
        "EnablePrivateCompressionStore": true,
        "EnableHotHint": true,
        "EnableColdHint": true,
        "SharedMemoryMB": 2048,
        "SharedMemoryAccessSids": [ "S-1-5-21-646084236-3208304814-2060474565-1001" ],
        "EnableEpf": true,
        "EnableDeferredCommit": true
      },
      "Processor": {
        "Count": 2,
        "SynchronizeHostFeatures": true,
        "EnableSchedulerAssist": true,
        "DefaultVpCpuPriority": 10,
        "EnableProcessorIdling": true
      }
    },
    "Devices": {
      "Scsi": {
        "primary": {
          "Attachments": {
            "0": {
              "Type": "VirtualDisk",
              "Path": "C:\\ProgramData\\Microsoft\\Windows\\Containers\\Sandboxes\\b0fb4acc-07e5-46f7-9f34-8368cc2fde83\\sandbox.vhdx",
              "CachingMode": "ReadOnlyCached",
              "NoWriteHardening": true,
              "DisableExpansionOptimization": true,
              "IgnoreRelativeLocator": true,
              "CaptureIoAttributionContext": true,
              "SupportCompressedVolumes": true
            }
          },
          "DisableInterruptBatching": true
        }
      },
      "HvSocket": {
        "HvSocketConfig": {
          "DefaultBindSecurityDescriptor": "D:P(A;;FA;;;SY)",
          "DefaultConnectSecurityDescriptor": "D:P(A;;FA;;;SY)",
          "ServiceTable": {
            "befcbc10-1381-45ab-946e-b1a12d6bce94": {
              "BindSecurityDescriptor": "D:P(D;;FA;;;WD)",
              "ConnectSecurityDescriptor": "D:P(D;;FA;;;WD)",
              "AllowWildcardBinds": true
            },
            "a715ac94-b745-4889-9a0f-772d85a3cfa4": {
              "BindSecurityDescriptor": "D:P(A;;FA;;;S-1-5-80-3635958274-2059881490-2225992882-984577281-633327304)",
              "ConnectSecurityDescriptor": "D:P(A;;FA;;;S-1-5-80-3635958274-2059881490-2225992882-984577281-633327304)",
              "AllowWildcardBinds": true
            },
            "7b3014c3-284a-40d4-a97f-9d23a75c6a80": {
              "BindSecurityDescriptor": "D:P(D;;FA;;;WD)",
              "ConnectSecurityDescriptor": "D:P(D;;FA;;;WD)",
              "AllowWildcardBinds": true
            },
            "e97910d9-55bb-455e-9170-114fdfce763d": {
              "BindSecurityDescriptor": "D:P(D;;FA;;;WD)",
              "ConnectSecurityDescriptor": "D:P(D;;FA;;;WD)",
              "AllowWildcardBinds": true
            },
            "e5afd2e3-9b98-4913-b37c-09de98772940": {
              "BindSecurityDescriptor": "D:P(D;;FA;;;WD)",
              "ConnectSecurityDescriptor": "D:P(D;;FA;;;WD)",
              "AllowWildcardBinds": true
            },
            "abd802e8-ffcc-40d2-a5f1-f04b1d12cbc8": {
              "BindSecurityDescriptor": "D:P(A;;FA;;;SY)(A;;FA;;;BA)(A;;FA;;;S-1-15-3-3)(A;;FA;;;S-1-5-21-646084236-3208304814-2060474565-1001)",
              "ConnectSecurityDescriptor": "D:P(D;;FA;;;WD)"
            },
            "f58797f6-c9f3-4d63-9bd4-e52ac020e586": {
              "BindSecurityDescriptor": "D:P(A;;FA;;;SY)",
              "ConnectSecurityDescriptor": "D:P(A;;FA;;;SY)",
              "AllowWildcardBinds": true
            }
          }
        }
      },
      "EnhancedModeVideo": {
        "ConnectionOptions": {
          "AccessSids": [ "S-1-5-21-646084236-3208304814-2060474565-1001" ],
          "NamedPipe": "\\\\.\\pipe\\b0fb4acc-07e5-46f7-9f34-8368cc2fde83"
        }
      },
      "GuestCrashReporting": {
        "WindowsCrashSettings": {
          "DumpFileName": "C:\\ProgramData\\Microsoft\\Windows\\Containers\\Dumps\\b0fb4acc-07e5-46f7-9f34-8368cc2fde83.dmp",
          "MaxDumpSize": 4362076160,
          "DumpType": "Summary"
        }
      },
      "VirtualSmb": {
        "Shares": [
          {
            "Name": "os",
            "Path": "C:\\ProgramData\\Microsoft\\Windows\\Containers\\BaseImages\\134ac1c6-9de2-465e-9f16-570f0066c8a5\\BaseLayer\\Files",
            "Options": {
              "ReadOnly": true,
              "TakeBackupPrivilege": true,
              "NoLocks": true,
              "ReparseBaseLayer": true,
              "PseudoOplocks": true,
              "PseudoDirnotify": true,
              "SupportCloudFiles": true
            }
          }
        ],
        "DirectFileMappingInMB": 4096
      },
      "Licensing": {
        "ContainerID": "00000000-0000-0000-0000-000000000000",
        "PackageFamilyNames": []
      },
      "Battery": {},
      "KernelIntegration": {}
    },
    "GuestState": { "GuestStateFilePath": "C:\\ProgramData\\Microsoft\\Windows\\Containers\\Sandboxes\\b0fb4acc-07e5-46f7-9f34-8368cc2fde83\\sandbox.vmgs" },
    "RestoreState": { "TemplateSystemId": "48e7facb-2a65-4a83-bfef-03e3c2faae16" },
    "RunInSilo": {
      "SiloBaseOsPath": "C:\\ProgramData\\Microsoft\\Windows\\Containers\\BaseImages\\134ac1c6-9de2-465e-9f16-570f0066c8a5\\BaseLayer\\Files",
      "NotifySiloJobCreated": true
    },
    "LaunchOptions": { "Type": "None" },
    "GuestConnection": {
      "UseConnectedSuspend": true,
      "UseHostTimeZone": true
    }
  },
  "ShouldTerminateOnLastHandleClosed": true
}
```

## Windows Subsystem for Linux 2 (WSL2)

```
{
  "Owner": "WSL",
  "SchemaVersion": {
    "Major": 2,
    "Minor": 2
  },
  "VirtualMachine": {
    "StopOnReset": true,
    "Chipset": {
      "UseUtc": true,
      "LinuxKernelDirect": {
        "KernelFilePath": "C:\\Windows\\system32\\lxss\\tools\\kernel",
        "InitRdPath": "C:\\Windows\\system32\\lxss\\tools\\initrd.img",
        "KernelCmdLine": "initrd=\\initrd.img panic=-1 pty.legacy_count=0 nr_cpus=2"
      }
    },
    "ComputeTopology": {
      "Memory": {
        "SizeInMB": 3274,
        "AllowOvercommit": true,
        "EnableColdDiscardHint": true,
        "EnableDeferredCommit": true
      },
      "Processor": { "Count": 2 }
    },
    "Devices": {
      "Scsi": { "0": { "Attachments": {} } },
      "HvSocket": {
        "HvSocketConfig": {
          "DefaultBindSecurityDescriptor": "D:P(A;;FA;;;SY)(A;;FA;;;S-1-5-21-2367062212-3780319749-4234130436-1001)",
          "DefaultConnectSecurityDescriptor": "D:P(A;;FA;;;SY)(A;;FA;;;S-1-5-21-2367062212-3780319749-4234130436-1001)"
        }
      },
      "Plan9": {},
      "Battery": {}
    }
  },
  "ShouldTerminateOnLastHandleClosed": true
}
```
