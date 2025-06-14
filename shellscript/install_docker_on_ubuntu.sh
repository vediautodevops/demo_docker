#!/bin/bash
# Author: VED’IAUTODEVOPS
# License: MIT License
# Description: 
# The install_docker.sh script install docker on Ubuntu.
# This script may fail if GPG or the repositories are not available.

# Copyright (c) 2025 VED’IAUTODEVOPS
# This script is released under the MIT License.

# Following step to run docker without sudo
# Create the docker group (if it doesn't exist)
# Command: "sudo groupadd docker"
# Add your user to the docker group
# Command: "sudo usermod -aG docker $USER"
# Apply the group change by logging out & back in
# Logout from your terminal/session (or restart your machine if unsure).
# This reloads your user group permissions.
# Command: "newgrp docker"
# Test without sudo
# Command: "docker ps"


#!/bin/bash
set -e

echo "🚀 Starting Docker installation..."

# Function to check command status
check_status() {
  if [ $? -ne 0 ]; then
    echo "❌ ERROR: $1"
    exit 1
  fi
}

# 1. Update existing packages
sudo apt update || check_status "Failed to update packages"

# 2. Install required packages
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y || check_status "Failed to install required packages"

# 3. Add Docker’s GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg || check_status "Failed to add Docker GPG key"

# 4. Add Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null || check_status "Failed to add Docker repository"

# 5. Update package index with Docker repo
sudo apt update || check_status "Failed to update package index with Docker repo"

# 6. Install Docker Engine
sudo apt install docker-ce docker-ce-cli containerd.io -y || check_status "Failed to install Docker Engine"

# 7. Enable & start Docker
sudo systemctl enable docker || check_status "Failed to enable Docker service"
sudo systemctl start docker || check_status "Failed to start Docker service"

# 8. Verify installation
sudo docker --version || check_status "Docker installation verification failed"

echo "✅ Docker installed successfully!"

