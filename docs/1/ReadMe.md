# MD1: Notes for using GPU-PV in Linux guests on Hyper-V/NanaBox

Work In Progress.

## Configure your virtual machine

### NanaBox

If you are using [NanaBox](https://github.com/M2Team/NanaBox), you can easily 
set `Gpu` object's `AssignmentMode` value to `Default`, `List` or `Mirror` in 
your configuration file.

Here is an example of NanaBox Configuration File with GPU-PV enabled:

```
{
  "NanaBox": {
    "ComPorts": {
      "UefiConsole": "Disabled"
    },
    "Gpu": {
      "AssignmentMode": "Mirror"
    },
    "GuestType": "Windows",
    "MemorySize": 4096,
    "Name": "TestVM",
    "NetworkAdapters": [
      {
        "Connected": true,
        "Enabled": true
      }
    ],
    "ProcessorCount": 2,
    "ScsiDevices": [
      {
        "Enabled": true,
        "Path": "Windows 11.vhdx",
        "Type": "VirtualDisk"
      },
      {
        "Enabled": true,
        "Type": "VirtualImage"
      }
    ],
    "SecureBoot": true,
    "Type": "VirtualMachine",
    "Version": 1
  }
}
```

For more information, please read [NanaBox Configuration File Reference](https://github.com/M2Team/NanaBox/blob/main/Documents/ConfigurationReference.md).

### Hyper-V

If you are using Hyper-V, I can't give you firsthand information because I think
it's really complex for me to enable GPU-PV on virtual machine hosted on Hyper-V
built-in client directly. This is one of reasons I created NanaBox.

If you want to do that. I think these information will be helpful for you.

- Easy-GPU-PV: A Project dedicated to making GPU Partitioning on Windows easier!
  (https://github.com/jamesstringerparsec/Easy-GPU-PV)
- Hyperv Linux Guest GPU PV
  (https://gist.github.com/OlfillasOdikno/f87a4444f00984625558dad053255ace)

## Reference

- DirectX ❤ Linux - DirectX Developer Blog
  (https://devblogs.microsoft.com/directx/directx-heart-linux/)
