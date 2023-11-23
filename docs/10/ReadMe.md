# MD10: Archived list for things I currently working on

## November 2023

#### NanaBox 1.1 (Late November 2023)

Status: Finished

https://github.com/M2Team/NanaBox/releases/tag/1.1.600.0

## September 2023

#### Split the LZMA SDK as a separate module in NanaZip. 

Status: Canceled

It's not realistic due to strong coupling between LZMA SDK and other parts in
the 7-Zip mainline source code. But we can split the 7z.dll part as a separate
module because 7-Zip maintains good ABI compatibility for that.

So, I have a better plan for achieve the original goal: Create NanaZip.Core
project for making me track the modifications from upstreams better in the
future.

#### Create NanaZip.Core project for rewriting the core implementation.

Status: Finished

The development work on NanaZip.Core project has been completed successfully.
In the next version of NanaZip will use this implementation.

#### Synchronize the LZMA SDK and 7-Zip implementations to 23.01 in NanaZip.

Status: Finished

This task had been finished because the development work on NanaZip.Core project
has been completed successfully. Because NanaZip.Core project is based on 7-Zip
23.01 at the beginning.
