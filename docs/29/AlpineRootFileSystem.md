# Make customized Alpine Linux root file system for Linuxulator in FreeBSD

> [!NOTE]
> The following instructions uses FreeBSD with root user to operate.
> If you don't want to modify that manually, you can use my homemade
> [alpine-minirootfs-3.23.4-x86_64-customized.tar.gz](Binaries/alpine-minirootfs-3.23.4-x86_64-customized.tar.gz).

## Source

https://dl-cdn.alpinelinux.org/alpine/v3.23/releases/x86_64/alpine-minirootfs-3.23.4-x86_64.tar.gz

## Extract to workspace

> mkdir alpine-minirootfs
> tar -xpf alpine-minirootfs-3.23.4-x86_64.tar.gz -C alpine-minirootfs
> cd alpine-minirootfs
> rm -d home
> rm -r media
> rm -d mnt
> rm -d root
> rm -d tmp
> cd var
> rm -d tmp
> ln -sfn /tmp tmp
> cd ..
> mv bin/* usr/bin/
> rm -d bin
> ln -sfn usr/bin bin
> mv lib/* usr/lib/
> rm -r lib
> ln -sfn usr/lib lib
> mv sbin/* usr/sbin/
> rm -d sbin
> ln -sfn usr/sbin sbin
> cd usr
> mv sbin/* bin/
> rm -d sbin
> ln -sfn bin sbin
> cd bin
```
for x in *; do
    if [ -L "$x" ] && [ "$(readlink "$x")" = "/bin/busybox" ]; then
        rm -f "$x"
        ln -s busybox "$x"
    fi
done
```
> cd ../../..
> tar -czf alpine-minirootfs-3.23.4-x86_64-customized.tar.gz -C alpine-minirootfs .
> rm -r alpine-minirootfs
