#!/bin/bash

# Update package index
sudo apt-get update

# Check prerequisites
if ! command -v helm &> /dev/null; then
    echo "❌ Error: Helm is not installed. Please run helm.sh first."
    exit 1
fi

echo "Installing Prometheus and Grafana via Helm..."

# Add the Prometheus Community Helm repository
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Install the stack into a 'monitoring' namespace
if kubectl get namespace monitoring &> /dev/null; then
    echo "✅ Monitoring namespace already exists."
else
    kubectl create namespace monitoring
fi

# Deploy the stack
# We use 'kube-prometheus-stack' because it sets up both tools together
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack \
  --namespace monitoring

echo "Waiting for Monitoring pods to be ready (this may take 2-3 minutes)..."
kubectl wait --for=condition=ready pod -l release=monitoring -n monitoring --timeout=300s

# Get Grafana Admin Password
# The default user is 'admin'
GRAFANA_PASS=$(kubectl get secret --namespace monitoring monitoring-grafana -o jsonpath="{.data.admin-password}" | base64 --decode)

echo "------------------------------------------------------"
echo "Monitoring Stack (Prometheus & Grafana) is Ready!"
echo ""
echo "To access Grafana UI:"
echo "  1. Run: kubectl port-forward deployment/monitoring-grafana -n monitoring 3000:3000"
echo "  2. Open: http://localhost:3000"
echo "  3. User: admin | Password: $GRAFANA_PASS"
echo ""
echo "To access Prometheus UI:"
echo "  1. Run: kubectl port-forward svc/monitoring-kube-prometheus-prometheus -n monitoring 9090:9090"
echo "  2. Open: http://localhost:9090"
echo "------------------------------------------------------"