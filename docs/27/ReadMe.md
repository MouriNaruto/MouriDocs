# MD27: K7FS (NanaZip (K7) File System) Draft Specification

> [!NOTE]
> Work In Progress. It means the specification is not finalized yet and may
> change in future.
> Currently we only care about the design ideas and high-level concepts if you
> want to give feedback or suggestions.
> Every word in this document is carefully considered, so please read it word by
> word if you don't want to catch fire from the author.

## Functional Requirements and Design Ideas

- K7FS won't break backward compatibility for future versions.
  - Only add new features in a backward-compatible way, use feature levels
    concept to indicate.
  - Implementations for older feature levels should still work with K7FS images
    with newer feature levels, but may not support new features.
  - Feature flags mentioned in the signature/magic part should be used to indicate
    the current modes and status for the image.
- Spiritually inspired by Windows Imaging Format (WIM) Format, and inherits most
  of its design ideas.
- File Extension is *.k7 (if you also want to make all implementations which
  support K7FS images easier to recognize) or other disk image formats.
- All data fields (except signature/magic of K7FS) are ULEB128 encoded to save
  space, future extensibility, and without big-endian/little-endian issues.
- Block-based storage.
  - Metadata is also a special block type.
  - Supports metadata inline storage for better density and performance on small
    files.
  - Sparse file optimization with block-level granularity in metadata.
  - Only supports these block-level compression algorithms which can be decided
    by archiver tools and user preferences:
    - Store (no compression)
    - ZStandard (standard compression)
    - LZMA2 (higher compression)
    - Other modern compression algorithms can be added in future versions.
  - User selectable image-level fixed block size for decompressed and
    uncompressed data, with 4 KiB as the minimum, 32 MiB as the maximum, powered
    of 2, default is 64 KiB with aligned to actual storage medium allocation
    unit size.
  - Physical block size for compressed blocks is variable for better density.
- Mandatory block-level Low Density Parity Check (LDPC) error correction codes
  for all data and metadata to have better data integrity and make it possible
  to use this format directly on NAND flash without controllers or similar
  non-reliable storage scenarios.
- Mount friendly, like the WIM format and other file system images.
- Multi index/root support (like WIM, so it's a file tree or you can call that a
  volume), maybe we can call it has subvolume support in the file system view,
  also it will be easier to implement index-based snapshots, checkpoints and
  append-only transaction updates. Append-only updates can also helpful to
  achieve both better data integrity and wear leveling on NAND flash or similar
  non-reliable storage scenarios. K7FS only updates the index after all data and
  metadata are written and verified.
- Signature/magic part of K7FS:
  - First four bytes: 'K7FS' (0x4B, 0x37, 0x46, 0x53)
  - Should have feature level for future extensibility.
  - Should have maximum ULEB128 encoded length field for each data field for
    easier parsing, security, and future extensibility, currently maximum
    decoded value is 64-bit unsigned integer.
  - Should have flag for read-only mode or read-write mode.
  - Should have dirty update flag for better data integrity.
  - Unknown/reserved fields should be ignored for better future extensibility.
- Default mode requirements:
  - For archiver tools like NanaZip, the default mode is read-only mode when
    creating K7FS images.
  - For read-write file system implementations, the default mode is read-write
    mode when mounting K7FS images.
  - For read-only mode, the dirty update flag in the signature/magic part must be
    ignored, and only use the last valid indexes.
- The verification and index for all blocks and whole file data are using BLAKE3
  full width hash for better performance and reliability. Of course, it mentions
  the decompressed and uncompressed data. Current BLAKE3 width is 256 bits.
- Both file-level (like WIM) and block-level deduplication, which is selectable
  by actual file storage, for balancing performance and density, maybe we can
  call it has Copy-on-Write (COW) support in the file system view.
  - Only if we have multiple files with the same content (a.k.a. same hash
    index), it will use file-level deduplication to save space and better
    performance, or it will use block-level deduplication for better density.
  - Support shrink/trim operation for specified indexes to reclaim unused space.
  - If the file is updated, only the changed blocks with the new file metadata
    will be created, other unchanged blocks will be shared. Failed update blocks
    (not linked by any index) become reclaimable by shrink/trim operations.
  - All existed indexes are valid unless shrink/trim operations for specific
    indexes are performed.
  - The dirty update flag in the signature/magic part must be set before any
    update operation, and cleared after all update operations are finished and
    verified.
- Support NT file metadata (like WIM), also support POSIX file metadata for
  cross-platform OS and software distribution scenarios, these metadata stored
  as extended attributes.
- Support extended attributes for better future extensibility.
- Use NT timestamps a.k.a. a 64-bit value that represents the number of
  100-nanosecond intervals that have elapsed since 12:00 A.M. January 1, 1601
  Coordinated Universal Time (UTC). For better density, we can store the second
  and 100-nanosecond tick parts (maximum tick is 9,999,999, zero is the whole
  second) separately with ULEB128 encoding. Two parts are mandatory to store.
  Although the resolution is 100-nanosecond ticks, the 100-nanosecond tick parts
  can be set to zero if the implementation or platform doesn't want to use high
  resolution timestamps.
- Support referencing the specific file from the specific external K7 image for
  better deduplication and software distribution scenarios. It inspired by WIM
  UUP mode.
- Support file reference (a.k.a. hard link in file system view) and reparse
  point (a.k.a. symbolic link, or other extension points in file system view)
  for better file system behavior compatibility and software distribution
  scenarios.
