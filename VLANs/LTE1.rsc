/interface bridge
add admin-mac=22:00:00:82:67:C9 auto-mac=no frame-types=\
    admit-only-vlan-tagged mtu=1500 name=bridge1 priority=0x3000 \
    protocol-mode=mstp region-name=test region-revision=1 vlan-filtering=yes
/interface ethernet
set [ find default-name=ether1 ] comment=R1
/interface lte
set [ find default-name=lte1 ] allow-roaming=no
/interface vlan
add comment="LTE passthrough" interface=bridge1 name=vlan2_passt vlan-id=2
add comment="Main network" interface=bridge1 name=vlan10_main vlan-id=10
/interface list
add name=LAN
/interface lte apn
set [ find default=yes ] ip-type=ipv4 passthrough-interface=vlan2_passt \
    passthrough-mac=auto
/interface bridge msti
add bridge=bridge1 identifier=1 priority=0x3000 vlan-mapping=10,20
add bridge=bridge1 identifier=2 priority=0x2000 vlan-mapping=2
/interface bridge port
add bridge=bridge1 edge=no frame-types=admit-only-vlan-tagged interface=\
    ether1
/ip neighbor discovery-settings
set discover-interface-list=LAN
/ipv6 settings
set disable-ipv6=yes
/interface bridge vlan
add bridge=bridge1 tagged=bridge1,ether1 vlan-ids=10
add bridge=bridge1 tagged=bridge1,ether1 vlan-ids=2
add bridge=bridge1 tagged=bridge1,ether1 vlan-ids=20
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
set name=LTE1
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
