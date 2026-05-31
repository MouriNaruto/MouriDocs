# Notes for using FreeBSD

## Create an Azure FreeBSD virtual machine with dual-stack network support

Read https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/create-vm-dual-stack-ipv6-portal
first to know how to create an Azure virtual machine with dual-stack network
support in Azure.

For the FreeBSD virtual machine, you need to do the following steps to enable
dual-stack network support after you connect to the virtual machine via SSH:

First, you need to install the `dual-dhclient-daemon` package:

> sudo pkg install dual-dhclient-daemon

Once the package is installed, add the following lines to `/etc/rc.conf`:

```
ipv6_activate_all_interfaces="YES"
ifconfig_hn0_ipv6="SYNCDHCP accept_rtadv"
dhclient_program="/usr/local/sbin/dual-dhclient"
```

Now reboot and when you log back in do an ifconfig hn0 and you'll see the
internal IPv6 we configured.

Note: I learned this from https://www.idatum.net/using-freebsd-zfs-and-ipv6-on-azure.html.

## Manual partition layout

| Device     | Mountpoint | FStype  | Options | Dump | Pass |
|------------|------------|---------|---------|------|------|
| /dev/da0p1 | /boot/efi  | msdosfs | rw      | 2    | 2    |
| /dev/da0p2 | /          | ufs     | rw      | 1    | 1    |

## Useful packages should install when using FreeBSD for the first time

> sudo pkg install fastfetch htop nano

Here is the reason I suggest to install these packages:

- Install "fastfetch" to show system information in a nice way.
- Install "htop" to monitor system resources.
- Install "nano" to edit files easily in the terminal.

## Use Let's Encrypt to generate SSL certificates

```
sudo pkg install py311-certbot
sudo certbot certonly
```

## Multicast DNS Support

> pkg install mDNSResponder
> sysrc mdnsresponderposix_enable="YES"
> echo "mdnsresponderposix_flags=\"-n \$hostname\"" >> /etc/rc.conf
> service mdnsresponderposix start

## doas Support

> pkg install doas
> echo "permit persist :wheel" > /usr/local/etc/doas.conf
> pw group mod wheel -m mouri

## SSH Key-Based Authentication

https://www.digitalocean.com/community/tutorials/how-to-configure-ssh-key-based-authentication-on-a-linux-server

## Use Alpine Linux in Linuxulator

First, we should customize the Alpine Linux root file system for Linuxulator. Read
[this part](AlpineRootFileSystem.md) for details.

If you don't want to modify that manually, you can use my homemade
[alpine-minirootfs-3.23.4-x86_64-customized.tar.gz](Binaries/alpine-minirootfs-3.23.4-x86_64-customized.tar.gz).

> mkdir -p /compat/alpine
> tar -xpf alpine-minirootfs-3.23.4-x86_64-customized.tar.gz -C /compat/alpine
> ln -sfn /compat/alpine/ /compat/linux
> sysrc linux_enable="YES"
> service linux start
> /compat/linux/bin/sh

For Visual Studio Code Remote SSH support:

> apk add nano bash gcompat libstdc++ curl git procps

Add these to `/etc/ssh/sshd_config`:

```
Match User mouri
	ForceCommand /compat/linux/bin/bash
```

Of course, we need a modified musl libc to fix some issues.

Also we need to create new `~/.shrc`:

> mv .shrc .shrc.old
> nano ~/.shrc

```
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

export PAGER=less
umask 022

# use nicer PS1 for bash and busybox ash
if [ -n "$BASH_VERSION" -o "$BB_ASH_VERSION" ]; then
	PS1='\h:\w\$ '
# use nicer PS1 for zsh
elif [ -n "$ZSH_VERSION" ]; then
	PS1='%m:%~%# '
# set up fallback default PS1
else
	: "${HOSTNAME:=$(hostname)}"
	PS1='${HOSTNAME%%.*}:$PWD'
	[ "$(id -u)" -eq 0 ] && PS1="${PS1}# " || PS1="${PS1}\$ "
fi

for script in /etc/profile.d/*.sh ; do
	if [ -r "$script" ] ; then
		. "$script"
	fi
done
unset script
```
