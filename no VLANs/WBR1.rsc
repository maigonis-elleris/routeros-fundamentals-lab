/interface bridge
add admin-mac=22:00:00:09:3C:3A auto-mac=no mtu=1500 name=bridge1 priority=\
    0x3000
/interface wifi datapath
add bridge=bridge1 disabled=no name=datapath1
/interface wifi
# managed by CAPsMAN 192.168.200.1, traffic processing on CAP
# mode: AP, SSID: test, channel: 2412/n
set [ find default-name=wifi2 ] configuration.manager=capsman .mode=ap \
    datapath=datapath1 disabled=no mac-address=06:00:00:1F:4A:CE name=wifi1
set [ find default-name=wifi1 ] comment=PTP configuration.country=Latvia \
    .manager=local .mode=station-bridge .ssid=test .station-roaming=yes .tx-power=10 datapath=\
    datapath1 disabled=no mac-address=06:00:00:9F:5F:52 name=wifi2 \
    security.authentication-types=wpa2-psk,wpa3-psk .ft=yes .passphrase=00000000
/interface bridge port
add bridge=bridge1 edge=yes interface=ether1
add bridge=bridge1 edge=yes interface=ether2
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
set name=WBR1
/system package update
set channel=testing
/system routerboard settings
set auto-upgrade=yes
/tool bandwidth-server
set enabled=no
/tool romon
set enabled=yes secrets=0000
