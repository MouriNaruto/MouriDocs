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

[rdp_packets_redirected_from_vmbus.pcapng]: rdp_packets_redirected_from_vmbus.pcapng

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
    Section number: 1
    Interface id: 0 (\Device\NPF_{5B4954EB-2C0A-406F-B50E-5C3BC4133052})
        Interface name: \Device\NPF_{5B4954EB-2C0A-406F-B50E-5C3BC4133052}
        Interface description: 以太网 3
    Encapsulation type: Ethernet (1)
    Arrival Time: Aug 29, 2023 07:30:16.245814000 中国标准时间
    [Time shift for this packet: 0.000000000 seconds]
    Epoch Time: 1693265416.245814000 seconds
    [Time delta from previous captured frame: 0.000000000 seconds]
    [Time delta from previous displayed frame: 0.000000000 seconds]
    [Time since reference or first frame: 0.000000000 seconds]
    Frame Number: 1
    Frame Length: 73 bytes (584 bits)
    Capture Length: 73 bytes (584 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: eth:ethertype:ip:tcp:tpkt:cotp:rdp]
    [Coloring Rule Name: TCP]
    [Coloring Rule String: tcp]
Ethernet II, Src: Microsof_5f:80:0e (00:15:5d:5f:80:0e), Dst: Microsof_31:5f:95 (00:15:5d:31:5f:95)
    Destination: Microsof_31:5f:95 (00:15:5d:31:5f:95)
        Address: Microsof_31:5f:95 (00:15:5d:31:5f:95)
        .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
        .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
    Source: Microsof_5f:80:0e (00:15:5d:5f:80:0e)
        Address: Microsof_5f:80:0e (00:15:5d:5f:80:0e)
        .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
        .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
    Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 172.18.79.208, Dst: 172.18.74.251
    0100 .... = Version: 4
    .... 0101 = Header Length: 20 bytes (5)
    Differentiated Services Field: 0x00 (DSCP: CS0, ECN: Not-ECT)
        0000 00.. = Differentiated Services Codepoint: Default (0)
        .... ..00 = Explicit Congestion Notification: Not ECN-Capable Transport (0)
    Total Length: 59
    Identification: 0x4abc (19132)
    010. .... = Flags: 0x2, Don't fragment
        0... .... = Reserved bit: Not set
        .1.. .... = Don't fragment: Set
        ..0. .... = More fragments: Not set
    ...0 0000 0000 0000 = Fragment Offset: 0
    Time to Live: 128
    Protocol: TCP (6)
    Header Checksum: 0xbd10 [validation disabled]
    [Header checksum status: Unverified]
    Source Address: 172.18.79.208
    Destination Address: 172.18.74.251
Transmission Control Protocol, Src Port: 49232, Dst Port: 3389, Seq: 1, Ack: 1, Len: 19
    Source Port: 49232
    Destination Port: 3389
    [Stream index: 0]
    [Conversation completeness: Incomplete (8)]
    [TCP Segment Len: 19]
    Sequence Number: 1    (relative sequence number)
    Sequence Number (raw): 2596072530
    [Next Sequence Number: 20    (relative sequence number)]
    Acknowledgment Number: 1    (relative ack number)
    Acknowledgment number (raw): 771724846
    0101 .... = Header Length: 20 bytes (5)
    Flags: 0x018 (PSH, ACK)
        000. .... .... = Reserved: Not set
        ...0 .... .... = Accurate ECN: Not set
        .... 0... .... = Congestion Window Reduced: Not set
        .... .0.. .... = ECN-Echo: Not set
        .... ..0. .... = Urgent: Not set
        .... ...1 .... = Acknowledgment: Set
        .... .... 1... = Push: Set
        .... .... .0.. = Reset: Not set
        .... .... ..0. = Syn: Not set
        .... .... ...0 = Fin: Not set
        [TCP Flags: ·······AP···]
    Window: 513
    [Calculated window size: 513]
    [Window size scaling factor: -1 (unknown)]
    Checksum: 0x8ff6 [unverified]
    [Checksum Status: Unverified]
    Urgent Pointer: 0
    [Timestamps]
        [Time since first frame in this TCP stream: 0.000000000 seconds]
        [Time since previous frame in this TCP stream: 0.000000000 seconds]
    [SEQ/ACK analysis]
        [Bytes in flight: 19]
        [Bytes sent since last PSH flag: 19]
    TCP payload (19 bytes)
TPKT, Version: 3, Length: 19
    Version: 3
    Reserved: 0
    Length: 19
