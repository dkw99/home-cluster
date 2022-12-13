terraform {
    required_providers {
        proxmox = {
            source = "telmate/proxmox"
            version = "2.9.0"
        }
        sops = {
            source  = "carlpett/sops"
            version = "0.7.1"
        }
    }
}

data "sops_file" "proxmox_secrets" {
    source_file = "secret.sops.yaml"
}
    provider "proxmox" {
        pm_parallel  = 1
        pm_tls_insecure  = true
        pm_api_url  = data.sops_file.proxmox_secrets.data["pm_api_url"]
        pm_api_token_id  = data.sops_file.proxmox_secrets.data["pm_api_token_id"]
        pm_api_token_secret = data.sops_file.proxmox_secrets.data["pm_api_token_secret"]
}

k3s_workers = {
    m1 = { target_node = "pve3", vcpu = "3", memory = "8192", disk_size = "120G", name = "k3s-node-4", ip = "192.168.16.104", gw = "192.168.16.1", vlan_tag="16" }
    # m2 = { target_node = "pve02", vcpu = "4", memory = "16384", disk_size = "30G", name = "k8sm2.cloudalbania.com", ip = "192.168.88.82", gw = "192.168.88.1" },
    # m3 = { target_node = "pve02", vcpu = "4", memory = "16384", disk_size = "30G", name = "k8sm3.cloudalbania.com", ip = "192.168.88.83", gw = "192.168.88.1" }
}

resource "proxmox_vm_qemu" "pve-k3s-workers" {
    for_each    = var.k3s_workers
    name        = each.value.name
    desc        = each.value.name
    target_node = each.value.target_node
    # os_type     = "cloud-init"
    full_clone  = true
    memory      = each.value.memory
    sockets     = "1"
    cores       = each.value.vcpu
    cpu         = "host"
    scsihw      = "virtio-scsi-pci"
    hotplug     = "network,disk,usb"
    iso         = "naspvestore:iso/Fedora-Server-dvd-x86_64-36-1.5.iso"  #replace vms2 with real datastore name
    # clone       = var.k3s_source_template
    agent       = 1
    disk {
        size    = each.value.disk_size
        type    = "virtio"
        storage = "vmdata"
    }
    network {
        model  = "virtio"
        bridge = "vmbr0"
        tag = each.value.vlan_tag
    }
}