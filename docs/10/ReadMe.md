﻿# MD10: Archived list for things I currently working on

## May 2024

#### NanaZip 3.0

Status: Finished

https://github.com/M2Team/NanaZip/releases/tag/3.0.1000.0

## January 2024

#### Implement the new Windows backend for LVGL.

Status: Finished

Merged in the mainline via https://github.com/lvgl/lvgl/pull/5313.

## December 2023

#### NanaZip 3.0 Preview 1

Status: Working In Progress

NanaZip 3.0 and onwards will have two distribution flavors called NanaZip and
NanaZip Classic.

I feel tired due to health issues but I still keep up the development.

#### Porting Hyper-V Enhanced Session mode over VMBus to Hyper-V Linux guests.

Status: Working In Progress

I have written a validation demo for Windows 8 guests before I write the Linux
kernel module. Here is the demonstration video:
https://twitter.com/MouriNaruto/status/1700922160905359757

Note: Hyper-V Enhanced Session mode over VMBus transport originally needs
Windows 8.1 or later in the guest.

#### Implement the new Windows backend for LVGL. (Early December 2023)

Status: Working In Progress

OSAL is ready. I'm working on the new Windows backend.

The LVGL input device abstraction is ready.

#### Implement the optimized parser version of RaySoul.

Status: Paused

I had read the RISC-V ISA manual in 2023 Q4 but had found lot of design issues.

For example, the C extension will make us more difficult to write a decoder
which higher performance than others.

I also found I am not good at write a bytecode VM. I am good at build platform 
abstraction.

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
