# MD25: Notes for user mode run levels mentioned in Windows 11

In recent days, I have saw something like win0, rl0, etc in recent day's Windows
11's WinSxS folder. I was curious but I had no ideas, until I downloaded and saw
an extra component called [Win0N-RL1-Package.cab](Win0N-RL1-Package.cab) in
Microsoft Validation OS 26100.6725.

In general, here is the conclusion:

- RunLevel 0: Apps only depend on ntdll.dll can run.
- RunLevel 1: Apps only depend on ntdll.dll, kernelbase.dll, ucrtbase.dll can
              run, and services are not available.
- RunLevel 2: All OneCore compliant apps can run, and services are started at
              this run level.
- RunLevel 3: All OneCore compliant apps with GUI only depend on gdi32.dll and
              user32.dll can run.

Read below for original notes in the component.

In "amd64_microsoft-windows-ccs_31bf3856ad364e35_10.0.26100.6725_none_49e17d8b07cdc1a1\ccs.exe",
you will see these in CcspRunEvalLoop function via IDA Pro.

```
  DisplayString(L"\n     HELLO! \n");
  DisplayString(L"The OS is booted to RunLevel 0");
  if ( !v0 )
    DisplayString(L" - ONLY");
  DisplayString(L"\n\n");
  DisplayString(L"Only native apps can run at this level.\n");
  DisplayString(L"To run, your app must depend only on the kernel ABI (ntdll.lib)\n\n");
  DisplayString(L"The only usermode process\n");
  DisplayString(L"currently running: CCS.EXE.\n");
  DisplayString(L"which is a native app,\n");
  DisplayString(L"handling raw input to display this message.\n\n");
  DisplayString(L"TLIST for running processes,\n");
  DisplayString(L"MEMSTAT for memory usage,\n");
  if ( v0 )
  {
    DisplayString(L"To continue booting to the next\n");
    DisplayString(L"run level,\n");
    DisplayString(L"type: win1\n\n");
  }
  DisplayString(L"'njoy.\n\n");
```

In "amd64_microsoft-win01-config_31bf3856ad364e35_10.0.26100.6725_none_cac154e6312bd990\runlevel1.txt",
you will see these:

```

             HELLO!

The OS is booted to RunLevel 1 - ONLY.

Services are not available at this run level.

Native and CUI apps can run.
To run, your app must depend on 
ntdll, kernelbase and UCRT only.

Run 'memstat' to see memory usage.
Run 'tlist' to see running processes.

'njoy.

```

In "amd64_microsoft-windows-cloudcoreinit_31bf3856ad364e35_10.0.26100.6725_none_9ef4947e061e0244\runlevel2_only.txt",
you will see these:

```
             HELLO!

The OS is booted to RunLevel 2 (ONECORE) - ONLY.

Services are STARTED at this run level.

All OneCore compliant apps can run.

Run 'memstat' to see memory usage.
Run 'tlist -s' to see running processes and services.

'njoy.

```

In "amd64_microsoft-windows-cloudcoreinit_31bf3856ad364e35_10.0.26100.6725_none_9ef4947e061e0244\runlevel3_only.txt",
you will see these:

```

             HELLO!

The OS is booted to RunLevel 3 (CLIENTCORE) - ONLY.

Services are STARTED at this run level.

All OneCore compliant apps can run.
GUI apps (that depend on user32 and gdi only) can run.

Run 'memstat' to see memory usage.
Run 'tlist -s' to see running processes and services.

'njoy.

```
