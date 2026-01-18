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
if command -v terraform &> /dev/null; then
    echo "✅ Terraform is already installed."
    terraform --version
    exit 0
fi

echo "Installing Terraform for $ARCH_TYPE..."

# Install dependencies
sudo apt-get install -y gnupg software-properties-common curl

# Add HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | \
sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add the official HashiCorp Linux repository
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

# Install Terraform
sudo apt-get update
sudo apt-get install -y terraform

echo "------------------------------------------------------"
echo "Terraform installed successfully!"
terraform --version
echo "------------------------------------------------------"