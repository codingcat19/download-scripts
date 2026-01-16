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

# Install ArgoCD CLI (Local)
if command -v argocd &> /dev/null; then
    echo "✅ ArgoCD CLI is already installed."
else
    echo "Installing ArgoCD CLI for $ARCH_TYPE..."
    curl -sSL -o argocd-linux-$ARCH_TYPE https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-$ARCH_TYPE
    sudo install -m 555 argocd-linux-$ARCH_TYPE /usr/local/bin/argocd
    rm argocd-linux-$ARCH_TYPE
fi

# Install ArgoCD into the Kubernetes Cluster
if kubectl get namespace argocd &> /dev/null; then
    echo "✅ ArgoCD is already running in the cluster."
else
    echo "Deploying ArgoCD to Kubernetes cluster..."
    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    
    echo "Waiting for ArgoCD pods to be ready..."
    kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server -n argocd --timeout=300s
fi

# Get Initial Admin Password
PASS=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo "------------------------------------------------------"
echo "ArgoCD Installation Complete!"
echo "Access the UI by running: kubectl port-forward svc/argocd-server -n argocd 8081:443"
echo "Username: admin"
echo "Password: $PASS"
echo "------------------------------------------------------"