#!/bin/bash
set -e
DOCKER_CONTAINER_NAME="your-container"
BACKUP_DIR="./backup"
ROLLBACK_IMAGE="your-app:rollback"

if [ ! -f "$BACKUP_DIR/your-app.war" ]; then
    echo "No backup WAR file found. Exiting."
    exit 1
fi

docker stop "$DOCKER_CONTAINER_NAME" || true
docker rm "$DOCKER_CONTAINER_NAME" || true
docker build -t "$ROLLBACK_IMAGE" -f Dockerfile.rollback .
docker run -d --name "$DOCKER_CONTAINER_NAME" -p 8080:80 "$ROLLBACK_IMAGE"
echo "Rollback completed successfully."
