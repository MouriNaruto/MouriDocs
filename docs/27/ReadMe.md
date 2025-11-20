# MD27: K7FS (NanaZip (K7) File System) Draft Specification

> [!NOTE]
> Work In Progress. It means the specification is not finalized yet and may
> change in future.

## Design Ideas

- Spiritually inspired by Windows Imaging Format (WIM) Format, and inherits most
  of its design ideas.
- Supports two modes:
  - Archive Mode
    - File Extension is *.k7.
    - Similar to WIM and 7z archives.
    - The default mode in NanaZip.
  - File System Image Mode
    - File Extension is *.k7fs or other disk image formats.
    - Similar to the read-write file system.
- Only supports these compression algorithms:
  - Store (no compression)
  - ZStandard (standard compression)
  - LZMA2 (maximum compression)
- Mandatory Low Density Parity Check (LDPC) error correction codes for all data
  and metadata to have better data integrity and make that available for using
  this format directly on NAND flash without controllers or similar scenarios.
- Mount friendly, like the WIM format and other file system images.
- File-level deduplication like WIM, maybe we can call it has Copy-on-
  (COW) support in the file system view.
- Multi index support like WIM, maybe we can call it has subvolume support in
  the file system view, also it will be easier to implement snapshots and
  append-only transaction updates. Append-only updates can also helpful to
  achieve both better data integrity and wear leveling on NAND flash or similar
  storage media.
- Support shrink/trim operation to reclaim unused space.
- All data fields (except signature/magic of K7FS) are ULEB128 encoded to save
  space, future extensibility, and without big-endian/little-endian issues.
- Support NT file metadata (like WIM), also support POSIX file metadata for
  cross-platform OS and software distribution scenarios, these metadata stored
  as extended attributes.
- Support extended attributes for better future extensibility.
- Use NT timestamps a.k.a. a 64-bit value that represents the number of
  100-nanosecond intervals that have elapsed since 12:00 A.M. January 1, 1601
  Coordinated Universal Time (UTC). For better density, we can store the second
  and nanosecond parts separately with ULEB128 encoding.
- Support reference volumes for better deduplication across multiple K7FS files.
  It also inspired by WIM format with the UUP mode.
