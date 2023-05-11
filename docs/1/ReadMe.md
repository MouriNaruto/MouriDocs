# MD1: Notes for using GPU-PV on Hyper-V/NanaBox

Work In Progress.

## Modify your virtual machine configurations

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

- [Easy-GPU-PV: A Project dedicated to making GPU Partitioning on Windows easier!](https://github.com/jamesstringerparsec/Easy-GPU-PV)
- [Hyperv Linux Guest GPU PV](https://gist.github.com/OlfillasOdikno/f87a4444f00984625558dad053255ace)

## Configure the guest OS in your virtual machine

### Windows

If you are using Windows, it's relatively easier.

You only need to copy GPU driver files from host's 
`%SystemRoot%\System32\DriverStore\FileRepository` folder to guest's 
`%SystemRoot%\System32\HostDriverStore\FileRepository` folder.

### Linux

If you are using Linux, it's relatively harder.

You need to copy GPU driver files from host's 
`%SystemRoot%\System32\DriverStore\FileRepository` folder to guest's 
`usr/lib/wsl/drivers` folder.

You also need to extract Direct3D 12 binaries for Linux guests in 
`Microsoft.WSL_{the version you want}_{the CPU target you want}.msix\lib`
folder from [the latest version package of Windows Subsystem for Linux](https://github.com/microsoft/WSL/releases/latest)
to guest's `usr/lib/wsl/lib` folder via file archiver like [7-Zip](https://www.7-zip.org/)
or [NanaZip](https://github.com/M2Team/NanaZip).

For more information about Direct3D 12 for Linux, please read
[DirectX ❤ Linux - DirectX Developer Blog](https://devblogs.microsoft.com/directx/directx-heart-linux/).

You also need to compile `dxgkrnl` kernel module separately is you still want
to use your current kernel source code. It's relatively easy for making 
`dxgkrnl` kernel module out of the WSL2's Linux kernel source code tree.

I will provide the out of tree version of `dxgkrnl` in recent days.

You also need to compile mainline version of mesa. Here is my compile option:

```
meson setup --prefix="${PWD}/build/install" --strip -D gallium-drivers=swrast,d3d12 -D vulkan-drivers=swrast,microsoft-experimental -D gallium-opencl=icd -D microsoft-clc=enabled -D video-codecs=h264dec,h264enc,h265dec,h265enc,vc1dec -D osmesa=true build/
ninja -C build/
ninja -C build/ install
```

Here are examples which how to use the Vulkan support over mesa dozen backend:

```
VK_ICD_FILENAMES=/home/mouri/Workspace/mesa/build/install/share/vulkan/icd.d/dzn_icd.x86_64.json vkcube
VK_ICD_FILENAMES=/home/mouri/Workspace/mesa/build/install/share/vulkan/icd.d/dzn_icd.x86_64.json vulkaninfo
VK_ICD_FILENAMES=/home/mouri/Workspace/mesa/build/install/share/vulkan/icd.d/dzn_icd.x86_64.json ./vkpeak 0
```

## Limitations

GPU-PV is a feature which is nice for most people. But there are still some
painful limitations when using GPU-PV.

- The version of GPU drivers in the guest needs to be as same as the host's.
- Some softwares in Windows guests can't get the GPU information correctly 
  because of the design of GPU-PV: It will act as the Render Only Device in
  Windows guests and the kernel mode driver used in guests is called Microsoft
  Virtual Render Driver (vrd.sys).
