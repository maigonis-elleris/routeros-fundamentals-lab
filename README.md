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

    • Topology plan. Every network needs a topology plan to ensure smooth packet flow and scalability.
    • Public internet access is provided via LTE. LTE1 is configured in pass-through mode, with a TTL mangle rule applied on R1.
    • STP (Spanning Tree Protocol) configuration is important. As MikroTik’s help page says, not quite: “You need to configure STP if your network has more than two bridges.” VLAN configurations use MSTP (Multiple Spanning Tree Protocol), which is VLAN-aware, while RSTP (Rapid Spanning Tree Protocol), used in non-VLAN setups, is the default mode and isn’t VLAN-aware.
    • VLANs are divided into two groups: the main network (VLAN 10) and the guest network (VLAN 20).
    • Simple IP addressing provided by DHCP server(s), including static leases.
    • New Wave2 CAPsMAN is used for Wi-Fi management.
    • The PTP link is configured to establish a wireless bridge on the 5 GHz band while utilizing the 2.4 GHz band as the CAPsMAN interface.
    • Two VPN configurations are included: Road Warrior and Site-to-Site. WireGuard is used as the VPN protocol.
    • Basic firewall. The default configuration firewall is fine, but I think it includes several unnecessary rules for a basic setup.
    • Interface lists on R1 are used for CAPsMAN ACLs and firewall filters, including NAT and LTE mangle rules.
    • RoMON is configured for convenient access.
    • Other various things like time zone, device naming, Wi-Fi debug logs on R1 for improved troubleshooting, fixed L3 MTU values on bridges, etc.




Known issues, limitations and planned improvements:

    • Sniffing, torch, or any other packet inspection on LTE1 causes a loop. Currently, I don’t know the root cause - the configurations look fine, and all tests show no packet leaks across interfaces. If you need to inspect traffic flow, do it from R1 instead.
    • The EoIP tunnel in the VLAN config creates a loop due to BPDUs traveling over it, so I had to set "edge=yes" on the logical interfaces at both ends of the tunnel. This breaks STP, as mentioned earlier, so I had to create a new STP region on WBR1.
    • At first, I also had an interface toggle script running on LTE1 as a safety measure in case the LTE connection fails and doesn’t recover on its own. But setting up a script that toggles the interface every x minutes while the session is down turned out to be more complex than expected.
    • A more advanced queue example is needed for complex setups and requirements.
    • Configure the guest network to use Opportunistic Wireless Encryption (OWE).
    • No IPv6
    • Documentation is WIP.




If you notice a configuration issue or have suggestions for improving these basic concepts, please let me know. You can raise an issue on GitHub or post in the MikroTik forums’ Knowledge Base section.