ISO 8073/X.224 COTP Connection-Oriented Transport Protocol
    Length: 14
    PDU Type: CR Connect Request (0x0e)
    Destination reference: 0x0000
    Source reference: 0x0000
    0000 .... = Class: 0
    .... ..0. = Extended formats: False
    .... ...0 = No explicit flow control: False
Remote Desktop Protocol
    Type: RDP Negotiation Request (0x01)
    Flags: 0x00
        .... ...0 = Restricted admin mode required: False
        .... 0... = Correlation info present: False
    Length: 8
    requestedProtocols: 0x0000000b, TLS security supported, CredSSP supported, CredSSP with Early User Authorization Result PDU supported
        .... .... .... .... .... .... .... ...1 = TLS security supported: True
        .... .... .... .... .... .... .... ..1. = CredSSP supported: True
        .... .... .... .... .... .... .... .0.. = RDSTLS supported: False
        .... .... .... .... .... .... .... 1... = CredSSP with Early User Authorization Result PDU supported: True

0000  00 15 5d 31 5f 95 00 15 5d 5f 80 0e 08 00 45 00   ..]1_...]_....E.
0010  00 3b 4a bc 40 00 80 06 bd 10 ac 12 4f d0 ac 12   .;J.@.......O...
0020  4a fb c0 50 0d 3d 9a bc ec 52 2d ff 96 2e 50 18   J..P.=...R-...P.
0030  02 01 8f f6 00 00 03 00 00 13 0e e0 00 00 00 00   ................
0040  00 01 00 08 00 0b 00 00 00                        .........

No.     Time           Source                Destination           Protocol Length Info
      2 0.313249       172.18.74.251         172.18.79.208         RDP      73     Negotiate Response

Frame 2: 73 bytes on wire (584 bits), 73 bytes captured (584 bits) on interface \Device\NPF_{5B4954EB-2C0A-406F-B50E-5C3BC4133052}, id 0
    Section number: 1
    Interface id: 0 (\Device\NPF_{5B4954EB-2C0A-406F-B50E-5C3BC4133052})
        Interface name: \Device\NPF_{5B4954EB-2C0A-406F-B50E-5C3BC4133052}
        Interface description: 以太网 3
    Encapsulation type: Ethernet (1)
    Arrival Time: Aug 29, 2023 07:30:16.559063000 中国标准时间
    [Time shift for this packet: 0.000000000 seconds]
    Epoch Time: 1693265416.559063000 seconds
    [Time delta from previous captured frame: 0.313249000 seconds]
    [Time delta from previous displayed frame: 0.313249000 seconds]
    [Time since reference or first frame: 0.313249000 seconds]
    Frame Number: 2
    Frame Length: 73 bytes (584 bits)
    Capture Length: 73 bytes (584 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: eth:ethertype:ip:tcp:tpkt:cotp:rdp]
    [Coloring Rule Name: TCP]
    [Coloring Rule String: tcp]
Ethernet II, Src: Microsof_31:5f:95 (00:15:5d:31:5f:95), Dst: Microsof_5f:80:0e (00:15:5d:5f:80:0e)
    Destination: Microsof_5f:80:0e (00:15:5d:5f:80:0e)
        Address: Microsof_5f:80:0e (00:15:5d:5f:80:0e)
        .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
        .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
    Source: Microsof_31:5f:95 (00:15:5d:31:5f:95)
        Address: Microsof_31:5f:95 (00:15:5d:31:5f:95)
        .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
        .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
    Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 172.18.74.251, Dst: 172.18.79.208
    0100 .... = Version: 4
    .... 0101 = Header Length: 20 bytes (5)
    Differentiated Services Field: 0x00 (DSCP: CS0, ECN: Not-ECT)
        0000 00.. = Differentiated Services Codepoint: Default (0)
        .... ..00 = Explicit Congestion Notification: Not ECN-Capable Transport (0)
    Total Length: 59
    Identification: 0x94e3 (38115)
    010. .... = Flags: 0x2, Don't fragment
        0... .... = Reserved bit: Not set
        .1.. .... = Don't fragment: Set
        ..0. .... = More fragments: Not set
    ...0 0000 0000 0000 = Fragment Offset: 0
    Time to Live: 128
    Protocol: TCP (6)
    Header Checksum: 0x0000 [validation disabled]
    [Header checksum status: Unverified]
    Source Address: 172.18.74.251
    Destination Address: 172.18.79.208
