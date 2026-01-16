#!/bin/bash

echo "Removing Helm..."
sudo rm -f /usr/local/bin/helm

# Optional: Remove helm cache and config
# rm -rf ~/.cache/helm
# rm -rf ~/.config/helm

echo "✅ Helm has been removed."