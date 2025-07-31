/interface bridge
add admin-mac=12:00:00:6D:37:58 auto-mac=no frame-types=\
    admit-only-vlan-tagged mtu=1500 name=bridge1 priority=0x2000 \
    protocol-mode=mstp region-name=test region-revision=1 vlan-filtering=yes
/interface ethernet
set [ find default-name=ether1 ] comment=LTE1
set [ find default-name=ether2 ] comment=SW1
/interface eoip
add comment="WBR1 L2 tunnel" mac-address=00:00:5E:80:00:00 name=eoip-tunnel1 \
    remote-address=192.168.210.6 tunnel-id=0
/interface wireguard
add comment="Road Warrior" listen-port=28327 mtu=1420 name=wg1 private-key=\
    "UHzPb7FdlCXXWxWPDba09mvC/i0WjZjnL9lQmehenEQ="
add comment="Site to Site" listen-port=38772 mtu=1420 name=wg2 private-key=\
    "<>removed<>"
/interface vlan
add comment="LTE passthrough" interface=bridge1 name=vlan2_passt vlan-id=2
add comment="Main network" interface=bridge1 name=vlan10_main vlan-id=10
add comment="Guest network" interface=bridge1 name=vlan20_guest vlan-id=20
/interface list
add name=WAN
add name=WLAN_5G
add name=WLAN_2.4G
add include=WLAN_2.4G,WLAN_5G name=WLAN
add name=LAN_full_access
add name=LAN_restricted
add include=LAN_full_access,LAN_restricted name=LAN
/interface wifi channel
add disabled=no name=2G-AUTO width=20mhz
add deprioritize-unii-3-4=yes disabled=no name="5G-AUTO 40mhz" width=20/40mhz
add disabled=no frequency=2412 name=2G-CH1 width=20mhz
add disabled=no frequency=2437 name=2G-CH6 width=20mhz
add disabled=no frequency=2462 name=2G-CH11 width=20mhz
add frequency=5180 name="5G-CH36 80mhz" width=20/40/80mhz
add frequency=5260 name="5G-CH52 80mhz" width=20/40/80mhz
add frequency=5500 name="5G-CH100 80mhz" width=20/40/80mhz
add frequency=5580 name="5G-CH116 80mhz" width=20/40/80mhz
add frequency=5180 name="5G-CH36 20mhz" width=20mhz
add frequency=5180 name="5G-CH36 40mhz" width=20/40mhz
add frequency=5260 name="5G-CH52 40mhz" width=20/40mhz
add frequency=5300 name="5G-CH60 40mhz" width=20/40mhz
add frequency=5500 name="5G-CH100 40mhz" width=20/40mhz
add frequency=5540 name="5G-CH108 40mhz" width=20/40mhz
add frequency=5580 name="5G-CH116 40mhz" width=20/40mhz
add frequency=5620 name="5G-CH124 40mhz" width=20/40mhz
add frequency=5220 name="5G-CH44 40mhz" width=20/40mhz
add disabled=no frequency=5180 name="5G-CH36 160mhz" width=20/40/80/160mhz
add disabled=no frequency=5500 name="5G-CH100 160mhz" width=20/40/80/160mhz
add disabled=no frequency=5200 name="5G-CH40 20mhz" width=20mhz
add disabled=no frequency=5220 name="5G-CH44 20mhz" width=20mhz
add disabled=no frequency=5240 name="5G-CH48 20mhz" width=20mhz
add disabled=no frequency=5260 name="5G-CH52 20mhz" width=20mhz
add disabled=no frequency=5280 name="5G-CH56 20mhz" width=20mhz
add disabled=no frequency=5300 name="5G-CH60 20mhz" width=20mhz
add disabled=no frequency=5320 name="5G-CH64 20mhz" width=20mhz
add disabled=no frequency=5500 name="5G-CH100 20mhz" width=20mhz
add disabled=no frequency=5520 name="5G-CH104 20mhz" width=20mhz
add disabled=no frequency=5540 name="5G-CH108 20mhz" width=20mhz
add disabled=no frequency=5560 name="5G-CH112 20mhz" width=20mhz
add disabled=no frequency=5580 name="5G-CH116 20mhz" width=20mhz
add disabled=no frequency=5600 name="5G-CH120 20mhz" width=20mhz
add disabled=no frequency=5620 name="5G-CH124 20mhz" width=20mhz
add disabled=no frequency=5640 name="5G-CH128 20mhz" width=20mhz
add disabled=no frequency=5680 name="5G-CH136 20mhz" width=20mhz
add disabled=no frequency=5700 name="5G-CH140 20mhz" width=20mhz
add deprioritize-unii-3-4=yes disabled=no name="5G-AUTO 20mhz" width=20mhz
add deprioritize-unii-3-4=yes disabled=no name="5G-AUTO 80mhz" width=\
    20/40/80mhz
