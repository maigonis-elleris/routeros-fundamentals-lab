/interface bridge
add admin-mac=02:00:00:09:3C:3A auto-mac=no frame-types=\
    admit-only-vlan-tagged mtu=1500 name=bridge1 priority=0x1000 \
    protocol-mode=mstp region-name=test2 region-revision=1 vlan-filtering=yes
/interface wifi
# managed by CAPsMAN 192.168.210.1, traffic processing on CAP
# mode: AP, SSID: main, channel: 2442/n
set [ find default-name=wifi1 ] configuration.manager=capsman .mode=ap \
    disabled=no mac-address=06:00:00:1F:4A:CE
set [ find default-name=wifi2 ] comment=PTP configuration.country=Latvia \
    .manager=local .mode=station-bridge .ssid=main .tx-power=10 disabled=no \
    mac-address=06:00:00:9F:5F:52 security.authentication-types=\
    wpa2-psk,wpa3-psk .passphrase=00000000
# managed by CAPsMAN 192.168.210.1, traffic processing on CAP
# mode: AP, SSID: guest
add configuration.mode=ap disabled=no mac-address=06:00:00:EF:DE:CF \
    master-interface=wifi1 name=wifi3
/interface eoip
add comment="WBR1 L2 tunnel" mac-address=00:00:5E:80:00:01 name=eoip-tunnel1 \
    remote-address=192.168.210.1 tunnel-id=0
/interface list
add name=LAN
/interface bridge msti
add bridge=bridge1 identifier=1 priority=0x1000 vlan-mapping=10,20
add bridge=bridge1 identifier=2 priority=0x1000 vlan-mapping=2
/interface bridge port
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether1 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=ether2 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=wifi1 pvid=10
add bridge=bridge1 edge=yes frame-types=\
    admit-only-untagged-and-priority-tagged interface=wifi3 pvid=20
add bridge=bridge1 edge=yes frame-types=admit-only-vlan-tagged interface=\
    eoip-tunnel1
/ip neighbor discovery-settings
set discover-interface-list=LAN
/ipv6 settings
set disable-ipv6=yes
/interface bridge vlan
add bridge=bridge1 tagged=bridge1,eoip-tunnel1 vlan-ids=10
add bridge=bridge1 tagged=bridge1,eoip-tunnel1 vlan-ids=20
add bridge=bridge1 tagged=bridge1,eoip-tunnel1 vlan-ids=2
/interface list member
add interface=wifi2 list=LAN
/interface wifi cap
set caps-man-addresses=192.168.210.1 enabled=yes slaves-static=yes
/ip dhcp-client
add interface=wifi2
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
/tool mac-server
set allowed-interface-list=LAN
/tool mac-server mac-winbox
set allowed-interface-list=LAN
/tool netwatch
add comment="Toggle PTP WLAN interface if no connection over 10sec" disabled=\
    no down-script=":log info message=\"PTP link down, toggling interface\"\
    \n/interface/set disabled=yes wifi2\
    \n/interface/set disabled=no wifi2" host=192.168.210.1 interval=10s \
    startup-delay=2m test-script="" type=simple up-script=\
    ":log info message=\"PTP link up\""
/tool romon
set enabled=yes secrets=0000
