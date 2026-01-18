#!/bin/bash

echo "Uninstalling Terraform..."

# Remove the package
sudo apt-get purge -y terraform

# Remove the repository and GPG key
sudo rm -f /etc/apt/sources.list.d/hashicorp.list
sudo rm -f /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Clean up apt cache
sudo apt-get update

echo "✅ Terraform has been completely removed."