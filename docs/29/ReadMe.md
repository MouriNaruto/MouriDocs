# MD29: Notes for using various Unix-like operating systems

Work In Progress.

- [openSUSE Tumbleweed](Tumbleweed.md)
- [Alpine Linux](Alpine.md)
- [FreeBSD](FreeBSD.md)
- [Debian](Debian.md)

## Archived

- [Start using Alpine Linux as my daily Linux distro](ChooseAlpine.md)

## Prepare for shrinking VHD/VHDX

### coreutils (Debian, openSUSE Tumbleweed)

```
dd if=/dev/zero of=zeroedspace bs=1M status=progress
sync
rm zeroedspace
```

### busybox (Alpine Linux)

```
dd if=/dev/zero of=zeroedspace bs=1M
sync
rm zeroedspace
```

### FreeBSD

```
dd if=/dev/zero of=zeroedspace bs=1M status=progress
sync
rm zeroedspace
```

## Create and enable the swapfile

### coreutils (Debian, openSUSE Tumbleweed)

```
sudo dd if=/dev/zero of=/swapfile bs=1M count=4096 status=progress
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```
Add the following line to the "/etc/fstab" file via nano:

```
/swapfile none swap defaults 0 0
```

### busybox (Alpine Linux)

```
doas dd if=/dev/zero of=/swapfile bs=1M count=4096 oflag=append conv=notrunc
doas chmod 600 /swapfile
doas mkswap /swapfile
doas rc-service swap start
doas rc-update add swap boot
```

Add the following line to the "/etc/fstab" file via nano:

```
/swapfile none swap defaults 0 0
```
