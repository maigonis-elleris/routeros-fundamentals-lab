/interface bridge
add admin-mac=12:00:00:F5:D8:5F auto-mac=no mtu=1500 name=bridge1 priority=\
    0x2000
/interface ethernet
set [ find default-name=ether1 ] comment=SW1
/interface wifi datapath
add bridge=bridge1 disabled=no name=datapath1
/interface wifi
# managed by CAPsMAN 192.168.200.1, traffic processing on CAP
# mode: AP, SSID: test, channel: 2437/n
set [ find default-name=wifi1 ] configuration.manager=capsman .mode=ap \
    datapath=datapath1 disabled=no mac-address=06:00:00:5C:61:72
# managed by CAPsMAN 192.168.200.1, traffic processing on CAP
# mode: AP, SSID: test, channel: 5500/ac/Ce/D
set [ find default-name=wifi2 ] configuration.manager=capsman .mode=ap \
    datapath=datapath1 disabled=no mac-address=06:00:00:CD:92:8C
/interface bridge port
add bridge=bridge1 edge=no interface=ether1
add bridge=bridge1 edge=yes interface=ether2
add bridge=bridge1 edge=yes interface=ether3
add bridge=bridge1 edge=yes interface=ether4
add bridge=bridge1 edge=yes interface=ether5
/queue type
set 2 kind=fq-codel
/ipv6 settings
set disable-ipv6=yes
/interface wifi cap
set caps-man-addresses=192.168.200.1 enabled=yes slaves-datapath=datapath1 \
    slaves-static=yes
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
set name=AP2
/system package update
set channel=testing
/system routerboard settings
set auto-upgrade=yes
/tool bandwidth-server
set enabled=no
/tool romon
set enabled=yes secrets=0000
