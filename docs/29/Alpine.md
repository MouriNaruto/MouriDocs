# Notes for using Alpine Linux

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
  - At least in Alpine Linux 3.23.3, it seems we can directly use setup-hostname
    to set the hostname you want without asking all lowercase letters.
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
  - > setup-apkrepos -o
  - > doas apk update
- Install packages before using Visual Studio Code Remote SSH to connect.
  - > doas apk add htop gcompat libstdc++ curl git avahi neofetch procps
  - > doas rc-update add avahi-daemon
  - > doas rc-service avahi-daemon start
  - In newer OpenRC, you should use the following command to update cache.
    > rc-update --update
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

- I choose to add user in post-installation steps because if we do the partition
  work manually. The user folder will not created properly. Here is the
  workaround if you met this case.
  - > mkdir /home/[the user name]
  - > chown [the user name]:[the user name] /home/[the user name]
- Use bash as the default shell for the normal user for workaround some issues
  when using Visual Studio Code Remote SSH. You can edit the "/etc/passwd" file
  manually if you want to use other shells, or find the issues after you consist
  to use the Alpine Linux default shell before.
- The gcompat libstdc++ curl git procps packages are necessary for Visual Studio
  Code Remote SSH support.
- I install avahi-daemon for the mDNS support. It's necessary for Visual Studio
  Code Remote SSH to connect with the hostname. Also I reboot the system for
  making avahi-daemon work properly.

## Basic X.Org Environment

> doas setup-xorg-base xf86-video-fbdev xterm mesa-utils
> doas addgroup mouri video
> doas addgroup mouri input

Log out and log in again to make the changes take effect.

## xrdp

> doas apk add xrdp xorgxrdp

Edit the "/etc/xrdp/xrdp.ini" file via nano, set the security_layer to rdp and
crypt_level to none, then save.

> doas rc-service xrdp start
> doas rc-service xrdp-sesman start
> doas rc-update add xrdp boot
> doas rc-update add xrdp-sesman boot

## Linux Kernel module development

> doas apk add alpine-sdk linux-virt-dev python3 clang18-extra-tools

Add Visual Studio Code extensions for Linux Kernel module development:

- Git History
- EditorConfig for VS Code
- clangd

- Reference: https://gist.github.com/itewqq/4b4ee89ba420d585efb472116879b1ee

## Docker

Work In Progress

## KVM

For minimal KVM/QEMU instance without X11 or Wayland:

> doas apk add qemu qemu-img qemu-system-x86_64 qemu-ui-sdl
> doas addgroup mouri qemu
> doas addgroup mouri kvm

For QEMU GTK backend:

> doas apk add qemu-ui-gtk

Workaround for "Native Windows wider or taller than 32767 pixels are not
supported" when using QEMU GTK backend:

> doas apk add ttf-freefont

## Wine

Work In Progress

## Hyper-V GPU-PV support

Work In Progress

## LaTeX

> doas apk add texlive texlive-xetex texmf-dist-plaingeneric texmf-dist-latexextra texmf-dist-fontsrecommended texmf-dist-langenglish texmf-dist-langcjk texmf-dist-langchinese texmf-dist-langjapanese texmf-dist-langkorean

## Noto Fonts

> doas apk add font-noto-all font-noto-cjk

## .NET SDK

Work In Progress

## Running on Azure virtual machines

First, go to https://www.alpinelinux.org/cloud/ for downloading the Alpine Linux
cloud image for Azure, I have chosen 3.21.2, x86__64, UEFI, cloud-init, Virtual.

Then, you need to follow the instructions from https://gitlab.alpinelinux.org/alpine/cloud/alpine-cloud-images/-/blob/main/IMPORTING.md#azure
to import the VHD you have downloaded before to your Azure account.

Because I want to create a virtual machine with dual-stack network support,
I follow the instructions from https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/create-vm-dual-stack-ipv6-portal
before creating the virtual machine.

Note: The virtual machine user name must be "alpine" because Alpine Linux
generalized image seems not support the custom user name. 

Note: It seems Alpine Linux support the IPv6 without extra configurations, which
reduces the steps I need to do after creating the virtual machine.

### Install essential packages

```
doas apk update
doas apk upgrade
doas apk add certbot fastfetch htop nano
```

### Configure Let's Encrypt

> doas certbot certonly

I choose the "standalone" mode, and follow the interactive steps.

### Scenario: Use OpenConnect Server

Reference: https://github.com/Pezhvak/docker-ocserv/blob/master/Dockerfile

```
doas apk update
doas apk add musl-dev iptables gnutls-dev gnutls-utils readline-dev libnl3-dev lz4-dev libseccomp-dev libev-dev
doas apk add xz openssl gcc autoconf make linux-headers
wget https://www.infradead.org/ocserv/download/ocserv-1.3.0.tar.xz
tar xJf ocserv-1.3.0.tar.xz
rm -fr ocserv-1.3.0.tar.xz
cd ocserv-1.3.0
sed -i '/#define DEFAULT_CONFIG_ENTRIES /{s/96/200/}' src/vpn.h
./configure
make -j"$(nproc)"
doas make install
doas mkdir -p /etc/ocserv/data
doas apk del --purge xz openssl gcc autoconf make linux-headers
doas cp doc/sample.config /etc/ocserv/ocserv.conf
```

## Visual Studio Remote Development (MSBuild C++ for Linux)

```
doas apk add gdb rsync zip
```

## Change time temporarily

```
doas rc-service chronyd stop
doas date -s "2025-07-14 00:00:00"
```

Resynchronize the time:

```
doas rc-service chronyd start
```

## Configuring Forgejo Server

```
apk add forgejo
mkdir /var/lib/forgejo
chown forgejo:www-data /var/lib/forgejo
chmod 750 /var/lib/forgejo
rc-update add forgejo
rc-update --update
rc-service forgejo start
```

Then goto http://{HostName}:3000 to install.
