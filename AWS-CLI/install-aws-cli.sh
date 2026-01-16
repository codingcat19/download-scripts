#!/bin/bash

# Update package index
sudo apt-get update

# Architecture Detection
ARCH=$(uname -m)
# AWS uses x86_64 or aarch64 directly in their download URLs
if [[ "$ARCH" != "x86_64" && "$ARCH" != "aarch64" ]]; then
    echo "❌ Unsupported architecture: $ARCH"
    exit 1
fi

# Check for existing installation
if command -v aws &> /dev/null; then
    echo "✅ AWS CLI is already installed."
    aws --version
    exit 0
fi

echo "Installing Latest AWS CLI v2 for $ARCH..."

# Install unzip if not present
sudo apt-get install -y unzip curl

# Download the latest AWS CLI bundle
curl "https://awscli.amazonaws.com/awscli-exe-linux-$ARCH.zip" -o "awscliv2.zip"

# Unzip and Install
unzip -q awscliv2.zip
sudo ./aws/install

# Cleanup
rm -rf aws awscliv2.zip

echo "------------------------------------------------------"
echo "AWS CLI v2 installed successfully!"
aws --version
echo "Run 'aws configure' to set up your credentials."
echo "------------------------------------------------------"