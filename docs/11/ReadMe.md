# MD11: Building UEFI Applications for Hyper-V Generation 2 Virtual Machines

## Notes

- Hyper-V EOM should be handled in your interrupt handler if you want to get the
  future synthetic timer expired message.
- Synthetic interrupt source 0 cannot be used for synthetic timer.

## Limitations

- Mouse support is unavailable unless you write a VMBus-based driver because
  there is no pointer device support in the UEFI.
- The UEFI GOP FrameBufferSize will return 8 MiB (since Windows 8) or 4 MiB
  (before Windows 8) even the virtual machine screen resolution is 1024 x 768
  with 32bpp (it should only be 3 MiB a.k.a 4 * 1024 * 768). If you fill zeros
  according with the UEFI GOP FrameBufferSize reported from the firmware, you
  will meet the dead loop, lol. So, you should do some calculation instead. Read
  https://github.com/microsoft/mu_msvm/blob/38a68e63e7dabda40878e0dbc33b392b8b69736d/MsvmPkg/VideoDxe/VramSize.h
  for more information.
- The RTC clock is available but the RTC timer not. You need the local APIC
  timer and use the RTC clock to do the timer calibration (very brute-force way)
  if you don't want to use Hyper-V specific infrastructures.
- According to https://github.com/microsoft/openvmm/blob/26e455497ee3a273140f05a729ff1ed902f5099e/openvmm/hvlite_defs/src/config.rs#L57,
  we will know why Hyper-V x64 guests reserve 128 MiB below 4 GiB address a.k.a
  from 0xF8000000 to 0xFFFFFFFF, and Hyper-V arm64 guests will reserve 512 MiB
  below 4 GiB address a.k.a from 0xE0000000 to 0xFFFFFFFF. Also, these memory
  regions are not shown in the UEFI memory map.
- According to https://github.com/microsoft/mu_msvm/blob/38a68e63e7dabda40878e0dbc33b392b8b69736d/MsvmPkg/VmbusDxe/VmbusP.h#L89,
  we cannot use VMBus UEFI protocol to implement the unsupported VMBus devices.

## Timer Calibration

Here is a simple procedure of the brute-force way timer calibration.

- Spinning to the start of the next second via reading the CMOS second value register.
- Reset TSC value to 0.
- Set APIC initial counter to -1 a.k.a 0xFFFFFFFF.
- Spinning to the start of the next second via reading the CMOS second value register.
- Get TSC value.
- Get APIC counter.
- Do some calculation.

Here is the pseudo source code implementation.

```
{
    ...

    /* Get the start of the second */
    {
        int BeginTime = BCD_INT(HalpReadCmos(0));
        int CurrentTime = BeginTime;
        while (CurrentTime == BeginTime)
        {
            CurrentTime = BCD_INT(HalpReadCmos(0));
        }
    }

    /* Reset TSC value to 0 */
    __writemsr(MSR_RDTSC, 0);

    /* Set APIC init counter to -1 */
    ApicWrite(APIC_TICR, (ULONG)0xFFFFFFFF);

    /* Get the end of the second */
    {
        int BeginTime = BCD_INT(HalpReadCmos(0));
        int CurrentTime = BeginTime;
        while (CurrentTime == BeginTime)
        {
            CurrentTime = BCD_INT(HalpReadCmos(0));
        }
    }

    /* Get TSC value */
    ULONGLONG TscCounter = __rdtsc();

    /* Get APIC counter*/
    ULONG ApicTimerCounter = ApicRead(APIC_TCCR);

    ULONGLONG TscFrequency = TscCounter;
    ULONG ApicTimerFrequency = 0xFFFFFFFF - ApicTimerCounter;

    DPRINT1("Current TSC Frequency = %lld\n", TscFrequency);
    DPRINT1("ApicTimerFrequency = %lld\n", ApicTimerFrequency);

    ...
}
```

It will be mostly simplified if you don't mind to use Hyper-V specific guest
infrastructures.

```
{
    ...

        DPRINT1("HV_X64_MSR_TSC_FREQUENCY = %lld\n", __readmsr(0x40000022));
        DPRINT1("HV_X64_MSR_APIC_FREQUENCY = %lld\n", __readmsr(0x40000023));

    ...
}
```


## Thanks

- Justin Miller, https://github.com/DarkFire01
- Timo Kreuzer, https://github.com/tkreuzer
- Todd Sharpe, https://github.com/toddsharpe
