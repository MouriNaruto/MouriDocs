# MD21: 浅谈在 Hyper-V 第二代虚拟机启动 x86 (64 位) Windows XP / Vista / 7 的事务

[English](ReadMe.md)

**正在施工中。**

作为一个热衷于尽可能使用像 C/C++ 这样的高级语言编写裸机应用的人，我非常喜欢
Hyper-V 第二代虚拟机的设计，因为这是经过了时间考验的流行的半虚拟化平台之一且看起
来这家伙拥有目前最激进的半虚拟化设计:

- 无 CSM 支持，仅提供 64 位 UEFI Class 3 固件
- 无仿真设备，仅提供基于 VMBus 的设备
- 无软驱控制器、DMA 控制器、PCI 总线、传统可编程中断控制器 (PIC)、传统可编程间隔
  定时器 (PIT) 和超级 I/O 设备这样的传统 x86 设备，需要客户机操作系统明确适配

这样的设计对于我来说是极好的，我只需要编写仅支持 Hyper-V 第二代虚拟机的 UEFI 应
用程序作为原型就足够我向他人展示我的一些想法了。这可以帮助我避免适配需要编写大量
汇编代码的特定硬件。同时，我喜欢这样的轻量级设计 (笑)

注：Windows 自带的 Hyper-V 客户端对我来说很不好用，这使得我在是否选择 Hyper-V 作
为我的裸机应用原型开发平台而陷入了犹豫。直到有一天 [Ben (Bingxing) Wang] 告诉我
你可以使用当时还算新鲜出炉的 Hyper-V Host Compute System API 去实现一个第三方的
Hyper-V 客户端，尤其是这家伙的无状态设计会很合你的胃口，并且你可以通过 ILSpy 去
学习如何使用这家伙。我用了数个月写了一个这样的家伙并且开源到了 GitHub。如果一些
朋友需要使用我编写的基于 Hyper-V Host Compute System API 的第三方客户端，可以参
考 [NanaBox]。我希望该项目能帮助到和我有类似感受的朋友们。

[Ben (Bingxing) Wang]: https://github.com/imbushuo
[NanaBox]: https://github.com/M2Team/NanaBox

以 Hyper-V 第二代虚拟机的设计，支持在 Hyper-V 第二代虚拟机启动的最低版本的 Windows
操作系统是 64 位的 Windows 8 和 Windows Server 2012。并且微软在 [Generation 2 FAQ]
指出:

> Q: Why are 64-bit versions of Windows Server 2008 R2 and Windows 7 not
  supported as generation 2 guest operating systems?

> A: Although Windows Server 2008 R2 and Windows 7 support UEFI, they depend on
  a programmable interrupt controller (PIC), which is not present in generation
  2 virtual machine hardware.

翻译一下中文就是：

> Q: 为什么 64 位的 Windows Server 2008 R2 和 Windows 7 无法在 Hyper-V 第二代虚拟
  机启动？

> A: 虽然 Windows Server 2008 R2 和 Windows 7 支持 UEFI，但它们需要依赖 Hyper-V
  第二代虚拟机上不存在的传统可编程中断控制器 (PIC)。

[Generation 2 FAQ]: https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn282285(v=ws.11)#why-are-64-bit-versions-of-windows-server-2008-r2-and-windows-7-not-supported-as-generation-2-guest-operating-systems

但是这样的理由并不足以说服我。我在 2024 年做了一些实验去了解其真正的缘由。最终，
我发现我们可以在 Hyper-V 第二代虚拟机上启动 x86 (64 位) Windows XP / Vista / 7。
这证明所有 x86 (64 位) Windows 版本实际上都有能力支持在 Hyper-V 第二代虚拟机中运
行。有关我之前所做实验的更多详情，请阅读[早期研究](EarlyResearches.zh-CN.md)。
