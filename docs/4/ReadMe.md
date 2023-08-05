# MD4: Notes for using Host Compute System API

## References

- Host Compute System API
  - Overview, https://learn.microsoft.com/en-us/virtualization/api/hcs/overview
  - JSON Reference, https://learn.microsoft.com/en-us/virtualization/api/hcs/schemareference
- Host Compute Network API
  - Overview, https://learn.microsoft.com/en-us/windows-server/networking/technologies/hcn/hcn-top
  - JSON Reference, https://learn.microsoft.com/en-us/virtualization/api/hcn/hns_schema

## Relationship

- Host Compute Service API is the predecessor of Host Compute System API. You
  can think of Host Compute System API as Host Compute Service v2 API.
- Host Networking Service API is the predecessor of Host Compute Network API.
  You can think of Host Compute Network API as Host Networking Service v2 API.
- Host Compute Service API and Host Networking Service API are both undocumented
  and Kris Harper told me should not use them because they are deprecated.

## Related Projects

- Microsoft Projects
  - hcsshim, https://github.com/microsoft/hcsshim
  - dotnet-computevirtualization, https://github.com/microsoft/dotnet-computevirtualization
- Third-party Projects
  - NanaBox, https://github.com/M2Team/NanaBox

## Limitations

- The virtual machine created by Host Compute System API only supports UEFI
  Class 3 or UEFI without CSM or Hyper-V Gen 2 VM.
- The HcsCrashComputeSystem API is not existed in ComputeCore.dll from Windows
  10, version 1809, which Microsoft's document said supported. Actually, this 
  API is introduced since Windows 10, version 2004 and Windows Server 2022.
  It's confirmed as a document bug via Kris Harper and will fix it in the 
  future.
- The automatic switch between Enhanced Session Mode and Basic Session Mode is 
  not implemented because HcsEventSystemRdpEnhancedModeStateChanged event can 
  be fired on at least Windows 10, version 1809, but in Windows 11, version
  22H2 cannot. It's confirmed as a Host Compute System API bug via Kris Harper
  and will fix it in the future.
- TPM support is not available because current stage of Host Compute System API
  seems doesn't implement them. It's confirmed via Kris Harper.
- Host Compute Network API in Windows 11, version 22H2 will return 
  ERROR_ACCESS_DENIED even add the current user to the Hyper-V Administrators 
  user group. Windows 10 don't have that issue. It's confirmed as a Host 
  Compute Network API bug via Kris Harper and will fix it in the future.

## JSON Schema References

Note: Please use ILSpy to open these .NET Assemblies to get the definitions.

- [Windows 10 Version 20H1/20H2/21H1/21H2/22H2](References/Microsoft.HyperV.Schema_19041.dll)
- [Windows Server 2022](References/Microsoft.HyperV.Schema_20348.dll)
- [Windows 11 Version 22H2](References/Microsoft.HyperV.Schema_22621.dll)
- [Windows 11 Insider Preview Dev Channel](References/Microsoft.HyperV.Schema_23481.dll)
- [Windows 11 Insider Preview Canary Channel](References/Microsoft.HyperV.Schema_25905.dll)

## Thanks

- Kris Harper, https://github.com/kharpMSFT
