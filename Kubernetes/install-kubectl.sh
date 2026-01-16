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
if command -v kubectl &> /dev/null; then
    echo "✅ kubectl is already installed."
    kubectl version --client
    exit 0
fi

echo "🚀 Installing kubectl for $ARCH_TYPE..."

# Download the latest stable binary
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$ARCH_TYPE/kubectl"

# Install the binary
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Cleanup
rm kubectl

echo "------------------------------------------------------"
echo "🎉 kubectl installed successfully!"
kubectl version --client
echo "------------------------------------------------------"