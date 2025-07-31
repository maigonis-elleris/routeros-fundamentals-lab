/interface bridge
add admin-mac=12:00:00:F5:D8:5F auto-mac=no frame-types=\
    admit-only-vlan-tagged mtu=1500 name=bridge1 priority=0x2000 \
    protocol-mode=mstp region-name=test region-revision=1 vlan-filtering=yes
/interface ethernet
set [ find default-name=ether1 ] comment=SW1
/interface wifi
# managed by CAPsMAN 192.168.210.1, traffic processing on CAP
# mode: AP, SSID: main, channel: 2437/n
set [ find default-name=wifi1 ] configuration.manager=capsman .mode=ap \
    disabled=no mac-address=06:00:00:5C:61:72
# managed by CAPsMAN 192.168.210.1, traffic processing on CAP
# mode: AP, SSID: main, channel: 5500/ac/Ce/D
set [ find default-name=wifi2 ] configuration.manager=capsman .mode=ap \
    disabled=no mac-address=06:00:00:CD:92:8C
# managed by CAPsMAN 192.168.210.1, traffic processing on CAP
# mode: AP, SSID: guest
add configuration.mode=ap disabled=no mac-address=06:00:00:4E:D6:74 \
    master-interface=wifi1 name=wifi3
# managed by CAPsMAN 192.168.210.1, traffic processing on CAP
# mode: AP, SSID: guest
add configuration.mode=ap disabled=no mac-address=06:00:00:44:FD:09 \
    master-interface=wifi2 name=wifi4
/interface vlan
add comment="Main network" interface=bridge1 name=vlan10_main vlan-id=10
/interface list
add name=LAN
/queue type
set 2 kind=fq-codel
/interface bridge msti
add bridge=bridge1 identifier=1 priority=0x2000 vlan-mapping=10,20
add bridge=bridge1 identifier=2 priority=0x3000 vlan-mapping=2
/interface bridge port
add bridge=bridge1 edge=no frame-types=admit-only-vlan-tagged interface=\
    ether1
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether2 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether3 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether4 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether5 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=wifi1 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=wifi3 pvid=20
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=wifi4 pvid=20
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=wifi2 pvid=10
/ip neighbor discovery-settings
set discover-interface-list=LAN
/ipv6 settings
set disable-ipv6=yes
/interface bridge vlan
add bridge=bridge1 tagged=bridge1,ether1 vlan-ids=10
add bridge=bridge1 tagged=bridge1,ether1 vlan-ids=20
add bridge=bridge1 tagged=bridge1,ether1 vlan-ids=2
/interface list member
add interface=vlan10_main list=LAN
/interface wifi cap
set caps-man-addresses=192.168.210.1 enabled=yes slaves-static=yes
/ip dhcp-client
add interface=vlan10_main
/ip service
set ftp disabled=yes
set ssh disabled=yes
set telnet disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/system clock
set time-zone-name=Europe/Riga
/system identity
set name=AP2
/system package update
set channel=testing
/system routerboard settings
set auto-upgrade=yes
/tool bandwidth-server
set enabled=no
/tool mac-server
set allowed-interface-list=LAN
/tool mac-server mac-winbox
set allowed-interface-list=LAN
/tool romon
set enabled=yes secrets=0000