add deprioritize-unii-3-4=yes disabled=no name="5G-AUTO 160mhz" width=\
    20/40/80/160mhz
/interface wifi datapath
add bridge=bridge1 disabled=no name=datapath_none
add bridge=bridge1 disabled=no name=datapath_vlan10 vlan-id=10
add bridge=bridge1 disabled=no name=datapath_vlan20 vlan-id=20
/interface wifi security
add authentication-types=wpa2-psk,wpa3-psk connect-priority=0/1 disabled=no \
    ft=yes ft-over-ds=yes name=test_wpa2/wpa3 passphrase=00000000 wps=disable
add authentication-types=wpa2-psk connect-priority=0/1 disabled=no \
    management-protection=disabled name=test_wpa2 passphrase=00000000 wps=\
    disable
add authentication-types=wpa3-psk connect-priority=0/1 disabled=no ft=yes \
    ft-over-ds=yes name=test_wpa3 passphrase=00000000 wps=disable
/interface wifi configuration
add country=Latvia datapath=datapath_vlan10 disabled=no multicast-enhance=\
    enabled name=ax_main security=test_wpa2/wpa3 ssid=main tx-power=10
add country=Latvia datapath=datapath_vlan20 disabled=no multicast-enhance=\
    enabled name=ax_guest security=test_wpa2/wpa3 ssid=guest tx-power=10
add country=Latvia datapath=datapath_none disabled=no multicast-enhance=\
    enabled name=ac_n_main security=test_wpa2/wpa3 ssid=main tx-power=10
add country=Latvia datapath=datapath_none disabled=no multicast-enhance=\
    enabled name=ac_n_guest security=test_wpa2/wpa3 ssid=guest tx-power=10
/interface wifi
# operated by CAP 192.168.210.4, traffic processing on CAP
add channel=2G-CH1 channel.frequency=2412 configuration=ax_main \
    configuration.mode=ap .tx-power=6 datapath.interface-list=WLAN_2.4G \
    disabled=no mac-address=06:00:00:7E:C3:B6 name=AP1-2G radio-mac=\
    F4:1E:57:2D:CD:80
# operated by CAP 192.168.210.4, traffic processing on CAP
add configuration=ax_guest configuration.mode=ap datapath.interface-list=\
    WLAN_2.4G disabled=no mac-address=06:00:00:A7:64:94 master-interface=\
    AP1-2G name=AP1-2G-GUEST
# operated by CAP 192.168.210.4, traffic processing on CAP
add channel="5G-CH36 40mhz" configuration=ax_main configuration.mode=ap \
    datapath.interface-list=WLAN_5G disabled=no mac-address=06:00:00:EB:23:D9 \
    name=AP1-5G radio-mac=F4:1E:57:2D:CD:81
# operated by CAP 192.168.210.4, traffic processing on CAP
add configuration=ax_guest configuration.mode=ap datapath.interface-list=\
    WLAN_5G disabled=no mac-address=06:00:00:5D:60:B2 master-interface=AP1-5G \
    name=AP1-5G-GUEST
# operated by CAP 192.168.210.5, traffic processing on CAP
add channel=2G-CH6 channel.frequency=2437 configuration=ac_n_main \
    configuration.mode=ap .tx-power=6 datapath.interface-list=WLAN_2.4G \
    disabled=no mac-address=06:00:00:5C:61:72 name=AP2-2G radio-mac=\
    C4:AD:34:C5:F0:9B
# operated by CAP 192.168.210.5, traffic processing on CAP
add configuration=ac_n_guest configuration.mode=ap datapath.interface-list=\
    WLAN_2.4G disabled=no mac-address=06:00:00:4E:D6:74 master-interface=\
    AP2-2G name=AP2-2G-GUEST
# operated by CAP 192.168.210.5, traffic processing on CAP
add channel="5G-AUTO 40mhz" configuration=ac_n_main configuration.mode=ap \
    datapath.interface-list=WLAN_5G disabled=no mac-address=06:00:00:CD:92:8C \
    name=AP2-5G radio-mac=C4:AD:34:C5:F0:9C
# operated by CAP 192.168.210.5, traffic processing on CAP
add configuration=ac_n_guest configuration.mode=ap datapath.interface-list=\
    WLAN_5G disabled=no mac-address=06:00:00:44:FD:09 master-interface=AP2-5G \
    name=AP2-5G-GUEST
