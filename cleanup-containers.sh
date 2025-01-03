#!/bin/bash
set -e
DOCKER_CONTAINER_NAME="your-container"
DOCKER_NETWORK_NAME="your-network"

docker ps -a | grep "$DOCKER_CONTAINER_NAME" | awk '{print $1}' | xargs --no-run-if-empty docker stop
docker ps -a | grep "$DOCKER_CONTAINER_NAME" | awk '{print $1}' | xargs --no-run-if-empty docker rm
docker network ls | grep "$DOCKER_NETWORK_NAME" | awk '{print $1}' | xargs --no-run-if-empty docker network rm
echo "Old containers and networks cleaned."
