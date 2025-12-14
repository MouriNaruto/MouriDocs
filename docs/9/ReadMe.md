# MD9: Hyper-V Enhanced Session over VMBus for pre-Windows 8.1 and Linux guests

**Work In Progress.**

According to [Use local resources on Hyper-V virtual machine with VMConnect
(Last updated on 02/16/2023)], we will know that to be able to use the official
Hyper-V Enhanced Session support, needs the virtual machine must have Remote
Desktop Services enabled, and run Windows 8.1 / Server 2012 R2 or later as the
guest operating system.

Also, according to [Onboarding: Ubuntu wiki document in Microsoft archived
linux-vm-tools GitHub repository], we will know that Linux guests with xrdp
installed can also use the official Hyper-V Enhanced Session support, which
needs to set the virtual machine uses the Hyper-V Socket transport mode for
Hyper-V Enhanced Session via setting by Hyper-V PowerShell cmdlet.

I don't think the current official policy is user friendly for Hyper-V users,
especially for people who want to use Linux as the guest operating system on
Hyper-V. This is why I want to explore the possibility to implement Hyper-V
Enhanced Session over VMBus for pre-Windows 8.1 and Linux guests.

I'm lucky due to my hard research, finally I archived the goal successfully. So,
I write this document to share my research and implementation experience.

## Technical Details

Hyper-V Enhanced Session over VMBus can be understood as RDP (Remote Desktop
Protocol) without encryption transported over VMBus via the SynthRdp VMBus
channels, which makes VMMS (Virtual Machine Management Service) in Hyper-V Host
easily to wrap it with TLS encryption directly, that mechanism is called RDP
with CredSSP (Credential Security Support Provider), which provides secure
connections to other users want to connect to the virtual machine.

[TermServiceCapture.apmx64] is file contains captured RDP (Remote Desktop
Protocol) without encryption transported over VMBus packets via [API Monitor], I
think it will be helpful for people who want to understand Hyper-V Enhanced
Session over VMBus and RDP (Remote Desktop Protocol).

## Afterwords

Hope you can enjoy this article.

[Use local resources on Hyper-V virtual machine with VMConnect (Last updated on 02/16/2023)]: https://github.com/MicrosoftDocs/windowsserverdocs/blob/e28a2171cdb0461e6808c79f9e78cae1970b0051/WindowsServerDocs/virtualization/hyper-v/learn-more/Use-local-resources-on-Hyper-V-virtual-machine-with-VMConnect.md
[Onboarding: Ubuntu wiki document in Microsoft archived linux-vm-tools GitHub repository]: https://github.com/microsoft/linux-vm-tools/wiki/Onboarding:-Ubuntu
[API Monitor]: http://www.rohitab.com/apimonitor
[TermServiceCapture.apmx64]: TermServiceCapture.apmx64
