# MD4: Notes for using Host Compute System API

## References

- Host Compute System API
  - Overview, https://learn.microsoft.com/en-us/virtualization/api/hcs/overview
  - JSON Reference, https://learn.microsoft.com/en-us/virtualization/api/hcs/schemareference
- Host Compute Network API
  - Overview, https://learn.microsoft.com/en-us/windows-server/networking/technologies/hcn/hcn-top
  - JSON Reference, https://learn.microsoft.com/en-us/virtualization/api/hcn/hns_schema
- Projects uses Host Compute System API and Host Compute Network API
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

## Thanks

- Kris Harper, https://github.com/kharpMSFT
