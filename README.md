# RouterOS fundamentals lab
I’ve noticed a lot of people struggling with RouterOS setups, so I made this lab. These configurations can be used for learning or as a base for your own networks. MikroTik’s help page is solid overall, but it can be tough for newcomers to grasp the concepts and follow isolated examples, so a full network export might be easier to understand. The configurations cover basic ideas that are essential (or useful) for SOHO and larger networks. I’d recommend checking out these concepts on MikroTik’s help page, searching online, or asking a chatbot if you’re unsure - then use these configurations as a reference while experimenting or setting up your own networks.

Definitely read the lab report first - it explains what these configs are for and why they’re set up that way.

Configurations are available in two versions: one with VLAN support and one without. The non-VLAN version is made for simple networks that require a single broadcast domain, or for users just starting out. The VLAN version divides a single physical network into multiple logical segments, creating multiple broadcast domains. This is useful for isolating IoT devices or setting up a guest network at home. In the VLAN version, we’ll configure a guest network. Make sure you read the detailed comments below.


Topology plans:



non-VLAN version

![no VLANs gitam](https://github.com/user-attachments/assets/a6d91126-66ac-47ce-9bd4-c99ea4538661)


VLAN version

![VLANs gitam](https://github.com/user-attachments/assets/90aeb21c-27aa-4b26-99d9-118943b5183e)




Included concepts:

    • Topology plan. Every network needs a topology plan to ensure smooth packet flow and scalability. Avoid undocumented “bird’s nests” with multiple routers, these can mess up your local network. Sketch out a clear topology, label all ports, and stick to it. Unused ports on network devices can be repurposed for local access or future expansion, as long as they’re properly configured.
    • Public internet access is provided via LTE. LTE1 is configured in pass-through mode, with a TTL mangle rule applied on R1. This configuration can be reverted to use the ether1 port on R1 as a regular WAN port by making a few changes to the settings (as described below).
    • STP (Spanning Tree Protocol) configuration is important. As MikroTik’s help page says, not quite: “You need to configure STP if your network has more than two bridges.” So, if you have more than two network devices on your network, or if you're connecting endpoints via STP-aware bridges (like virtual machine hosts or Docker setups), then it’s mandatory. Otherwise, you might run into ports randomly locking up. VLAN configurations use MSTP (Multiple Spanning Tree Protocol), which is VLAN-aware, while RSTP (Rapid Spanning Tree Protocol), used in non-VLAN setups, is the default mode and isn’t VLAN-aware.
    • VLANs are divided into two groups: the main network (VLAN 10) and the guest network (VLAN 20). Additional VLANs can be configured as needed, like an IoT network alongside the main and guest networks. Inter-VLAN communication is isolated, and the guest network has a 10 Mbps limit in both directions. Note: Some older or specific devices use a different VLAN implementation type that isn’t covered here, make sure to check device compatibility before applying these settings.
    • Simple IP addressing provided by DHCP server(s), including static leases. All network devices have a static IP address. For example, an (imaginary) web server is assigned a static lease, with port forwarding configured to port 80 (HTTP). DHCP pools start at x.x.x.21, since the first addresses are reserved for static allocation.
    • New Wave2 CAPsMAN is used for Wi-Fi management. It supports all current ax APs and ac lineup APs with the wifi-qcom-ac package. (Check the device support list on the help page.) However, older devices can’t be added to the new Wave2 CAPsMAN. Legacy devices still need to be managed using the older CAPsMAN version. This means you now have to run two separate management platforms, one for legacy devices and one for modern ones.
    • The PTP link is configured to establish a wireless bridge on the 5 GHz band while utilizing the 2.4 GHz band as the CAPsMAN interface. The PTP link connects two APs and acts as a bridge between two locations, extending the network, like connecting a shed to a house. Ethernet ports on WBR1 can then be used for further network distribution.
    • Two VPN configurations are included: Road Warrior and Site-to-Site. The Road Warrior setup is used when you need to connect to your network while not at home, such as accessing your Home Assistant instance from a phone while waiting at a bus stop or connecting to a local server from a laptop while drinking coffee at a coffee shop. It can also function as a private VPN service, eliminating the need to subscribe to a paid service — instead, you can use your own infrastructure. The Site-to-Site setup connects two remote locations, such as your home and your parents’ house. This allows you to share resources from your local network, like a media server, NAS (Network Attached Storage), or a pi-hole instance. WireGuard is used as the VPN protocol.
    • Basic firewall. The default configuration firewall is fine, but I think it includes several unnecessary rules for a basic setup. For example, the default rules  "defconf: accept to local loopback (for CAPsMAN)" and  "defconf: drop all from WAN not DSTNATed" aren’t actually needed in my opinion. Plus, I added an input rule to allow VPN connections, etc.
    • Interface lists on R1 are used for CAPsMAN ACLs and firewall filters, including NAT and LTE mangle rules. Also, R1 and LTE1 are configured to restrict device discovery and MAC-based access to the LAN list, which helps prevent local network information from leaking to the public network. VLAN version use these lists more extensively.
    • RoMON is configured for convenient access. For example, when connecting to a local network over a VPN, you can log in to the server and access all network devices - even if they don’t have an IP address assigned or have been lost, but are still reachable at the MAC level.
    • Other various things like time zone, device naming, Wi-Fi debug logs on R1 for improved troubleshooting, fixed L3 MTU values on bridges, etc.




Known issues, limitations and planned improvements:

    • Sniffing, torch, or any other packet inspection on LTE1 causes a loop. Currently, I don’t know the root cause - the configurations look fine, and all tests show no packet leaks across interfaces. If you need to inspect traffic flow, do it from R1 instead.
    • The EoIP tunnel in the VLAN config creates a loop due to BPDUs traveling over it, so I had to set "edge=yes" on the logical interfaces at both ends of the tunnel. This breaks STP, as mentioned earlier, so I had to create a new STP region on WBR1.
    • At first, I also had an interface toggle script running on LTE1 as a safety measure in case the LTE connection fails and doesn’t recover on its own. But setting up a script that toggles the interface every x minutes while the session is down turned out to be more complex than expected.
    • A more advanced queue example is needed for complex setups and requirements.
    • No IPv6
    • Documentation is WIP.
