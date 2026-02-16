terraform {
  required_providers {
    cloudstack = {
      source  = "cloudstack/cloudstack"
      version = "0.6.0"
    }
  }
}

provider "cloudstack" {
  api_url    = var.api_url
  api_key    = var.api_key
  secret_key = var.secret_key
}

# 1. Zona Advanced
resource "cloudstack_zone" "my_zone" {
  name                   = "default"
  dns1                   = "8.8.8.8"
  internal_dns1          = "8.8.8.8"
  network_type           = "Advanced" # Zona Avançada
  security_group_enabled = true
}

# 2. Rede Física
resource "cloudstack_physical_network" "phy_net" {
  name              = "PhysicalNetwork1"
  zone_id           = cloudstack_zone.my_zone.id
  isolation_methods = ["VLAN"]
}

resource "cloudstack_traffic_type" "public" {
  physical_network_id = cloudstack_physical_network.phy_net.id
  traffic_type        = "Public"
  kvm_network_label   = "cloudbr0"
}

resource "cloudstack_traffic_type" "management" {
  physical_network_id = cloudstack_physical_network.phy_net.id
  traffic_type        = "Management"
  kvm_network_label   = "cloudbr0"
}

resource "cloudstack_traffic_type" "guest" {
  physical_network_id = cloudstack_physical_network.phy_net.id
  traffic_type        = "Guest"
  kvm_network_label   = "cloudbr0"
}

resource "cloudstack_traffic_type" "storage" {
  physical_network_id = cloudstack_physical_network.phy_net.id
  traffic_type        = "Storage"
  kvm_network_label   = "cloudbr0"
}

# 3. Pod (Management Traffic)
resource "cloudstack_pod" "pod1" {
  name     = "pod1"
  zone_id  = cloudstack_zone.my_zone.id
  gateway  = "10.0.30.1"
  netmask  = "255.255.255.0"
  start_ip = "10.0.30.200"
  end_ip   = "10.0.30.210"
}

# 4. Range de IPs Públicos (Public Traffic VLAN 50)
resource "cloudstack_vlan_ip_range" "public_ip_range" {
  zone_id             = cloudstack_zone.my_zone.id
  physical_network_id = cloudstack_physical_network.phy_net.id
  gateway             = "10.0.50.1"
  netmask             = "255.255.255.0"
  start_ip            = "10.0.50.100"
  end_ip              = "10.0.50.200"
  vlan                = "50"
}

# 5. Cluster (Com Host Integrado)
resource "cloudstack_cluster" "cluster1" {
  cluster_name = "cluster1"
  zone_id      = cloudstack_zone.my_zone.id
  pod_id       = cloudstack_pod.pod1.id
  hypervisor   = "KVM"
  cluster_type = "CloudManaged"
}

resource "cloudstack_host" "kvm_host_1" {
  url        = "http://10.0.30.254"
  username   = "root"
  password   = "matheus"
  hypervisor = "KVM"
  zone_id    = cloudstack_zone.my_zone.id
  pod_id     = cloudstack_pod.pod1.id
  cluster_id = cloudstack_cluster.cluster1.id
}

resource "cloudstack_host" "kvm_host_2" {
  url        = "http://10.0.30.251"
  username   = "root"
  password   = "matheus"
  hypervisor = "KVM"
  zone_id    = cloudstack_zone.my_zone.id
  pod_id     = cloudstack_pod.pod1.id
  cluster_id = cloudstack_cluster.cluster1.id
}


# 6. Armazenamento Primário (Storage Traffic VLAN 40)
resource "cloudstack_storage_pool" "primary" {
  name       = "primary-storage"
  zone_id    = cloudstack_zone.my_zone.id
  scope      = "ZONE"
  url        = "nfs://10.0.40.10/mnt/pool_primary/primary"
  hypervisor = "KVM"
}

# 7. Armazenamento Secundário
resource "cloudstack_secondary_storage" "secondary" {
  url              = "nfs://10.0.40.10/mnt/pool_secondary/secondary"
  zone_id          = cloudstack_zone.my_zone.id
  storage_provider = "NFS"
}