Transmission Control Protocol, Src Port: 3389, Dst Port: 49232, Seq: 1, Ack: 20, Len: 19
    Source Port: 3389
    Destination Port: 49232
    [Stream index: 0]
    [Conversation completeness: Incomplete (8)]
    [TCP Segment Len: 19]
    Sequence Number: 1    (relative sequence number)
    Sequence Number (raw): 771724846
    [Next Sequence Number: 20    (relative sequence number)]
    Acknowledgment Number: 20    (relative ack number)
    Acknowledgment number (raw): 2596072549
    0101 .... = Header Length: 20 bytes (5)
    Flags: 0x018 (PSH, ACK)
        000. .... .... = Reserved: Not set
        ...0 .... .... = Accurate ECN: Not set
        .... 0... .... = Congestion Window Reduced: Not set
        .... .0.. .... = ECN-Echo: Not set
        .... ..0. .... = Urgent: Not set
        .... ...1 .... = Acknowledgment: Set
        .... .... 1... = Push: Set
        .... .... .0.. = Reset: Not set
        .... .... ..0. = Syn: Not set
        .... .... ...0 = Fin: Not set
        [TCP Flags: ·······AP···]
    Window: 8212
    [Calculated window size: 8212]
    [Window size scaling factor: -1 (unknown)]
    Checksum: 0xf31d [unverified]
    [Checksum Status: Unverified]
    Urgent Pointer: 0
    [Timestamps]
        [Time since first frame in this TCP stream: 0.313249000 seconds]
        [Time since previous frame in this TCP stream: 0.313249000 seconds]
    [SEQ/ACK analysis]
        [This is an ACK to the segment in frame: 1]
        [The RTT to ACK the segment was: 0.313249000 seconds]
        [Bytes in flight: 19]
        [Bytes sent since last PSH flag: 19]
    TCP payload (19 bytes)
TPKT, Version: 3, Length: 19
    Version: 3
    Reserved: 0
    Length: 19
ISO 8073/X.224 COTP Connection-Oriented Transport Protocol
    Length: 14
    PDU Type: CC Connect Confirm (0x0d)
    Destination reference: 0x0000
    Source reference: 0x0000
    0000 .... = Class: 0
    .... ..0. = Extended formats: False
    .... ...0 = No explicit flow control: False
Remote Desktop Protocol
    Type: RDP Negotiation Response (0x02)
    Flags: 0x03, Extended Client Data Blocks supported, Graphics Pipeline Extension Protocol supported
        .... ...1 = Extended Client Data Blocks supported: True
        .... ..1. = Graphics Pipeline Extension Protocol supported: True
        .... 0... = Restricted admin mode supported: False
        ...0 .... = Restricted authentication mode supported: False
    Length: 8
    selectedProtocol: TLS 1.0, 1.1 or 1.2 (0x00000001)

0000  00 15 5d 5f 80 0e 00 15 5d 31 5f 95 08 00 45 00   ..]_....]1_...E.
0010  00 3b 94 e3 40 00 80 06 00 00 ac 12 4a fb ac 12   .;..@.......J...
0020  4f d0 0d 3d c0 50 2d ff 96 2e 9a bc ec 65 50 18   O..=.P-......eP.
0030  20 14 f3 1d 00 00 03 00 00 13 0e d0 00 00 00 00    ...............
0040  00 02 03 08 00 01 00 00 00                        .........

No.     Time           Source                Destination           Protocol Length Info
      3 0.315431       172.18.79.208         172.18.74.251         RDP      516    ClientData

Frame 3: 516 bytes on wire (4128 bits), 516 bytes captured (4128 bits) on interface \Device\NPF_{5B4954EB-2C0A-406F-B50E-5C3BC4133052}, id 0
    Section number: 1
    Interface id: 0 (\Device\NPF_{5B4954EB-2C0A-406F-B50E-5C3BC4133052})
        Interface name: \Device\NPF_{5B4954EB-2C0A-406F-B50E-5C3BC4133052}
        Interface description: 以太网 3
    Encapsulation type: Ethernet (1)
    Arrival Time: Aug 29, 2023 07:30:16.561245000 中国标准时间
    [Time shift for this packet: 0.000000000 seconds]
    Epoch Time: 1693265416.561245000 seconds
    [Time delta from previous captured frame: 0.002182000 seconds]
    [Time delta from previous displayed frame: 0.002182000 seconds]
    [Time since reference or first frame: 0.315431000 seconds]
    Frame Number: 3
    Frame Length: 516 bytes (4128 bits)
    Capture Length: 516 bytes (4128 bits)
    [Frame is marked: False]
    [Frame is ignored: False]
    [Protocols in frame: eth:ethertype:ip:tcp:tpkt:cotp:t125:t124]
    [Coloring Rule Name: TCP]
    [Coloring Rule String: tcp]
