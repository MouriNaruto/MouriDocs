# MD21: Talk about booting x86 (64-Bit) Windows XP / Vista / 7 on Hyper-V Generation 2 Virtual Machines

[简体中文](ReadMe.zh-CN.md)

**Work In Progress.**

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

But the reason is not enough to persuade me. I had done some experiments to
discover the real reason in 2024. Finally, I found that we can boot x86 (64-Bit)
Windows XP / Vista / 7 on Hyper-V Generation 2 Virtual Machines. It proves that
all x86 (64-Bit) Windows versions actually have the ability to support running
in Hyper-V Generation 2 Virtual Machines. For more details about the experiments
I had done before, please read [the early researches](EarlyResearches.md).
