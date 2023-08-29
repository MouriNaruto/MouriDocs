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

Here is the packets captured by Wireshark:

```
No.     Time           Source                Destination           Protocol Length Info
      1 0.000000       172.18.79.208         172.18.74.251         RDP      73     Negotiate Request

Frame 1: 73 bytes on wire (584 bits), 73 bytes captured (584 bits) on interface \Device\NPF_{5B4954EB-2C0A-406F-B50E-5C3BC4133052}, id 0
Ethernet II, Src: Microsof_5f:80:0e (00:15:5d:5f:80:0e), Dst: Microsof_31:5f:95 (00:15:5d:31:5f:95)
Internet Protocol Version 4, Src: 172.18.79.208, Dst: 172.18.74.251
Transmission Control Protocol, Src Port: 49232, Dst Port: 3389, Seq: 1, Ack: 1, Len: 19
TPKT, Version: 3, Length: 19
ISO 8073/X.224 COTP Connection-Oriented Transport Protocol
Remote Desktop Protocol
    Type: RDP Negotiation Request (0x01)
    Flags: 0x00
    Length: 8
    requestedProtocols: 0x0000000b, TLS security supported, CredSSP supported, CredSSP with Early User Authorization Result PDU supported

No.     Time           Source                Destination           Protocol Length Info
      2 0.313249       172.18.74.251         172.18.79.208         RDP      73     Negotiate Response

Frame 2: 73 bytes on wire (584 bits), 73 bytes captured (584 bits) on interface \Device\NPF_{5B4954EB-2C0A-406F-B50E-5C3BC4133052}, id 0
Ethernet II, Src: Microsof_31:5f:95 (00:15:5d:31:5f:95), Dst: Microsof_5f:80:0e (00:15:5d:5f:80:0e)
Internet Protocol Version 4, Src: 172.18.74.251, Dst: 172.18.79.208
Transmission Control Protocol, Src Port: 3389, Dst Port: 49232, Seq: 1, Ack: 20, Len: 19
TPKT, Version: 3, Length: 19
ISO 8073/X.224 COTP Connection-Oriented Transport Protocol
Remote Desktop Protocol
    Type: RDP Negotiation Response (0x02)
    Flags: 0x03, Extended Client Data Blocks supported, Graphics Pipeline Extension Protocol supported
    Length: 8
    selectedProtocol: TLS 1.0, 1.1 or 1.2 (0x00000001)

No.     Time           Source                Destination           Protocol Length Info
      3 0.315431       172.18.79.208         172.18.74.251         RDP      516    ClientData

Frame 3: 516 bytes on wire (4128 bits), 516 bytes captured (4128 bits) on interface \Device\NPF_{5B4954EB-2C0A-406F-B50E-5C3BC4133052}, id 0
Ethernet II, Src: Microsof_5f:80:0e (00:15:5d:5f:80:0e), Dst: Microsof_31:5f:95 (00:15:5d:31:5f:95)
Internet Protocol Version 4, Src: 172.18.79.208, Dst: 172.18.74.251
Transmission Control Protocol, Src Port: 49232, Dst Port: 3389, Seq: 20, Ack: 20, Len: 462
TPKT, Version: 3, Length: 462
ISO 8073/X.224 COTP Connection-Oriented Transport Protocol
MULTIPOINT-COMMUNICATION-SERVICE T.125
GENERIC-CONFERENCE-CONTROL T.124
Remote Desktop Protocol
    ClientData
        clientCoreData
            headerType: clientCoreData (0xc001)
            headerLength: 234
            versionMajor: 16
            versionMinor: 8
            desktopWidth: 1280
            desktopHeight: 960
            colorDepth: 8 bits-per-pixel (bpp) (0xca01)
            SASSequence: 43523
            keyboardLayout: 2052
            clientBuild: 22621
            clientName: MOURI-LAPTOP-1
            keyboardType: IBM enhanced (101-key or 102-key) keyboard (4)
            keyboardSubType: 0
            keyboardFunctionKey: 12
            imeFileName: 000000000000000000000000000000000000000000000000000000000000000000000000…
            postBeta2ColorDepth: 8 bits-per-pixel (bpp) (0xca01)
            clientProductId: 1
            serialNumber: 0
            highColorDepth: 24-bit RGB mask (0x0018)
            supportedColorDepths: 0x000f
            earlyCapabilityFlags: 4031
            clientDigProductId: 7cdbcf8d-6664-4ca3-8816-28a9e1b
            connectionType: Auto Detect (7)
            pad1octet: 0x00
            serverSelectedProtocol: 1
        clientClusterData
            headerType: clientClusterData (0xc004)
            headerLength: 12
            clusterFlags: 0x00000015
            redirectedSessionId: 0x00000000
        clientSecurityData
            headerType: clientSecurityData (0xc002)
            headerLength: 12
            encryptionMethods: 1b000000
            extEncryptionMethods: 00000000
        clientNetworkData
            headerType: clientNetworkData (0xc003)
            headerLength: 56
            channelCount: 4
            channelDefArray
                channelDef
                    name: rdpdr
                    options: 0x80800000
                        1... .... .... .... .... .... .... .... = optionsInitialized: 0x1
                        .0.. .... .... .... .... .... .... .... = encryptRDP: 0x0
                        ..0. .... .... .... .... .... .... .... = encryptSC: 0x0
                        ...0 .... .... .... .... .... .... .... = encryptCS: 0x0
                        .... 0... .... .... .... .... .... .... = priorityHigh: 0x0
                        .... .0.. .... .... .... .... .... .... = priorityMed: 0x0
                        .... ..0. .... .... .... .... .... .... = priorityLow: 0x0
                        .... .... 1... .... .... .... .... .... = compressRDP: 0x1
                        .... .... .0.. .... .... .... .... .... = compress: 0x0
                        .... .... ..0. .... .... .... .... .... = showProtocol: 0x0
                        .... .... ...0 .... .... .... .... .... = remoteControlPersistent: 0x0
                channelDef
                    name: rdpsnd
                    options: 0xc0000000
                        1... .... .... .... .... .... .... .... = optionsInitialized: 0x1
                        .1.. .... .... .... .... .... .... .... = encryptRDP: 0x1
                        ..0. .... .... .... .... .... .... .... = encryptSC: 0x0
                        ...0 .... .... .... .... .... .... .... = encryptCS: 0x0
                        .... 0... .... .... .... .... .... .... = priorityHigh: 0x0
                        .... .0.. .... .... .... .... .... .... = priorityMed: 0x0
                        .... ..0. .... .... .... .... .... .... = priorityLow: 0x0
                        .... .... 0... .... .... .... .... .... = compressRDP: 0x0
                        .... .... .0.. .... .... .... .... .... = compress: 0x0
                        .... .... ..0. .... .... .... .... .... = showProtocol: 0x0
                        .... .... ...0 .... .... .... .... .... = remoteControlPersistent: 0x0
                channelDef
                    name: cliprdr
                    options: 0xc0a00000
                        1... .... .... .... .... .... .... .... = optionsInitialized: 0x1
                        .1.. .... .... .... .... .... .... .... = encryptRDP: 0x1
                        ..0. .... .... .... .... .... .... .... = encryptSC: 0x0
                        ...0 .... .... .... .... .... .... .... = encryptCS: 0x0
                        .... 0... .... .... .... .... .... .... = priorityHigh: 0x0
                        .... .0.. .... .... .... .... .... .... = priorityMed: 0x0
                        .... ..0. .... .... .... .... .... .... = priorityLow: 0x0
                        .... .... 1... .... .... .... .... .... = compressRDP: 0x1
                        .... .... .0.. .... .... .... .... .... = compress: 0x0
                        .... .... ..1. .... .... .... .... .... = showProtocol: 0x1
                        .... .... ...0 .... .... .... .... .... = remoteControlPersistent: 0x0
                channelDef
                    name: drdynvc
                    options: 0xc0800000
                        1... .... .... .... .... .... .... .... = optionsInitialized: 0x1
                        .1.. .... .... .... .... .... .... .... = encryptRDP: 0x1
                        ..0. .... .... .... .... .... .... .... = encryptSC: 0x0
                        ...0 .... .... .... .... .... .... .... = encryptCS: 0x0
                        .... 0... .... .... .... .... .... .... = priorityHigh: 0x0
                        .... .0.. .... .... .... .... .... .... = priorityMed: 0x0
                        .... ..0. .... .... .... .... .... .... = priorityLow: 0x0
                        .... .... 1... .... .... .... .... .... = compressRDP: 0x1
                        .... .... .0.. .... .... .... .... .... = compress: 0x0
                        .... .... ..0. .... .... .... .... .... = showProtocol: 0x0
                        .... .... ...0 .... .... .... .... .... = remoteControlPersistent: 0x0
        clientMsgChannelData
            headerType: clientMsgChannelData (0xc006)
            headerLength: 8
            msgChannelFlags: 0x00000000
        clientMultiTransportData
            headerType: clientMultiTransportData (0xc00a)
            headerLength: 8
            multiTransportFlags: 0x00000305

```
