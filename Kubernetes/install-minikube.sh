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
if command -v minikube &> /dev/null; then
    echo "✅ Minikube is already installed."
else
    echo "🚀 Installing Minikube for $ARCH_TYPE..."
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-$ARCH_TYPE
    sudo install minikube-linux-$ARCH_TYPE /usr/local/bin/minikube
    rm minikube-linux-$ARCH_TYPE
fi

# Start Minikube (Uses Docker as the driver)
echo "🎬 Starting your local Kubernetes cluster..."
# Note: We use 'sg docker' to avoid permission issues if the user hasn't rebooted
sg docker -c "minikube start --driver=docker"

echo "------------------------------------------------------"
echo "🎉 Minikube is up and running!"
echo "Try running: kubectl get nodes"
echo "------------------------------------------------------"