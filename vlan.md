# Configuração de VLANs - Homelab (Switch TP-Link + Servidores)

**Data**: 10 de Janeiro de 2026  
**Status**: ✅ Configurado e Funcionando

---

## 📋 Sumário

1. [Visão Geral](#visão-geral)
2. [Tabela de VLANs](#tabela-de-vlans)
3. [Configuração do Switch TP-Link](#configuração-do-switch-tp-link)
4. [Configuração de VLAN no Linux (nmcli)](#configuração-de-vlan-no-linux-nmcli)
5. [Scripts MikroTik](#scripts-mikrotik)

---

## Visão Geral

### Arquitetura

```
                    MikroTik (ether4)
                         │
                         │ VLAN 30 (untagged)
                         │ VLAN 40, 50, 100-110 (tagged)
                         │
                    ┌────┴────┐
                    │ Switch  │
                    │ TP-Link │
                    │TL-SG105E│
                    └────┬────┘
                         │
    ┌────────┬───────────┼───────────┬────────┐
    │        │           │           │        │
   P1       P2          P3          P4       P5
 Server1  Server2     (vazia)    (vazia)  MikroTik
```

---

## Tabela de VLANs

| VLAN ID | Nome | Subnet | Uso |
|---------|------|--------|-----|
| **30** | HOMELAB | 10.0.30.0/24 | Gerenciamento dos servidores |
| **40** | STORAGE | 10.0.40.0/24 | Acesso direto ao TrueNAS (NFS/iSCSI) |
| **50** | PUBLIC | 10.0.50.0/24 | Serviços web expostos (Ingress) |
| **100-110** | GUEST | 10.0.10x.0/24 | Redes de VMs (CloudStack) |

---

## Configuração do Switch TP-Link

### Acesso
- **IP**: `10.0.30.253` (via DHCP)
- **URL**: `http://10.0.30.253`
- **Login**: `admin` / `admin`

### VLANs Configuradas

| VLAN ID | Nome | Member Ports | Tagged Ports | Untagged Ports |
|---------|------|--------------|--------------|----------------|
| 1 | Default | 1-5 | - | 1-5 |
| 30 | HOMELAB | 1-5 | - | 1-5 |
| 40 | STORAGE | 1-2,5 | 1-2,5 | - |
| 50 | PUBLIC | 1-2,5 | 1-2,5 | - |
| 100 | GUEST | 1-2,5 | 1-2,5 | - |
| 101 | GUEST | 1-2,5 | 1-2,5 | - |
| 102 | GUEST | 1-2,5 | 1-2,5 | - |
| 103 | GUEST | 1-2,5 | 1-2,5 | - |
| 104 | GUEST | 1-2,5 | 1-2,5 | - |
| 105 | GUEST | 1-2,5 | 1-2,5 | - |
| 106 | GUEST | 1-2,5 | 1-2,5 | - |
| 107 | GUEST | 1-2,5 | 1-2,5 | - |
| 108 | GUEST | 1-2,5 | 1-2,5 | - |
| 109 | GUEST | 1-2,5 | 1-2,5 | - |
| 110 | GUEST | 1-2,5 | 1-2,5 | - |

### PVID Settings

| Porta | PVID |
|-------|------|
| Port 1 | 30 |
| Port 2 | 30 |
| Port 3 | 30 |
| Port 4 | 30 |
| Port 5 | 30 |

### Mapeamento de Portas

| Porta | Dispositivo | VLANs |
|-------|-------------|-------|
| 1 | Servidor 1 | 30 (untagged), 40/50/100-110 (tagged) |
| 2 | Servidor 2 | 30 (untagged), 40/50/100-110 (tagged) |
| 3 | (vazia) | 30 (untagged) |
| 4 | (vazia) | 30 (untagged) |
| 5 | MikroTik | 30 (untagged), 40/50/100-110 (tagged) |

---