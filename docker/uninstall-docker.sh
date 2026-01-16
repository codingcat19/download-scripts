#!/bin/bash

echo "Uninstalling Docker and cleaning up..."

# 1. Stop services
sudo systemctl stop docker.socket || true
sudo systemctl stop docker || true

# 2. Uninstall packages
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

# 3. Remove directories and configs
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
sudo rm -f /etc/apt/sources.list.d/docker.list
sudo rm -f /etc/apt/keyrings/docker.gpg

# 4. Remove Docker group
sudo groupdel docker || true

echo "Docker has been completely removed."