# Configuração Manual da Zona (CloudStack)

Este guia acompanha passo-a-passo a configuração da zona "Advanced" via UI.

## 1. Public Traffic (Tráfego Público) (Concluído)

*   **Gateway**: `10.0.50.1`
*   **Netmask**: `255.255.255.0`
*   **VLAN/VNI**: `50`
*   **Start IP**: `10.0.50.100`
*   **End IP**: `10.0.50.200`

![Configuração de Public Traffic](file:///home/matheus/.gemini/antigravity/brain/a1f1e03e-d0d2-40c8-9194-f70de4919bf3/uploaded_image_1768217573593.png)

---

## 2. Pod Configuration (Pod) (Concluído)

*   **Pod name**: `Pod1`
*   **Reserved system gateway**: `10.0.30.1`
*   **Reserved system netmask**: `255.255.255.0`
*   **Start reserved system IP**: `10.0.30.200`
*   **End reserved system IP**: `10.0.30.210`

![Configuração do Pod](file:///home/matheus/.gemini/antigravity/brain/a1f1e03e-d0d2-40c8-9194-f70de4919bf3/uploaded_image_1768217682099.png)

---

## 3. Guest Traffic (Guest VNI/VLAN Range) (Concluído)

*   **Start VLAN/VNI**: `100`
*   **End VLAN/VNI**: `110`

![Configuração de Guest Traffic](file:///home/matheus/.gemini/antigravity/brain/a1f1e03e-d0d2-40c8-9194-f70de4919bf3/uploaded_image_1768217736880.png)

---

## 4. Storage Traffic (Concluído)

*   **Gateway**: `10.0.40.1`
*   **Netmask**: `255.255.255.0`
*   **VLAN/VNI**: `40`
*   **Start IP**: `10.0.40.100`
*   **End IP**: `10.0.40.150`

![Configuração de Storage Traffic](file:///home/matheus/.gemini/antigravity/brain/a1f1e03e-d0d2-40c8-9194-f70de4919bf3/uploaded_image_1768218040954.png)

---

## 5. Add Resources (Host) (Concluído)

*   **Host name**: `10.0.30.254`
*   **Username**: `root`
*   **Password**: `matheus`

![Configuração de Host](file:///home/matheus/.gemini/antigravity/brain/a1f1e03e-d0d2-40c8-9194-f70de4919bf3/uploaded_image_1768218126621.png)

---

## 6. Primary Storage

Esta etapa configura onde os DISCOS das VMs (Root Volumes) serão armazenados. Usaremos o compartilhamento NFS do TrueNAS.

*   **Name**: `Primary1`
*   **Scope**: `Zone-wide` (Importante para permitir migração entre clusters no futuro e uso simplificado)
*   **Protocol**: `NFS`
*   **Provider**: `DefaultPrimary`
*   **Server**: `10.0.40.10`
*   **Path**: `/mnt/pool_primary/primary`

*(Deixe "Storage Tags" em branco no momento)*

![Configuração de Primary Storage](file:///home/matheus/.gemini/antigravity/brain/a1f1e03e-d0d2-40c8-9194-f70de4919bf3/uploaded_image_1768218176041.png)

Clique em **Next**.

---

## Próximos Passos (Previstos)

### 7. Secondary Storage
*   **Provider**: `NFS`
*   **Server**: `10.0.40.10`
*   **Path**: `/mnt/pool_secondary/secondary`
