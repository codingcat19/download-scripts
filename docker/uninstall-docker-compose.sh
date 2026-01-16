#!/bin/bash

echo "Removing Docker Compose V2 plugin..."

DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}

if [ -f "$DOCKER_CONFIG/cli-plugins/docker-compose" ]; then
    rm "$DOCKER_CONFIG/cli-plugins/docker-compose"
    echo "✅ Docker Compose plugin removed from $DOCKER_CONFIG/cli-plugins/"
else
    # Also check the system-wide path if it was installed via apt
    sudo apt-get purge -y docker-compose-plugin
    echo "✅ Docker Compose plugin purged."
fi