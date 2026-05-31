# Notes for using Debian

## Manual partition layout

| <file system> | <mount point> | <type> | <options>         | <dump> | <pass> |
|---------------|---------------|--------|-------------------|--------|--------|
| /dev/sda1     | /boot/efi     | vfat   | umask=0077        | 0      | 1      |
| /dev/sda2     | /             | ext4   | errors=remount-ro | 0      | 1      |

## Useful packages should install when using Debian for the first time

> [!NOTE]
> Use `root` user to run the following commands.

```
apt install --no-install-recommends nano htop avahi-daemon sudo
usermod -aG sudo mouri
```

## SSH Key Authentication

```
mkdir -p ~/.ssh
nano ~/.ssh/authorized_keys
```

Then paste your public SSH key into the file and save it. Now you can log in to
your Debian server using SSH without a password.

## Switch to the cloud kernel

```
sudo apt purge linux-image-amd64
sudo apt install --no-install-recommends linux-image-cloud-amd64
reboot
uname -a
sudo apt purge linux-image-6.12.86+deb13-amd64
```

## Install Minimal Desktop Environment

```
sudo apt install --no-install-recommends xorg xserver-xorg-video-fbdev
sudo apt install --no-install-recommends pipewire wireplumber pipewire-pulse
sudo apt install --no-install-recommends icewm dex vlc mesa-utils 
sudo apt install --no-install-recommends xrdp xorgxrdp pipewire-module-xrdp
sudo apt install --no-install-recommends firefox-esr
sudo apt install --no-install-recommends fonts-noto-core fonts-noto-mono fonts-noto-cjk
sudo apt install --no-install-recommends fastfetch
```

```
mkdir -p ~/.icewm
nano ~/.icewm/startup
```

```
#!/bin/sh

export XDG_CURRENT_DESKTOP=ICEWM
export DESKTOP_SESSION=icewm

dex --autostart --environment ICEWM &
```

> chmod +x ~/.icewm/startup

## Install Development Tools

```
sudo apt install --no-install-recommends build-essential
sudo apt install --no-install-recommends git git-credential-oauth
sudo apt install --no-install-recommends libwlroots-0.18-dev
sudo apt install --no-install-recommends libwlroots-0.18-examples
```