Ethernet II, Src: Microsof_5f:80:0e (00:15:5d:5f:80:0e), Dst: Microsof_31:5f:95 (00:15:5d:31:5f:95)
    Destination: Microsof_31:5f:95 (00:15:5d:31:5f:95)
        Address: Microsof_31:5f:95 (00:15:5d:31:5f:95)
        .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
        .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
    Source: Microsof_5f:80:0e (00:15:5d:5f:80:0e)
        Address: Microsof_5f:80:0e (00:15:5d:5f:80:0e)
        .... ..0. .... .... .... .... = LG bit: Globally unique address (factory default)
        .... ...0 .... .... .... .... = IG bit: Individual address (unicast)
    Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: 172.18.79.208, Dst: 172.18.74.251
    0100 .... = Version: 4
    .... 0101 = Header Length: 20 bytes (5)
    Differentiated Services Field: 0x00 (DSCP: CS0, ECN: Not-ECT)
        0000 00.. = Differentiated Services Codepoint: Default (0)
        .... ..00 = Explicit Congestion Notification: Not ECN-Capable Transport (0)
    Total Length: 502
    Identification: 0x4abe (19134)
    010. .... = Flags: 0x2, Don't fragment
        0... .... = Reserved bit: Not set
        .1.. .... = Don't fragment: Set
        ..0. .... = More fragments: Not set
    ...0 0000 0000 0000 = Fragment Offset: 0
    Time to Live: 128
    Protocol: TCP (6)
    Header Checksum: 0xbb53 [validation disabled]
    [Header checksum status: Unverified]
    Source Address: 172.18.79.208
    Destination Address: 172.18.74.251
Transmission Control Protocol, Src Port: 49232, Dst Port: 3389, Seq: 20, Ack: 20, Len: 462
    Source Port: 49232
    Destination Port: 3389
    [Stream index: 0]
    [Conversation completeness: Incomplete (8)]
    [TCP Segment Len: 462]
    Sequence Number: 20    (relative sequence number)
    Sequence Number (raw): 2596072549
    [Next Sequence Number: 482    (relative sequence number)]
    Acknowledgment Number: 20    (relative ack number)
    Acknowledgment number (raw): 771724865
    0101 .... = Header Length: 20 bytes (5)
    Flags: 0x018 (PSH, ACK)
        000. .... .... = Reserved: Not set
        ...0 .... .... = Accurate ECN: Not set
        .... 0... .... = Congestion Window Reduced: Not set
        .... .0.. .... = ECN-Echo: Not set
        .... ..0. .... = Urgent: Not set
        .... ...1 .... = Acknowledgment: Set
        .... .... 1... = Push: Set
        .... .... .0.. = Reset: Not set
        .... .... ..0. = Syn: Not set
        .... .... ...0 = Fin: Not set
        [TCP Flags: ·······AP···]
    Window: 513
    [Calculated window size: 513]
    [Window size scaling factor: -1 (unknown)]
    Checksum: 0xe6e2 [unverified]
    [Checksum Status: Unverified]
    Urgent Pointer: 0
    [Timestamps]
        [Time since first frame in this TCP stream: 0.315431000 seconds]
        [Time since previous frame in this TCP stream: 0.002182000 seconds]
    [SEQ/ACK analysis]
        [This is an ACK to the segment in frame: 2]
        [The RTT to ACK the segment was: 0.002182000 seconds]
        [Bytes in flight: 462]
        [Bytes sent since last PSH flag: 462]
    TCP payload (462 bytes)
TPKT, Version: 3, Length: 462
    Version: 3
    Reserved: 0
    Length: 462
ISO 8073/X.224 COTP Connection-Oriented Transport Protocol
    Length: 2
    PDU Type: DT Data (0x0f)
    [Destination reference: 0x0000]
    .000 0000 = TPDU number: 0x00
    1... .... = Last data unit: Yes
MULTIPOINT-COMMUNICATION-SERVICE T.125
    ConnectMCSPDU: connect-initial (101)
        connect-initial
            callingDomainSelector: 01
            calledDomainSelector: 01
            upwardFlag: True
            targetParameters
                maxChannelIds: 34
                maxUserIds: 2
                maxTokenIds: 0
                numPriorities: 1
                minThroughput: 0
                maxHeight: 1
                maxMCSPDUsize: 65535
                protocolVersion: 2
            minimumParameters
                maxChannelIds: 1
                maxUserIds: 1
                maxTokenIds: 1
                numPriorities: 1
                minThroughput: 0
                maxHeight: 1
                maxMCSPDUsize: 1056
                protocolVersion: 2
            maximumParameters
                maxChannelIds: 65535
                maxUserIds: 64535
                maxTokenIds: 65535
                numPriorities: 1
                minThroughput: 0
                maxHeight: 1
                maxMCSPDUsize: 65535
                protocolVersion: 2
            userData: 000500147c00018158000800100001c00044756361814a01c0ea00100008000005c00301…
