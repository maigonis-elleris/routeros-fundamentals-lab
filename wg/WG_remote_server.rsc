/ip firewall filter
add action=accept chain=input comment="accept Wireguard" port=37254 protocol=udp
/interface wireguard
add comment=Server listen-port=37254 mtu=1420 name=wg1 private-key=\
    "<>removed<>"
/interface wireguard peers
add allowed-address=192.168.90.5/32,192.168.200.0/24 comment=\
    "Site to Site link" interface=wg1 name=peer4 persistent-keepalive=\
    25s private-key="<>removed<>" \
    public-key="<>removed<>"
/ip address
add address=192.168.90.1/24 interface=wg1 network=192.168.90.0
/ip route
add comment="Site to Site route" disabled=no dst-address=192.168.200.0/24 gateway=wg1 routing-table=main suppress-hw-offload=no
/tool netwatch
add comment="Site to Site WG link reset" disabled=no down-script=\
    ":log info message=\"Site to Site WG link down, resetting peer connection\"\
    \n/interface/wireguard/peers/disable 4\
    \n/interface/wireguard/peers/enable 4" host=192.168.90.5 interval=15s startup-delay=2m test-script="" type=simple up-script=\
    ":log info message=\"Site to Site WG link up\""
