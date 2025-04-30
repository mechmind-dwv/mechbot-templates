#!/bin/bash
# deploy/scripts/deploy.sh

ENVIRONMENT=${1:-staging}
VERSION=${2:-latest}

echo "🚀 Iniciando despliegue en $ENVIRONMENT"

# Validar variables
if [ -z "$DOCKER_REGISTRY" ]; then
  echo "❌ Error: DOCKER_REGISTRY no está definido"
  exit 1
fi

# Descargar configuración
wget -O configs/env.$ENVIRONMENT https://config.mechbot.com/$ENVIRONMENT/env

# Procesar plantillas
envsubst < deploy/templates/docker-compose.yml > docker-compose.$ENVIRONMENT.yml

# Ejecutar despliegue
docker-compose -f docker-compose.$ENVIRONMENT.yml pull
docker-compose -f docker-compose.$ENVIRONMENT.yml up -d --force-recreate

echo "✅ Despliegue completado para v$VERSION en $ENVIRONMENT"
