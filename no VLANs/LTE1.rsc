/interface ethernet
set [ find default-name=ether1 ] comment=R1
/interface lte
set [ find default-name=lte1 ] allow-roaming=no
/interface vlan
add comment="LTE device management" interface=ether1 name=vlan2_man vlan-id=2
add comment="LTE passthrough" interface=ether1 name=vlan3_passt vlan-id=3
/interface list
add name=LAN
/interface lte apn
set [ find default=yes ] ip-type=ipv4 passthrough-interface=vlan3_passt \
    passthrough-mac=auto
/ip neighbor discovery-settings
set discover-interface-list=LAN
/ipv6 settings
set disable-ipv6=yes
/interface list member
add interface=vlan2_man list=LAN
/ip dhcp-client
add interface=vlan2_man
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
