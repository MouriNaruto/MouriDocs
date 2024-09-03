# MD20: Start using Alpine Linux as my daily Linux distro

Some of my friends know I have used openSUSE Tumbleweed as my daily Linux distro
before because Himi Misaki, one of my POSIX veteran friends who use Linux From
Scratch, Slackware and Solaris daily, recommended it to me with the reason of
the most stable rolling Linux distro, with the words "If you cannot accept
openSUSE Tumbleweed, you won't accept any RPM-based distros."

I have used openSUSE Tumbleweed at least for a year. I often update at least
2000+ even 7000+ packages at once for many time without any issues. Himi Misaki
is right, openSUSE Tumbleweed is the most stable rolling Linux distro I have
ever used. It make me happier to develop my customized Linux Kernel and minimal
bootable .NET CoreCLR Linux environment.

But I also feel something uncomfortable with openSUSE Tumbleweed. Here are some
of them:

- It's heavy for my scenarios.
  - I use Linux distros in Hyper-V Generation 2 Virtual Machines and use Visual
    Studio Code Remote SSH to interact in most of time because I tried to make
    customized Linux Kernel optimized for Hyper-V Generation 2 Virtual Machines.
    I know I need a stable but modernized Linux userspace infrastructures. But I
    also hope I have a lightweight Linux userspace infrastructure for taking
    more storages for compiling Linux Kernel and some related userspace kits.
  - I also use Linux distros on a vintage laptop owned by me which only have a
    Yonah-based Celeron M series single core processor. openSUSE Tumbleweed will
    install lots of unnecessary packages for me by default. Also, it's uses the
    systemd as the init system which is too heavy for this laptop.
  - My minimal bootable .NET CoreCLR Linux environment apparently we should not
    choose openSUSE Tumbleweed as base for any minimal Linux environments.
- I have some cross platform projects which need to support Linux distros.
  - Everyone knows we need to make a minimal rootfs or make all dependencies
    static linked to one binary if we want to have the universal binary for
    Linux because Linux has lots of combination types even the libc because
    glibc is not suitable for static linking for license and design issues. I
    love and make open source projects but I don't want to force my users to
    open source their projects. Use openSUSE Tumbleweed as the development
    environment will have risk for achieve this goal.
  - I also need to discover the Hyper-V GPU-PV support for non-glibc based Linux
    distros. openSUSE Tumbleweed is not suitable for this goal.

I have considered a lot. Finally, I choose Alpine Linux. Here are some reasons:

- It's lightweight by default. It's only 500MiB for the base system with Visual
  Studio Code Remote SSH support.
- It's uses the musl libc as the C standard library. It's suitable for static
  linking. It's good for my cross platform projects. I also can discover the
  Hyper-V GPU-PV support for non-glibc based Linux distros.
- The POSIX userspace dependencies for my minimal bootable .NET CoreCLR Linux
  environment is actually based on Alpine Linux.

Although Alpine Linux is satisfied for my scenarios. It's still have lots of
things need to be cautious. I will write some notes for using Alpine Linux next
in this article.
