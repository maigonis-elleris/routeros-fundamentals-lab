/interface bridge
add admin-mac=02:00:00:1F:EF:B1 auto-mac=no dhcp-snooping=yes frame-types=\
    admit-only-vlan-tagged igmp-snooping=yes mtu=1500 multicast-querier=yes \
    name=bridge1 priority=0x1000 protocol-mode=mstp region-name=test \
    region-revision=1 vlan-filtering=yes
/interface ethernet
set [ find default-name=ether1 ] comment=R1
set [ find default-name=ether2 ] comment=AP1
set [ find default-name=ether3 ] comment=AP2
/interface vlan
add comment="Main network" interface=bridge1 name=vlan10_main vlan-id=10
/interface list
add name=LAN
/interface bridge msti
add bridge=bridge1 identifier=1 priority=0x1000 vlan-mapping=10,20
add bridge=bridge1 identifier=2 priority=0x2000 vlan-mapping=2
/interface bridge port
add bridge=bridge1 edge=no frame-types=admit-only-vlan-tagged interface=\
    ether1 trusted=yes
add bridge=bridge1 edge=no frame-types=admit-only-vlan-tagged interface=\
    ether2
add bridge=bridge1 edge=no frame-types=admit-only-vlan-tagged interface=\
    ether3
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether4 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether5 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether6 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether7 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether8 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether9 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether10 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether11 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether12 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether13 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether14 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether15 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether16 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether17 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether18 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether19 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether20 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether21 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether22 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether23 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether24 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=sfp-sfpplus1 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=sfp-sfpplus2 pvid=10
/ip neighbor discovery-settings
set discover-interface-list=LAN
/ipv6 settings
set disable-ipv6=yes
/interface bridge vlan
add bridge=bridge1 tagged=bridge1,ether1,ether2,ether3 vlan-ids=10
add bridge=bridge1 tagged=bridge1,ether1,ether2,ether3 vlan-ids=20
add bridge=bridge1 tagged=bridge1,ether1,ether2,ether3 vlan-ids=2
/interface list member
add interface=vlan10_main list=LAN
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
set name=SW1
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
