#!/bin/bash

# Update package index
sudo apt-get update

# Architecture Detection
ARCH=$(uname -m)
case $ARCH in
    x86_64)  ARCH_TYPE="amd64" ;;
    aarch64) ARCH_TYPE="arm64" ;;
    *)       echo "❌ Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Check for existing installation
if command -v docker &> /dev/null; then
    echo "✅ Docker is already installed."
else
    echo "Installing Docker & Compose for $ARCH_TYPE..."

    # Install prerequisites
    sudo apt-get install -y ca-certificates curl gnupg

    # Add Docker's official GPG key
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    # Set up the repository
    echo \
      "deb [arch=$ARCH_TYPE signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Install Docker Engine and Compose Plugin
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # Fix: Start and Enable Daemon
    echo "Starting Docker Daemon..."
    sudo systemctl enable docker
    sudo systemctl start docker
fi

# FIX: Solve Permission Denied (Socket Access)
echo "Configuring permissions..."

# Create group if it doesn't exist and add current user
sudo groupadd -f docker
sudo usermod -aG docker $USER

# Change ownership of the docker socket as a fallback
sudo chown root:docker /var/run/docker.sock

echo "------------------------------------------------------"
echo "Docker installation and permission fix applied!"
echo "IMPORTANT: Run the command below to use Docker immediately:"
echo "     newgrp docker"
echo "------------------------------------------------------"

# Testing the fix
echo "Testing docker ps..."
sg docker -c "docker ps"