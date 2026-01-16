#!/bin/bash

# Update package index
sudo apt-get update

# Check for existing installation
if command -v helm &> /dev/null; then
    echo "✅ Helm is already installed."
    helm version --short
    exit 0
fi

echo "🚀 Installing Helm (The Kubernetes Package Manager)..."

# Install prerequisites
sudo apt-get install -y curl

# Run the official Helm installation script
curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

echo "------------------------------------------------------"
echo "Helm installed successfully!"
helm version
echo "------------------------------------------------------"