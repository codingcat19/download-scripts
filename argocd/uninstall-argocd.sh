#!/bin/bash

echo "🗑️  Uninstalling ArgoCD..."

# Remove from Kubernetes
if kubectl get namespace argocd &> /dev/null; then
    echo "Deleting ArgoCD namespace and resources..."
    kubectl delete namespace argocd
else
    echo "ArgoCD namespace not found in cluster."
fi

# Remove CLI binary
if command -v argocd &> /dev/null; then
    echo "Removing ArgoCD CLI binary..."
    sudo rm -f /usr/local/bin/argocd
else
    echo "ArgoCD CLI not found."
fi

echo "✅ ArgoCD cleanup complete."