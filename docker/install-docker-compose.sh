#!/bin/bash

# Update package index
sudo apt-get update

# Architecture Detection
ARCH=$(uname -m)
case $ARCH in
    x86_64)  ARCH_TYPE="x86_64" ;;
    aarch64) ARCH_TYPE="aarch64" ;;
    *)       echo "❌ Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Check for existing installation (Docker Compose V2)
# We check 'docker compose version' because 'docker-compose' is the V1 binary
if docker compose version &> /dev/null; then
    echo "Docker Compose (V2) is already installed."
    docker compose version
    exit 0
fi

# Check if Docker is installed first
if ! command -v docker &> /dev/null; then
    echo "❌ Error: Docker Engine is not installed. Please install Docker first."
    exit 1
fi

echo "🚀 Installing Docker Compose V2 for $ARCH_TYPE..."

# Create the CLI plugins directory
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins

# Download the latest binary from GitHub
COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K[^"]*')

curl -SL "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-linux-${ARCH_TYPE}" -o $DOCKER_CONFIG/cli-plugins/docker-compose

# Apply permissions
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

echo "------------------------------------------------------"
echo "Docker Compose V2 installed successfully!"
echo "Usage: Use 'docker compose' (no hyphen)"
docker compose version
echo "------------------------------------------------------"