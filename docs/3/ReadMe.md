# MD3: Notes for using openSUSE Tumbleweed

## Change the package source

```
sudo zypper mr -da
sudo zypper ar -cfg 'https://mirrors.tuna.tsinghua.edu.cn/opensuse/tumbleweed/repo/oss/' tuna-oss
sudo zypper ar -cfg 'https://mirrors.tuna.tsinghua.edu.cn/opensuse/tumbleweed/repo/non-oss/' tuna-non-oss
sudo zypper ref
```

## Install Noto series fonts

> sudo zypper in noto-fonts google-noto-coloremoji-fonts google-noto-sans-cjk-fonts google-noto-\*-fonts-full google-noto-sans-\*-mono-fonts

## Install TeX Live with all components

> sudo zypper in texlive-scheme-full

## Install the Chinese and Japanese IME based on Fcitx 5

> sudo zypper in --no-recommends fcitx5 fcitx5-gtk\* fcitx5-qt\* fcitx5-configtool fcitx5-chinese-addons fcitx5-anthy

## Install the OpenConnect

> sudo zypper in NetworkManager-openconnect

## Remove default kernel

> sudo zypper rm kernel-default\* kernel-source\* kernel-syms\* kernel-devel\*

## Update initramfs

> sudo dracut --force

## Update GRUB 2 items

> sudo update-bootloader

## Change time

> sudo timedatectl set-time '2022-09-25 00:00:00'

## Access with hostname

You need to use YaST2 to change your firewall setting to allow "mdns".

## Create and enable the swapfile

```
sudo dd if=/dev/zero of=/swapfile bs=1M count=4096 status=progress
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```
