#!/bin/bash

echo "Removing kubectl..."
sudo rm -f /usr/local/bin/kubectl

# Optional: Remove the kube config directory
# rm -rf ~/.kube

echo "✅ kubectl has been removed."