# operated by CAP 192.168.210.6, traffic processing on CAP
add channel=2G-AUTO configuration=ac_n_main configuration.mode=ap \
    datapath.interface-list=WLAN_2.4G disabled=no mac-address=\
    06:00:00:1F:4A:CE name=WBR1-2G radio-mac=C4:AD:34:D9:4B:06
# operated by CAP 192.168.210.6, traffic processing on CAP
add configuration=ac_n_guest configuration.mode=ap datapath.interface-list=\
    WLAN_2.4G disabled=no mac-address=06:00:00:EF:DE:CF master-interface=\
    WBR1-2G name=WBR1-2G-GUEST
/ip pool
add name=dhcp_pool_10_main ranges=192.168.210.21-192.168.210.254
add name=dhcp_pool_20_guest ranges=192.168.220.21-192.168.220.254
/ip dhcp-server
add address-pool=dhcp_pool_10_main interface=vlan10_main name=dhcp_10_main
add address-pool=dhcp_pool_20_guest interface=vlan20_guest name=dhcp_20_guest
/queue simple
add max-limit=10M/10M name=vlan20_guest target=vlan20_guest
/queue type
add kind=fq-codel name=fqc
/interface bridge msti
add bridge=bridge1 identifier=1 priority=0x2000 vlan-mapping=10,20
add bridge=bridge1 identifier=2 priority=0x1000 vlan-mapping=2
/interface bridge port
add bridge=bridge1 edge=no frame-types=admit-only-vlan-tagged interface=\
    ether1
add bridge=bridge1 edge=no frame-types=admit-only-vlan-tagged interface=\
    ether2
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether3 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether4 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether5 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=sfp1 pvid=10
add bridge=bridge1 edge=yes frame-types=admit-only-vlan-tagged interface=\
    eoip-tunnel1
/ip neighbor discovery-settings
set discover-interface-list=LAN_full_access
/ipv6 settings
set disable-ipv6=yes
/interface bridge vlan
add bridge=bridge1 tagged=bridge1,ether1,ether2,eoip-tunnel1 vlan-ids=10
add bridge=bridge1 tagged=bridge1,ether2,ether1,eoip-tunnel1 vlan-ids=20
add bridge=bridge1 tagged=bridge1,ether1,ether2,eoip-tunnel1 vlan-ids=2
/interface list member
add interface=vlan2_passt list=WAN
add interface=wg1 list=LAN_full_access
add interface=vlan10_main list=LAN_full_access
add interface=vlan20_guest list=LAN_restricted
/interface wifi access-list
add action=reject disabled=no interface=WLAN mac-address=F2:00:00:67:40:0C
add action=reject disabled=no interface=WLAN_2.4G signal-range=-120..-81
add action=accept disabled=no interface=WLAN_2.4G signal-range=-80..0
add action=reject disabled=no interface=WLAN_5G signal-range=-120..-91
add action=accept disabled=no interface=WLAN_5G signal-range=-90..0
/interface wifi capsman
set enabled=yes interfaces=vlan10_main package-path=/ \
    require-peer-certificate=no upgrade-policy=suggest-same-version
/interface wifi provisioning
add action=create-enabled comment=2G-AX disabled=no master-configuration=\
    ax_main name-format=%I-2G slave-configurations=ax_guest \
    slave-name-format=%I-2G-GUEST supported-bands=2ghz-ax
add action=create-enabled comment=5G-AX disabled=no master-configuration=\
    ax_main name-format=%I-5G slave-configurations=ax_guest \
    slave-name-format=%I-5G-GUEST supported-bands=5ghz-ax
add action=create-enabled comment=2G-N disabled=no master-configuration=\
    ac_n_main name-format=%I-2G slave-configurations=ac_n_guest \
    slave-name-format=%I-2G-GUEST supported-bands=2ghz-n
add action=create-enabled comment=5G-AC disabled=no master-configuration=\
    ac_n_main name-format=%I-5G slave-configurations=ac_n_guest \
    slave-name-format=%I-5G-GUEST supported-bands=5ghz-ac
/interface wireguard peers
add allowed-address=192.168.80.2/32 comment=Phone interface=wg1 name=peer1 \
    persistent-keepalive=25s private-key=\
    "IKAaRxIN+J6X/tMVmDXVgC5t4/vbsgX25bHLNHLePEs=" public-key=\
    "n8FI5znKo3GM48mIwS7vNtZzG6zTdxwvUHV/xELz4zY=" responder=yes
add allowed-address=192.168.90.1/32,192.168.10.0/24 comment=\
    "Site to Site link" endpoint-address=harijs.id.lv endpoint-port=37254 \
    interface=wg2 name=peer2 persistent-keepalive=25s public-key=\
    "<>removed<>"
