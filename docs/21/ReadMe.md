# MD21: Talk about booting Windows 7 Service Pack 1 on Hyper-V Generation 2 Virtual Machines

[简体中文](ReadMe.zh-CN.md)

***Work In Progress***

As the guy who want to write bare-matal applications with as high level
programming languages like C/C++ as possible, I love the design of Hyper-V
Generation 2 Virtual Machines because it's one of validated popular
para-virtualization platforms via history, especially it should be the only
one with aggressive para-virtualization design in current stage:

- No CSM support. Only provides 64-Bit UEFI Class 3 firmware.
- No emulated devices. Only devices based on VMBus are available.
- No legacy x86 devices like the floppy controller, the DMA controller, the
  PCI Bus, the legacy Programmable Interrupt Controller (PIC), the legacy
  Programmable Interval Timer (PIT), and the Super I/O device. Needs guest
  operating systems to adapt explicitly.

It's good for me. I only need to write UEFI applications which only support
Hyper-V Generation 2 Virtual Machines, which is enough for my proof of concept
level ideas. It can help me avoid to adapt to the specific hardwares which need
to write a lot of assembly codes. Also, I love the lightweight design, lol.

Note: The Windows builtin Hyper-V client is really hard to use. It makes me
hesitate, until [Ben (Bingxing) Wang] told me that you can use Hyper-V Host
Compute System API which was newly at that time to implement the third-party
Hyper-V client, especially its stateless design may good for you, and you can
use ILSpy to learn how to use that. I had used several months to implement that
and make it open source at GitHub. If some people need to use the third-party
Hyper-V Host Compute System API created by me, please refer to the [NanaBox]. I
hope that project can help people who have the same feeling as me.

[Ben (Bingxing) Wang]: https://github.com/imbushuo
[NanaBox]: https://github.com/M2Team/NanaBox

As the design of Hyper-V Generation 2 Virtual Machines, 64-Bit Windows 8 and
Windows Server 2012 are the minimum Windows versions which support booting on
Hyper-V Generation 2 Virtual Machines. Also, Microsoft said that in the
[Generation 2 FAQ]:

> Q: Why are 64-bit versions of Windows Server 2008 R2 and Windows 7 not
  supported as generation 2 guest operating systems?

> A: Although Windows Server 2008 R2 and Windows 7 support UEFI, they depend on
  a programmable interrupt controller (PIC), which is not present in generation
  2 virtual machine hardware.

[Generation 2 FAQ]: https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn282285(v=ws.11)#why-are-64-bit-versions-of-windows-server-2008-r2-and-windows-7-not-supported-as-generation-2-guest-operating-systems

But the reason is not enough to persuade me. I had started to do some
experiments to discover the real reason about half a year ago. Finally, I
accidently made booting Windows 7 Service Pack 1 on Hyper-V Generation 2
Virtual Machines. In the following sections, I will talk about the details.

Warning: I have no experience about writing Windows kernel drivers because I
cannot afford the price of the Windows driver signing certificate. Maybe my way
mentioned in this article is too wild and hope you can forgive me.

## Preliminary Information

We need to learn something preliminary before we start the journey.

### Minimum Windows guest build supports Hyper-V Generation 2 Virtual Machines

First, we need to know the actual minimum Windows build which supports booting
on Hyper-V Generation 2 Virtual Machines. It can help us to know how Microsoft
guys adapt to that.

The task is really simple because we only need to test which is the earliest
Windows build can boot on Hyper-V Generation 2 Virtual Machines.

As we all know, 64-Bit Windows 8 and Windows Server 2012 are the minimum Windows
versions which support booting on Hyper-V Generation 2 Virtual Machines. So we
only need to test builds mentioned in [Windows 8 - BetaWiki] and
[Windows Server 2012 - BetaWiki].

[Windows 8 - BetaWiki]: https://betawiki.net/wiki/Windows_8
[Windows Server 2012 - BetaWiki]: https://betawiki.net/wiki/Windows_Server_2012

We can divide these Windows builds into the following categories:

| Levels  | Behavior                                   |
|---------|--------------------------------------------|
| Level 0 | Boot failed with kernel deadloop           |
| Level 1 | Boot failed with ACPI issues               |
| Level 2 | Boot successfully with bootmgr replacement |
| Level 3 | Boot successfully without modifications    |

![7990.0.fbl_core1_hyp_dev.110425-1705](Assets/7990.0.fbl_core1_hyp_dev.110425-1705.png)

In the current stage, the minimum level 3 builds I found are Build 7990
(fbl_core1_hyp_dev), Build 8027 (fbl_fun_perf) or Build 8028 (winmain). The
minimum level 2 build I found is Build 8002 (fbl_grfx_dev1).

### Hyper-V guest interfaces definitions

For adapting to Hyper-V Generation 2 Virtual Machines, we need to know the
Hyper-V guest interfaces definitions. I have classified them as the open source
project [Mile.HyperV] and it provides the reference document to show where I get
the definitions.

[Mile.HyperV]: https://github.com/ProjectMile/Mile.HyperV

### ReactOS source code

Because Windows is not open source, we need to learn something about the hal and
ntoskrnl from ReactOS source code. Although the ReactOS x64 hal implementations
are too raw even for learning.

But for appreciating that project which helps me to learn something reliminary.
I also try to make boot ReactOS on Hyper-V Generation 2 Virtual Machines. But
there is no VMBus devices support because the ReactOS implementations are too
raw and lacks lots of things, which I have to use the ReactOS Longhorn
experimental branches. And [The_DarkFire] and [Timo Kreuzer] help me a lot for
learning that.

[The_DarkFire]: https://github.com/DarkFire01
[Timo Kreuzer]: https://github.com/tkreuzer

For people who have the ability to read the ReactOS source code, see
https://github.com/MouriNaruto/reactos/tree/remilia-hyperv-main-longhorn for my
modified branch.
