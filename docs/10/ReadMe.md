# MD10: Archived list for things I currently working on

## September 2023

#### Split the LZMA SDK as a separate module in NanaZip. 

Status: Canceled

It's not realistic due to strong coupling between LZMA SDK and other parts in
the 7-Zip mainline source code. But we can split the 7z.dll part as a separate
module because 7-Zip maintains good ABI compatibility for that.

So, I have a better plan for achieve the original goal: Create NanaZip.Core
project for making me track the modifications from upstreams better in the
future.
