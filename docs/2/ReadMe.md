# MD2: Host Compute System API JSON configuration dump samples

Note: Dumped via WinDbg.

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
