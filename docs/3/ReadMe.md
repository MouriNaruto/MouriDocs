﻿# MD3: Notes for using openSUSE Tumbleweed

## Change the package source

```
sudo zypper mr -da
sudo zypper ar -cfg 'https://mirrors.tuna.tsinghua.edu.cn/opensuse/tumbleweed/repo/oss/' tuna-oss
sudo zypper ar -cfg 'https://mirrors.tuna.tsinghua.edu.cn/opensuse/tumbleweed/repo/non-oss/' tuna-non-oss
sudo zypper ref
```

## Install essential utils

```
sudo zypper in git neofetch htop git-filter-repo
```

## Install essential development tools

```
sudo zypper in --no-recommends patterns-devel-C-C++-devel_C_C++ clang lld
sudo zypper in --no-recommends libelf-devel bc libopenssl-devel kernel-install-tools dwarves
sudo zypper in --no-recommends meson python311-Mako llvm-devel libclc clang-devel spirv-tools-devel libLLVMSPIRVLib-devel libvdpau-devel DirectX-Headers libdrm-devel wayland-devel libX11-devel libXext-devel libXfixes-devel libxshmfence-devel libXxf86vm-devel libXrandr-devel
```

## Install KVM

```
sudo zypper in --no-recommends patterns-server-kvm_server patterns-server-kvm_tools libvirt-daemon virt-manager
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
```

## Install Noto series fonts

```
sudo zypper in noto-fonts google-noto-coloremoji-fonts google-noto-sans-cjk-fonts google-noto-*-fonts-full google-noto-sans-*-mono-fonts
```

## Install TeX Live with essential components

```
sudo zypper in --no-recommends texlive-collection-basic texlive-collection-langcjk texlive-collection-langenglish texlive-collection-langchinese texlive-collection-langjapanese texlive-gnu-freefont texlive-xelatex-dev texlive-latexmk texlive-nth
```

## Install the Chinese and Japanese IME based on Fcitx 5

```
sudo zypper in --no-recommends fcitx5 fcitx5-gtk* fcitx5-qt* fcitx5-configtool fcitx5-chinese-addons fcitx5-anthy
```

## Install the OpenConnect

```
sudo zypper in NetworkManager-openconnect
```

## Remove default kernel

```
sudo zypper rm kernel-default* kernel-source* kernel-syms* kernel-devel*
```

## Update initramfs

```
sudo dracut --force
```

## Update GRUB 2 items

```
sudo update-bootloader
```

## Change time

```
sudo timedatectl set-ntp off
sudo timedatectl set-time '2023-12-25 00:00:00'

sudo timedatectl set-ntp yes
sudo systemctl restart systemd-timesyncd.service
```

## Access with hostname

You need to use YaST2 to change your firewall setting to allow "mdns".

## Create and enable the swapfile

```
sudo dd if=/dev/zero of=/swapfile bs=1M count=4096 status=progress
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```
