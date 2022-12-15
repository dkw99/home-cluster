k3s_workers = {
    m1 = { target_node = "pve3", vcpu = "3", memory = "8192", disk_size = "120G", name = "k3s-node-4", ip = "192.168.16.104", gw = "192.168.16.1", vlan_tag="16" }
    # m2 = { target_node = "pve02", vcpu = "4", memory = "16384", disk_size = "30G", name = "k8sm2.cloudalbania.com", ip = "192.168.88.82", gw = "192.168.88.1" },
    # m3 = { target_node = "pve02", vcpu = "4", memory = "16384", disk_size = "30G", name = "k8sm3.cloudalbania.com", ip = "192.168.88.83", gw = "192.168.88.1" }
}