/ip address
add address=192.168.80.1/24 interface=wg1 network=192.168.80.0
add address=192.168.90.5/24 interface=wg2 network=192.168.90.0
add address=192.168.210.1/24 interface=vlan10_main network=192.168.210.0
add address=192.168.220.1/24 interface=vlan20_guest network=192.168.220.0
/ip dhcp-client
add interface=vlan2_passt
/ip dhcp-server lease
add address=192.168.210.10 comment=Server mac-address=F2:00:00:3E:23:BB \
    server=dhcp_10_main
add address=192.168.210.2 comment=LTE1 mac-address=22:00:00:82:67:C9 server=\
    dhcp_10_main
add address=192.168.210.3 comment=SW1 mac-address=02:00:00:1F:EF:B1 server=\
    dhcp_10_main
add address=192.168.210.4 comment=AP1 mac-address=12:00:00:60:E5:BA server=\
    dhcp_10_main
add address=192.168.210.5 comment=AP2 mac-address=12:00:00:F5:D8:5F server=\
    dhcp_10_main
add address=192.168.210.6 comment=WBR1 mac-address=06:00:00:9F:5F:52 server=\
    dhcp_10_main
/ip dhcp-server network
add address=192.168.210.0/24 dns-server=192.168.210.1 gateway=192.168.210.1
add address=192.168.220.0/24 dns-server=192.168.220.1 gateway=192.168.220.1
/ip dns
set allow-remote-requests=yes
/ip firewall filter
add action=accept chain=input comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=input comment="defconf: drop invalid" connection-state=\
    invalid
add action=accept chain=input comment="accept connections to wg1" port=28327 \
    protocol=udp
add action=accept chain=input comment="defconf: accept ICMP" protocol=icmp
add action=accept chain=input comment=\
    "accept DNS requests from LAN list (UDP)" in-interface-list=LAN port=53 \
    protocol=udp
add action=accept chain=input comment=\
    "accept DNS requests from LAN list (TCP)" in-interface-list=LAN port=53 \
    protocol=tcp
add action=drop chain=input comment=\
    "defconf: drop all not coming from LAN_full_access" in-interface-list=\
    !LAN_full_access
add action=fasttrack-connection chain=forward comment=\
    "fasttrack LAN_full_access download" connection-state=established,related \
    hw-offload=yes in-interface-list=LAN_full_access
add action=fasttrack-connection chain=forward comment=\
    "fasttrack LAN_full_access upload" connection-state=established,related \
    hw-offload=yes out-interface-list=LAN_full_access
add action=accept chain=forward comment=\
    "defconf: accept established,related, untracked" connection-state=\
    established,related,untracked
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid
add action=accept chain=forward comment="allow LAN list to access WAN list" \
    in-interface-list=LAN out-interface-list=WAN
add action=drop chain=forward comment="block inter-vlan connections" \
    in-interface=all-vlan out-interface=all-vlan
/ip firewall mangle
add action=change-ttl chain=postrouting comment=\
    "Modify TTL for LTE connection" new-ttl=set:64 out-interface-list=WAN \
    protocol=!icmp
/ip firewall nat
add action=masquerade chain=srcnat comment="defconf: masquerade" \
    out-interface-list=WAN
add action=dst-nat chain=dstnat comment="server: http" dst-port=80 \
    in-interface-list=WAN protocol=tcp to-addresses=192.168.210.10 to-ports=\
    80
/ip route
add comment="Site to Site route" disabled=no dst-address=192.168.10.0/24 \
    gateway=wg2 routing-table=main suppress-hw-offload=no
/ip service
set ftp disabled=yes
set ssh disabled=yes
set telnet disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/system clock
set time-zone-name=Europe/Riga
/system identity
set name=R1
/system logging
add topics=wireless,debug
/system package update
set channel=testing
/system routerboard settings
set auto-upgrade=yes
/tool bandwidth-server
set enabled=no
/tool mac-server
set allowed-interface-list=LAN_full_access
/tool mac-server mac-winbox
set allowed-interface-list=LAN_full_access
/tool netwatch
add comment="Site to Site WG link reset" disabled=no down-script=":log info me\
    ssage=\"Site to Site WG link down, resetting peer connection\"\
    \n/interface/wireguard/peers/disable 1\
    \n/interface/wireguard/peers/enable 1" host=192.168.90.1 interval=15s \
    startup-delay=2m test-script="" type=simple up-script=\
    ":log info message=\"Site to Site WG link up\""
/tool romon
set enabled=yes secrets=0000
