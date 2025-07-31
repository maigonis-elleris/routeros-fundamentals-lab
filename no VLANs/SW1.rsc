/interface bridge
add admin-mac=02:00:00:1F:EF:B1 auto-mac=no dhcp-snooping=yes igmp-snooping=\
    yes mtu=1500 multicast-querier=yes name=bridge1 priority=0x1000
/interface ethernet
set [ find default-name=ether1 ] comment=R1
set [ find default-name=ether2 ] comment=AP1
set [ find default-name=ether3 ] comment=AP2
/interface bridge port
add bridge=bridge1 edge=no interface=ether1 trusted=yes
add bridge=bridge1 edge=no interface=ether2
add bridge=bridge1 edge=no interface=ether3
add bridge=bridge1 edge=yes interface=ether4
add bridge=bridge1 edge=yes interface=ether5
add bridge=bridge1 edge=yes interface=ether6
add bridge=bridge1 edge=yes interface=ether7
add bridge=bridge1 edge=yes interface=ether8
add bridge=bridge1 edge=yes interface=ether9
add bridge=bridge1 edge=yes interface=ether10
add bridge=bridge1 edge=yes interface=ether11
add bridge=bridge1 edge=yes interface=ether12
add bridge=bridge1 edge=yes interface=ether13
add bridge=bridge1 edge=yes interface=ether14
add bridge=bridge1 edge=yes interface=ether15
add bridge=bridge1 edge=yes interface=ether16
add bridge=bridge1 edge=yes interface=ether17
add bridge=bridge1 edge=yes interface=ether18
add bridge=bridge1 edge=yes interface=ether19
add bridge=bridge1 edge=yes interface=ether20
add bridge=bridge1 edge=yes interface=ether21
add bridge=bridge1 edge=yes interface=ether22
add bridge=bridge1 edge=yes interface=ether23
add bridge=bridge1 edge=yes interface=ether24
add bridge=bridge1 edge=yes interface=sfp-sfpplus1
add bridge=bridge1 edge=yes interface=sfp-sfpplus2
/ipv6 settings
set disable-ipv6=yes
/ip dhcp-client
add interface=bridge1
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
/tool romon
set enabled=yes secrets=0000