GENERIC-CONFERENCE-CONTROL T.124
    ConnectData
        t124Identifier: object (0)
            object: 0.0.20.124.0.1 (Generic Conference Control)
        connectPDU: 000800100001c00044756361814a01c0ea00100008000005c00301ca03aa040800005d58…
            connectGCCPDU: conferenceCreateRequest (0)
                conferenceCreateRequest
                    conferenceName
                        numeric: 1
                    .... 0... lockedConference: False
                    .... .0.. listedConference: False
                    .... ..0. conductibleConference: False
                    terminationMethod: automatic (0)
                    userData: 1 item
                        Item 0
                            UserData item
                                key: h221NonStandard (1)
                                    h221NonStandard: 44756361
                                value: 01c0ea00100008000005c00301ca03aa040800005d5800004d004f005500520049002d00…
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

0000  00 15 5d 31 5f 95 00 15 5d 5f 80 0e 08 00 45 00   ..]1_...]_....E.
0010  01 f6 4a be 40 00 80 06 bb 53 ac 12 4f d0 ac 12   ..J.@....S..O...
0020  4a fb c0 50 0d 3d 9a bc ec 65 2d ff 96 41 50 18   J..P.=...e-..AP.
0030  02 01 e6 e2 00 00 03 00 01 ce 02 f0 80 7f 65 82   ..............e.
0040  01 c2 04 01 01 04 01 01 01 01 ff 30 19 02 01 22   ...........0..."
0050  02 01 02 02 01 00 02 01 01 02 01 00 02 01 01 02   ................
0060  02 ff ff 02 01 02 30 19 02 01 01 02 01 01 02 01   ......0.........
0070  01 02 01 01 02 01 00 02 01 01 02 02 04 20 02 01   ............. ..
0080  02 30 1c 02 02 ff ff 02 02 fc 17 02 02 ff ff 02   .0..............
0090  01 01 02 01 00 02 01 01 02 02 ff ff 02 01 02 04   ................
00a0  82 01 61 00 05 00 14 7c 00 01 81 58 00 08 00 10   ..a....|...X....
00b0  00 01 c0 00 44 75 63 61 81 4a 01 c0 ea 00 10 00   ....Duca.J......
00c0  08 00 00 05 c0 03 01 ca 03 aa 04 08 00 00 5d 58   ..............]X
00d0  00 00 4d 00 4f 00 55 00 52 00 49 00 2d 00 4c 00   ..M.O.U.R.I.-.L.
00e0  41 00 50 00 54 00 4f 00 50 00 2d 00 31 00 00 00   A.P.T.O.P.-.1...
00f0  00 00 04 00 00 00 00 00 00 00 0c 00 00 00 00 00   ................
0100  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
0110  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
0120  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
0130  00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 ca   ................
0140  01 00 00 00 00 00 18 00 0f 00 bf 0f 37 00 63 00   ............7.c.
0150  64 00 62 00 63 00 66 00 38 00 64 00 2d 00 36 00   d.b.c.f.8.d.-.6.
0160  36 00 36 00 34 00 2d 00 34 00 63 00 61 00 33 00   6.6.4.-.4.c.a.3.
0170  2d 00 38 00 38 00 31 00 36 00 2d 00 32 00 38 00   -.8.8.1.6.-.2.8.
0180  61 00 39 00 65 00 31 00 62 00 00 00 07 00 01 00   a.9.e.1.b.......
0190  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   ................
01a0  00 00 00 00 04 c0 0c 00 15 00 00 00 00 00 00 00   ................
01b0  02 c0 0c 00 1b 00 00 00 00 00 00 00 03 c0 38 00   ..............8.
01c0  04 00 00 00 72 64 70 64 72 00 00 00 00 00 80 80   ....rdpdr.......
01d0  72 64 70 73 6e 64 00 00 00 00 00 c0 63 6c 69 70   rdpsnd......clip
01e0  72 64 72 00 00 00 a0 c0 64 72 64 79 6e 76 63 00   rdr.....drdynvc.
01f0  00 00 80 c0 06 c0 08 00 00 00 00 00 0a c0 08 00   ................
0200  05 03 00 00                                       ....

```

Here is the [API Monitor] capture file: [TermServiceCapture.apmx64].

[API Monitor]: http://www.rohitab.com/apimonitor
[TermServiceCapture.apmx64]: TermServiceCapture.apmx64
