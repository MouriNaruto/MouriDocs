# MD22: Notes for using FreeBSD

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
