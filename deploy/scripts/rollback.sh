#!/bin/bash
# deploy/scripts/rollback.sh

VERSION=${1:-previous_stable}

echo "🔄 Iniciando rollback a versión $VERSION"

docker-compose stop mechbot-app
docker-compose rm -f mechbot-app
docker-compose pull mechbot-app:$VERSION
docker-compose up -d mechbot-app

echo "⏮️ Rollback completado a v$VERSION"
