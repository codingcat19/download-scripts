#!/bin/bash

echo "Uninstalling Prometheus and Grafana..."

# Uninstall the Helm release
helm uninstall monitoring -n monitoring

# Remove the namespace
kubectl delete namespace monitoring

# Cleanup Helm repo (optional)
helm repo remove prometheus-community

echo "✅ Monitoring stack has been removed."