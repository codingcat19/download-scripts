#!/bin/bash

# Update package index
sudo apt-get update

# Check for existing installation
if command -v jenkins &> /dev/null; then
    echo "✅ Jenkins is already installed."
    jenkins --version
    exit 0
fi

echo "Installing Jenkins and Java Dependency..."

# Install Java (Jenkins requires Java to run)
sudo apt-get install -y fontconfig openjdk-17-jre

# Add Jenkins GPG Key
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add Jenkins Repository
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
sudo apt-get update
sudo apt-get install -y jenkins

# Start and Enable Jenkins
echo "🔧 Starting Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Output the Initial Admin Password
echo "------------------------------------------------------"
echo "Jenkins installed successfully!"
echo "Access it at: http://localhost:8080"
echo "Your Initial Admin Password is:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo "------------------------------------------------------"