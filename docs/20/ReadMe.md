# MD20: Start using Alpine Linux as my daily Linux distro

Some of my friends know I have used openSUSE Tumbleweed as my daily Linux distro
before because Himi Misaki, one of my POSIX veteran friends who use Linux From
Scratch, Slackware and Solaris daily, recommended it to me with the reason of
the most stable rolling Linux distro, with the words "If you cannot accept
openSUSE Tumbleweed, you won't accept any RPM-based distros."

I have used openSUSE Tumbleweed at least for a year. I often update at least
2000+ even 7000+ packages at once for many time without any issues. Himi Misaki
is right, openSUSE Tumbleweed is the most stable rolling Linux distro I have
ever used. It make me happier to develop my customized Linux Kernel and minimal
bootable .NET CoreCLR Linux environment.

But I also feel something uncomfortable with openSUSE Tumbleweed. Here are some
of them:

- It's heavy for my scenarios.
  - I use Linux distros in Hyper-V Generation 2 Virtual Machines and use Visual
    Studio Code Remote SSH to interact in most of time because I tried to make
    customized Linux Kernel optimized for Hyper-V Generation 2 Virtual Machines.
    I know I need a stable but modernized Linux userspace infrastructures. But I
    also hope I have a lightweight Linux userspace infrastructure for taking
    more storages for compiling Linux Kernel and some related userspace kits.
  - I also use Linux distros on a vintage laptop owned by me which only have a
    Yonah-based Celeron M series single core processor. openSUSE Tumbleweed will
    install lots of unnecessary packages for me by default. Also, it's uses the
    systemd as the init system which is too heavy for this laptop.
  - My minimal bootable .NET CoreCLR Linux environment apparently we should not
    choose openSUSE Tumbleweed as base for any minimal Linux environments.
- I have some cross platform projects which need to support Linux distros.
  - Everyone knows we need to make a minimal rootfs or make all dependencies
    static linked to one binary if we want to have the universal binary for
    Linux because Linux has lots of combination types even the libc because
    glibc is not suitable for static linking for license and design issues. I
    love and make open source projects but I don't want to force my users to
    open source their projects. Use openSUSE Tumbleweed as the development
    environment will have risk for achieve this goal.
  - I also need to discover the Hyper-V GPU-PV support for non-glibc based Linux
    distros. openSUSE Tumbleweed is not suitable for this goal.

I have considered a lot. Finally, I choose Alpine Linux. Here are some reasons:

- It's lightweight by default. It's only 500MiB for the base system with Visual
  Studio Code Remote SSH support.
- It's uses the musl libc as the C standard library. It's suitable for static
  linking. It's good for my cross platform projects. I also can discover the
  Hyper-V GPU-PV support for non-glibc based Linux distros.
- The POSIX userspace dependencies for my minimal bootable .NET CoreCLR Linux
  environment is actually based on Alpine Linux.

Although Alpine Linux is satisfied for my scenarios. It's still have lots of
things need to be cautious. I will write some notes for using Alpine Linux next
in this article.

## Installation

- Downloads: https://alpinelinux.org/downloads/
- Reference: https://wiki.alpinelinux.org/wiki/Installation
- Reference: https://wiki.alpinelinux.org/wiki/Alpine_setup_scripts
- Reference: https://docs.alpinelinux.org/user-handbook/0.1a/Installing/manual.html

For the Hyper-V Generation 2 Virtual Machines and my minimal bootable .NET
CoreCLR Linux environments, I will use the "alpine-virt" image for the base
system. For my vintage laptop, I will use the "alpine-extended" image for the
base system.

I suggest to use Semi-Automatic Installation because we can decide more details
accurately. So, here is the list of Semi-Automatic Installation steps I used:

- Keyboard Layout
  - > setup-keymap us us
- Hostname
  - > setup-hostname [the hostname you want with all lowercase letters]
  - Because I want to use the hostname with some uppercase letters, I also need
    to edit the "/etc/hostname" file manually after using the "setup-hostname".
- Networking
  - > setup-interfaces
  - > rc-update add networking boot
  - > rc-service networking start
- Timezone
  - > setup-timezone
- Repositories
  - > setup-apkrepos
- Root Password
  - > passwd
- SSH
  - > setup-sshd
- NTP
  - > setup-ntp
- Partitioning
  - For my Hyper-V Generation 2 Virtual Machine, I have two virtual disks. I
    will use the first virtual disk for the base system and the second virtual
    disk for the home folder. Here is the mount list I used:
    - /mnt as ext4
    - /mnt/boot/efi as vfat
    - /mnt/home as ext4
  - > setup-disk /mnt

After these steps, I had reboot to the newly installed system. I also need to do
some post-installation steps:

- Login as root.
- Install packages before creating a normal user.
  - > apk add doas nano bash
- Creating a normal user.
  - > adduser -h /home/[the user name] -s /bin/bash [the user name]
  - > passwd [the user name]
- Enable the normal user to use doas.
  - > addgroup [the user name] wheel
  - Edit the "/etc/doas.conf" file via nano, uncomment "permit persist :wheel",
    and save.
- Logout the root and login as [the user name].
- Configure the apk to enable the community repository.
  - Edit the "/etc/apk/repositories" file via nano, uncomment the community
    repository, and save.
  - > doas apk update
- Install packages before using Visual Studio Code Remote SSH to connect.
  - > doas apk add htop gcompat libstdc++ curl git avahi neofetch procps
  - > doas rc-update add avahi-daemon
  - > doas rc-service avahi-daemon start
- Edit the "/etc/ssh/sshd_config" file via nano, set both AllowTcpForwarding
  and PermitTunnel to yes, then save.
- Reboot your system.
- Use Visual Studio Code Remote SSH to connect to your Alpine Linux system.
- Configure SSH Key-Based Authentication for improving the user experience when
  using Visual Studio Code Remote SSH.
  - https://www.digitalocean.com/community/tutorials/how-to-configure-ssh-key-based-authentication-on-a-linux-server

With these steps done, we have the Alpine Linux base system with Visual Studio
Code Remote SSH support in Hyper-V Generation 2 Virtual Machines.

Here are some notes to example the reason of some operations.

- I choose to add use in post-installation steps because if we do the partition
  work manually. The user folder will not created properly. Here is the
  workaround if you met this case.
  - > mkdir /home/[the user name]
  - > chown [the user name]:[the user name] /home/[the user name]
- Use bash as the default shell for the normal user for workaround some issues
  when using Visual Studio Code Remote SSH. You can edit the "/etc/passwd" file
  manually if you want to use other shells or find the issues for the Alpine
  Linux default shell.
- The gcompat libstdc++ curl git procps packages are necessary for Visual Studio
  Code Remote SSH support.
- I install avahi-daemon for the mDNS support. It's necessary for Visual Studio
  Code Remote SSH to connect with the hostname. Also I reboot the system for
  making avahi-daemon work properly.
