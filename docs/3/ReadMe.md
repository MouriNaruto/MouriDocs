# MD3: Notes for using openSUSE Tumbleweed

## Install Noto series fonts

> sudo zypper in noto-fonts google-noto-coloremoji-fonts google-noto-sans-cjk-fonts google-noto-\*-fonts-full google-noto-sans-\*-mono-fonts

## Install TeX Live with all components

> sudo zypper in texlive-scheme-full

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
