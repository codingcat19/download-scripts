#!/bin/bash

echo "Deleting Minikube cluster and binary..."
minikube delete
sudo rm -f /usr/local/bin/minikube
rm -rf ~/.minikube
rm -rf ~/.kube
echo "✅ Minikube has been removed."