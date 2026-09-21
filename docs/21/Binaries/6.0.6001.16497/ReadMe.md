# `winload.efi` (6.0.6001.16497)

This is the last version of `winload.efi` capable of booting x64 editions of
Windows XP and Windows Server 2003 and serves as the basis for enabling UEFI
boot on these systems.

Note: Debug symbols are unavailable for this build.

## Original

- Executable: [winload.efi](winload.efi)

## Patched

- Executable: [winload.efi](Patched/winload.efi)
- IDA Pro project: [winload.efi.i64](Patched/winload.efi.i64)

### Modifications

- Disabled component signature verification using IDA Pro. See the IDA Pro
  project for patch details.
- Removed the embedded signature with `signtool remove /s winload.efi` to reduce
  the binary size.
- Replaced `osload800x600.bmp` and `osload1024x768.bmp` with solid-black images
  to further reduce the binary size.
