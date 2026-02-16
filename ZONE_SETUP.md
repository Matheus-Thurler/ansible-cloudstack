# Configuração Manual da Zona (CloudStack)

Este guia acompanha passo-a-passo a configuração da zona "Advanced" via UI.

## 1. Tráfego Público (Public Traffic) (Concluído)

*   **Gateway**: `10.0.50.1`
*   **Máscara de Rede**: `255.255.255.0`
*   **VLAN/VNI**: `50`
*   **IP Inicial**: `10.0.50.100`
*   **IP Final**: `10.0.50.200`

![Configuração de Public Traffic](file:///home/matheus/.gemini/antigravity/brain/a1f1e03e-d0d2-40c8-9194-f70de4919bf3/uploaded_image_1768217573593.png)

---

## 2. Configuração do Pod (Pod Configuration) (Concluído)

*   **Nome do Pod**: `Pod1`
*   **Gateway do Sistema Reservado**: `10.0.30.1`
*   **Máscara de Rede do Sistema Reservado**: `255.255.255.0`
*   **IP Inicial do Sistema Reservado**: `10.0.30.200`
*   **IP Final do Sistema Reservado**: `10.0.30.210`

![Configuração do Pod](file:///home/matheus/.gemini/antigravity/brain/a1f1e03e-d0d2-40c8-9194-f70de4919bf3/uploaded_image_1768217682099.png)

---

## 3. Tráfego de Convidados (Guest Traffic) (Concluído)

*   **VLAN/VNI Inicial**: `100`
*   **VLAN/VNI Final**: `110`

![Configuração de Guest Traffic](file:///home/matheus/.gemini/antigravity/brain/a1f1e03e-d0d2-40c8-9194-f70de4919bf3/uploaded_image_1768217736880.png)

---

## 4. Tráfego de Armazenamento (Storage Traffic) (Concluído)

*   **Gateway**: `10.0.40.1`
*   **Máscara de Rede**: `255.255.255.0`
*   **VLAN/VNI**: `40`
*   **IP Inicial**: `10.0.40.100`
*   **IP Final**: `10.0.40.150`

![Configuração de Storage Traffic](file:///home/matheus/.gemini/antigravity/brain/a1f1e03e-d0d2-40c8-9194-f70de4919bf3/uploaded_image_1768218040954.png)

---

## 5. Adicionar Recursos (Add Resources - Host) (Concluído)

*   **Nome do Host**: `10.0.30.254`
*   **Usuário**: `root`
*   **Senha**: `matheus`

![Configuração de Host](file:///home/matheus/.gemini/antigravity/brain/a1f1e03e-d0d2-40c8-9194-f70de4919bf3/uploaded_image_1768218126621.png)

---

## 6. Armazenamento Primário (Primary Storage)

Esta etapa configura onde os DISCOS das VMs (Root Volumes) serão armazenados. Usaremos o compartilhamento NFS do TrueNAS.

*   **Nome**: `Primary1`
*   **Escopo**: `Zone-wide` (Importante para permitir migração entre clusters no futuro e uso simplificado)
*   **Protocolo**: `NFS`
*   **Provedor**: `DefaultPrimary`
*   **Servidor**: `10.0.40.10`
*   **Caminho**: `/mnt/pool_primary/primary`

*(Deixe "Tags de Armazenamento" em branco no momento)*

![Configuração de Primary Storage](file:///home/matheus/.gemini/antigravity/brain/a1f1e03e-d0d2-40c8-9194-f70de4919bf3/uploaded_image_1768218176041.png)

Clique em **Próximo (Next)**.

---

## Próximos Passos (Previstos)

### 7. Armazenamento Secundário (Secondary Storage)
*   **Provedor**: `NFS`
*   **Servidor**: `10.0.40.10`
*   **Caminho**: `/mnt/pool_secondary/secondary`
