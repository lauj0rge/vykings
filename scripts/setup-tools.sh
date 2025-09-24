#!/bin/bash

echo "=== Updating system ==="
sudo apt update && sudo apt upgrade -y

echo "=== Installing basic packages ==="
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release git vim software-properties-common

# -------------------------
# Docker
# -------------------------
echo "=== Installing Docker ==="
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker $USER

# -------------------------
# kubectl
# -------------------------
echo "=== Installing kubectl v1.33.5 ==="
curl -LO "https://dl.k8s.io/release/v1.33.5/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# -------------------------
# k3d
# -------------------------
echo "=== Installing k3d ==="
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# -------------------------
# Helm
# -------------------------
echo "=== Installing Helm ==="
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# -------------------------
# Terraform
# -------------------------
echo "=== Installing Terraform ==="
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install -y terraform

echo "=== Setup complete. Please log out and back in (or run 'newgrp docker') to use Docker as non-root. ==="
