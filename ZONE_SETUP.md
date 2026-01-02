# CloudStack Zone Configuration Guide

This guide details the steps to configure the **Basic Zone** in CloudStack for your installation on **10.0.0.243**.

## 🚀 Accessing the UI
*   **URL:** `http://10.0.0.243:8080/client`
*   **Login:** `admin`
*   **Password:** `password`

---

## 🛠️ Setup Wizard Steps

Upon first login, select **Continue with Basic Zone**.

### 1. Zone Details
Define the general network settings (DNS).
*   **Name:** `Zone1`
*   **DNS 1:** `8.8.8.8`
*   **DNS 2:** `8.8.4.4`
*   **Internal DNS 1:** `8.8.8.8`
*   **Hypervisor:** `KVM`
*   *(Click Next)*

### 2. Physical Network
Configure the physical connection traffic.
*   **Physical Network Name:** `cloudbr0` (or default)
*   **Public Traffic:** `DefaultSharedNetworkOfferingWithSGService` (Selected by default)
*   *(Click Next)*

### 3. Public Traffic
Define the IP range for public internet access (Source NAT).
*   **Gateway:** `10.0.0.1`
*   **Netmask:** `255.255.255.0`
*   **VLAN/VNI:** *(Leave Empty)*
*   **Start IP:** `10.0.0.110` (Dedicated range for Public IPs)
*   **End IP:** `10.0.0.140`
*   *(Click Add -> Click Next)*

### 4. Pod Configuration
Define the reserved IP range for System VMs (SSVM, CPVM).
*   **Name:** `Pod1`
*   **Reserved System Gateway:** `10.0.0.1`
*   **Reserved System Netmask:** `255.255.255.0`
*   **Start IP:** `10.0.0.200`
*   **End IP:** `10.0.0.210`
*   *(Click Next)*

### 5. Guest Traffic
Define the IP range available for your Virtual Machines (Instances).
*   **Gateway:** `10.0.0.1`
*   **Netmask:** `255.255.255.0`
*   **Start IP:** `10.0.0.50`
*   **End IP:** `10.0.0.100` (Adjust based on your local DHCP availability)
*   **VLAN:** *(Leave Empty)*
*   *(Click Next)*

### 6. Cluster
*   **Name:** `Cluster1`
*   *(Click Next)*

### 7. Host
Add your All-in-One server as the hypervisor host.
*   **Host Name:** `10.0.0.243`
*   **User Name:** `root`
*   **Password:** `password` (Or the password you set for the root user)
*   *(Click Next)*

### 8. Primary Storage
Location for running VM disks (Volume).
*   **Name:** `Primary1`
*   **Protocol:** `nfs`
*   **Server:** `10.0.0.243`
*   **Path:** `/export/primary`
*   *(Click Next)*

### 9. Secondary Storage
Location for ISOs, Templates, and Snapshots.
*   **Provider:** `NFS`
*   **Server:** `10.0.0.243`
*   **Path:** `/export/secondary`
*   *(Click Next)*

### 10. Launch
Click **Launch Zone**.
*   Wait for all steps to turn Green.
*   Enable the Zone when prompted.

---

## ✅ Post-Setup Validation
1.  Go to **Infrastructure > System VMs**.
2.  Wait until you see 2 VMs (`s-*-VM` and `v-*-VM`).
3.  Ensure their **Agent State** becomes **Up** (Green) and **State** is **Running**.
    *   *Note: This process may take 5-15 minutes depending on download speed for the SystemVM Template.*
