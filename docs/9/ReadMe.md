# MD9: Hyper-V Enhanced Session mode over VMBus for Linux

Work In Progress.

## Development Status

Updated: August 29th, 2023

I have initialized VMBus pipe of SynthRdp data channel successfully.

But I met issues when I redirect contents from that VMBus pipe to TCP sockets
listened from a RDP server implementation. I have tried FreeRDP Sample Server,
Terminal Service and xrdp and all failed.

I think may be I can get help from people through the Wireshark capture and log
from FreeRDP Sample Server.

Here is the Wireshark capture file: [rdp_packets_redirected_from_vmbus.pcapng].

[rdp_packets_redirected_from_vmbus.pcapng]:rdp_packets_redirected_from_vmbus.pcapng

Here is the log:

```
C:\Users\Mouri\Desktop\Tools>sfreerdp-server.exe
[07:29:06:49] [5444:00001aa4] [WARN][com.winpr.utils.ssl] - [winpr_openssl_initialize]: OpenSSL LEGACY provider failed to load, no md4 support available!
[07:29:06:51] [5444:00001aa4] [INFO][com.freerdp.core.listener] - [freerdp_listener_open]: Listening on [::]:3389
[07:29:06:51] [5444:00001aa4] [INFO][com.freerdp.core.listener] - [freerdp_listener_open]: Listening on [0.0.0.0]:3389
[07:30:16:557] [5444:000015c0] [INFO][com.freerdp.server.sample] - [test_peer_mainloop]: We've got a client 172.18.79.208
[07:30:16:560] [5444:000015c0] [ERROR][com.freerdp.core.peer] - [peer_recv_callback_internal]: CONNECTION_STATE_NEGO - rdp_server_accept_nego() fail
[07:30:16:560] [5444:000015c0] [ERROR][com.freerdp.core.transport] - [transport_check_fds]: transport_check_fds: transport->ReceiveCallback() - STATE_RUN_FAILED [-1]
[07:30:16:560] [5444:000015c0] [INFO][com.freerdp.server.sample] - [test_peer_mainloop]: Client 172.18.79.208 disconnected.
^C
C:\Users\Mouri\Desktop\Tools>
```
