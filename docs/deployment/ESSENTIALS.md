# **Documentación Esencial para Despliegue - MechBot 2.0x**
`DEPLOYMENT_ESSENTIALS.md` | Ubicación: `/docs/deployment/ESSENTIALS.md`

## **1. Despliegue en Edge (Dispositivos Vehiculares)**

### **1.1 Flasheo de Firmware**
```bash
# Comando completo para flasheo seguro
./deploy_firmware.sh \
  --target=jetson-agx-orin \
  --image=firmware_v2.1.8.signed.img \
  --verify-signature \
  --backup=create
```

**Archivos clave**:
📌 [Guía de Recuperación](/docs/deployment/EDGE_RECOVERY.md)
📌 [Checklist Pre-Despliegue](/checklists/pre_deployment_edge.csv)

## **2. Despliegue en Cloud (Kubernetes)**

### **2.1 Instalación con Helm**
```bash
# Despliegue completo con valores específicos
helm upgrade --install mechbot-core \
  ./charts/core \
  -f ./values/prod/values.yaml \
  -f ./values/prod/secrets.enc.yaml \
  --namespace production \
  --atomic \
  --timeout 15m \
  --set "cluster.env=prod"
```

### **2.2 Configuración de Alta Disponibilidad**
```yaml
# high_availability.yaml
podDisruptionBudget:
  maxUnavailable: 1
topologySpreadConstraints:
  - maxSkew: 1
    topologyKey: topology.kubernetes.io/zone
    whenUnsatisfiable: DoNotSchedule
```

## **3. Configuración de Red Crítica**

### **3.1 Políticas de Red**
```bash
# Aplicar NetworkPolicies
kubectl apply -f ./network/policies/prod/
```

### **3.2 Configuración CAN Bus**
```bash
# Configurar interfaz CAN FD
ip link set can0 up type can \
  bitrate 5000000 dbitrate 20000000 \
  fd on sample-point 0.75
```

## **4. Verificación Post-Despliegue**

### **4.1 Checks Automatizados**
```bash
# Ejecutar suite de verificación
make deployment-check \
  ENV=prod \
  CHECK_TYPE=full
```

### **4.2 Monitorización Inicial**
```bash
# Verificar métricas clave
kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes | \
  jq '.items[] | {name: .metadata.name, cpu: .usage.cpu, memory: .usage.memory}'
```

## **5. Documentación Relacionada**

| Documento | Ubicación | Comando Acceso |
|-----------|-----------|----------------|
| Troubleshooting | `/docs/deployment/TROUBLESHOOTING.md` | `make docs-troubleshoot` |
| Escalado Automático | `/docs/deployment/AUTOSCALING.md` | `helm-docs autoscaling` |
| Backup/Restore | `/docs/deployment/DISASTER_RECOVERY.md` | `vault-docs recovery` |

## **6. Comandos de Emergencia**

```bash
# Rollback completo
make rollback \
  DEPLOY_ID=$(helm history mechbot-core -o json | jq -r '.[-2].revision') \
  REASON="emergency_rollback"

# Aislar nodo problemático
kubectl cordon NODE_NAME && \
kubectl drain NODE_NAME --ignore-daemonsets --delete-emptydir-data
```

**Equipo de Despliegue**:
📞 *Soporte 24/7: deployment-support@mechbot.tech*
🚨 *Código de Emergencia: #DEPLOY-RED-ALERT*

```bash
# Verificar integridad del despliegue
cosign verify --key ./.cosign.pub \
  $(helm get notes mechbot-core -n production | grep "Image Digest" | cut -d: -f2-)
```

*Última actualización: 2025-07-20 - Versión 2.1.8-stable*

> 🔐 **Nota de Seguridad**: Todos los comandos requieren autenticación MFA y registro en el sistema de auditoría.
