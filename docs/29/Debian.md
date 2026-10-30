# Notes for using Debian

## Notes for Lightweight Install

- Use Expert Installer.
- Choose `English`, `United Status`, `en_US.UTF-8`.
- `Allow login as root?`: Yes.
- `Create a normal user account now?`: No.
- Choose `Coordinate Universal Time (UTC)`.
- Manual Partition
  - Select `gpt`.
  - `100 MiB` as `EFI System Partition`.
  - `max` as `Ext4 journaling file system` with `/` mount point.
- Select `targeted: only include drivers needed for this system`.
- `Use non-free firmware?`: No.
- Choose `SSH server` only.
- Choose `Install the systemd-boot boot loader`.
- `Is the system clock set to UTC?`: Yes.

## Useful packages should install when using Debian for the first time

> [!NOTE]
> Use `root` user to run the following commands.

```
apt install --no-install-recommends avahi-daemon sudo fastfetch nano htop
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
sudo apt install --no-install-recommends linux-image-cloud-amd64
sudo reboot
uname -a
sudo apt autopurge linux-image-amd64 '~n^linux-image-[0-9] !~ncloud' '~n-microcode$'
```

## Install Minimal Desktop Environment

```
sudo apt install --no-install-recommends xorg xserver-xorg-video-fbdev xserver-xorg-input-libinput xserver-xorg-legacy
sudo apt install --no-install-recommends pipewire wireplumber pipewire-pulse
sudo apt install --no-install-recommends xrdp xorgxrdp pipewire-module-xrdp
sudo apt install --no-install-recommends icewm xterm firefox-esr libavcodec61
sudo apt install --no-install-recommends fonts-noto-core fonts-noto-mono fonts-noto-cjk
sudo apt install --no-install-recommends dex vlc mesa-utils 
```

```
echo '
if [ -n "${XRDP_SESSION:-}" ] && [ -n "${XRDP_SOCKET_PATH:-}" ] && [ "$(id -u)" -ne 0 ]; then
    if systemctl --user start pipewire.service pipewire-pulse.service wireplumber.service; then
        /usr/libexec/pipewire-module-xrdp/load_pw_modules.sh &
    fi
fi
' | sudo tee /etc/X11/Xsession.d/98xrdp-local-audio
sudo chmod 644 /etc/X11/Xsession.d/98xrdp-local-audio
```

## Install Development Tools

```
sudo apt install --no-install-recommends build-essential
sudo apt install --no-install-recommends linux-headers-cloud-amd64
sudo apt install --no-install-recommends git git-credential-oauth
sudo apt install --no-install-recommends libwlroots-0.18-dev
sudo apt install --no-install-recommends libwlroots-0.18-examples
sudo apt install --no-install-recommends weston
sudo apt install --no-install-recommends rsync
```

## Disable IPv6 for avahi

Set `use-ipv6=no` in `/etc/avahi/avahi-daemon.conf`.

## Install Node.js

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 24
```

## Install Pi Agent

> npm install -g --ignore-scripts @earendil-works/pi-coding-agent

## Run Pi Agent in Model-Only Mode

> pi --no-tools --no-extensions --no-skills --no-prompt-templates --no-context-files --model github-copilot/gpt-5.6-sol --thinking max --system-prompt " "

## MinLin Environment

```
apt update
apt upgrade
apt install --no-install-recommends avahi-daemon sudo fastfetch nano htop
# Set `PermitRootLogin yes` temporarily.
nano /etc/ssh/sshd_config
systemctl restart sshd

apt install --no-install-recommends linux-image-cloud-amd64
reboot

uname -a
apt autopurge linux-image-amd64 '~n^linux-image-[0-9] !~ncloud' '~n-microcode$'
apt install --no-install-recommends xorg xserver-xorg-video-fbdev xserver-xorg-input-libinput xserver-xorg-legacy
apt install --no-install-recommends pipewire wireplumber pipewire-pulse
apt install --no-install-recommends xrdp xorgxrdp pipewire-module-xrdp
apt install --no-install-recommends icewm xterm firefox-esr libavcodec61
apt install --no-install-recommends fonts-noto-core fonts-noto-mono fonts-noto-cjk
apt install --no-install-recommends git build-essential linux-headers-cloud-amd64
echo '
if [ -n "${XRDP_SESSION:-}" ] && [ -n "${XRDP_SOCKET_PATH:-}" ] && [ "$(id -u)" -ne 0 ]; then
    if systemctl --user start pipewire.service pipewire-pulse.service wireplumber.service; then
        /usr/libexec/pipewire-module-xrdp/load_pw_modules.sh &
    fi
fi
' | sudo tee /etc/X11/Xsession.d/98xrdp-local-audio
chmod 644 /etc/X11/Xsession.d/98xrdp-local-audio
cat /etc/X11/Xsession.d/98xrdp-local-audio
# Content from MinLin\oobe.sh
nano oobe.sh
# Content from MinLin\install-oobe.sh
nano install-oobe.sh
# Remove temporary `PermitRootLogin yes`.
nano /etc/ssh/sshd_config
apt install --no-install-recommends dialog ssl-cert
bash install-oobe.sh
poweroff

# Use DiskGenius to do these
Empty /root/
Empty /tmp/
Empty /var/tmp/
Empty /var/log/ except /var/log/README
Empty /var/lib/apt/lists/ files except /var/lib/apt/lists/lock
Empty /var/cache/apt/ but keep directory tree

# Use another Linux machine to do
sudo dd if=/dev/zero of=zeroedspace bs=1M status=progress
sudo sync
sudo rm zeroedspace
sudo poweroff
```
