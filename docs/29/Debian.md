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
poweroff

mkdir -p /opt/minlin
nano /opt/minlin/oobe.sh
nano /opt/minlin/enable-oobe.sh
apt install --no-install-recommends dialog ssl-cert
chown root:root /opt/minlin
chmod 0755 /opt/minlin
chown root:root /opt/minlin/oobe.sh /opt/minlin/enable-oobe.sh
chmod 0755 /opt/minlin/oobe.sh /opt/minlin/enable-oobe.sh
bash -n /opt/minlin/oobe.sh
bash -n /opt/minlin/enable-oobe.sh
/opt/minlin/enable-oobe.sh
poweroff

# Use DiskGenius to do these
Empty /root/
Empty /tmp/
Empty /var/tmp/
Empty /var/log/ except /var/log/README
Empty /var/lib/apt/lists/ files except /var/lib/apt/lists/lock
Empty /var/cache/apt/archives/ but keep directory tree
Remove /var/lib/systemd/random-seed
Remove /var/lib/dhcpcd/duid and /var/lib/dhcpcd/secret
Remove /etc/passwd-
Remove /etc/shadow-
Remove /etc/group-
Remove /etc/gshadow-
Remove /etc/ssl/certs/ssl-cert-snakeoil.pem
Remove /etc/ssl/private/ssl-cert-snakeoil.key
Remove /etc/ssh/ssh_host_*_key
Remove /etc/ssh/ssh_host_*_key.pub
Remove /etc/machine-id
Remove /var/lib/dbus/machine-id

# Use another Linux machine to do
# Remove temporary `PermitRootLogin yes`.
nano /etc/ssh/sshd_config
dd if=/dev/zero of=zeroedspace bs=1M status=progress
sync
rm zeroedspace
poweroff
```
