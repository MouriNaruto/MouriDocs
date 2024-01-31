# MD11: Building UEFI Applications for Hyper-V Generation 2 Virtual Machines

Work In Progress.

## Limitations

- Mouse support is unavailable unless you write a VMBus-based driver because
  there is no pointer device support in the UEFI.
- The UEFI GOP FrameBufferSize will return 8 MiB even the virtual machine screen
  resolution is 1024 x 768 with 32bpp (it should only be 3 MiB a.k.a 4 * 1024 *
  768). If you fill zeros for 8 MiB, you will meet the dead loop, lol. So, you
  should do some calculation instead.
- The RTC clock is available but the RTC timer not. You need the local APIC
  timer and use the RTC clock to do the timer calibration (very brute-force way)
  if you don't want to use Hyper-V specific infrastructures.
