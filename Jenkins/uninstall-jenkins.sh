#!/bin/bash

echo "Uninstalling Jenkins..."

# Stop Jenkins service
sudo systemctl stop jenkins
sudo systemctl disable jenkins

# Remove Jenkins package
sudo apt-get purge -y jenkins

# Remove directories and repository files
sudo rm -rf /var/lib/jenkins
sudo rm -rf /etc/jenkins
sudo rm -f /etc/apt/sources.list.d/jenkins.list
sudo rm -f /usr/share/keyrings/jenkins-keyring.asc

# Optional: Remove Java (Uncomment if you want to remove Java too)
sudo apt-get purge -y openjdk-17-jre # Comment this line if you don't want to uninstall jdk

echo "✅ Jenkins has been completely removed."