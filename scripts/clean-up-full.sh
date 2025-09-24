#!/bin/bash
set -euo pipefail

echo "=== 🚨 EMERGENCY DISK CLEANUP ==="

# 1. Stop and delete the current cluster
echo "Stopping and deleting k3d cluster..."
k3d cluster stop vyking-dev 2>/dev/null || true
k3d cluster delete vyking-dev 2>/dev/null || true

# 2. Nuclear option: Clean ALL Docker resources
echo "Cleaning ALL Docker resources..."
docker system prune -a -f --volumes
docker container prune -f
docker image prune -a -f
docker volume prune -f
docker network prune -f
docker builder prune -a -f

# 3. Clean k3d specific files
echo "Cleaning k3d leftover files..."
sudo rm -rf /tmp/k3d/* 2>/dev/null || true
sudo rm -rf /var/lib/rancher/k3s/ 2>/dev/null || true

# 4. Clean system packages and logs
echo "Cleaning system packages and logs..."
sudo apt autoremove -y
sudo apt clean
sudo journalctl --vacuum-time=1d
sudo rm -rf /var/log/journal/* 2>/dev/null || true

# 5. Clean temporary files
echo "Cleaning temporary files..."
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
sudo rm -rf ~/.cache/*

# 6. Check current disk usage
echo "=== 📊 CURRENT DISK USAGE ==="
df -h /

# 7. Show largest directories
echo "=== 📁 LARGEST DIRECTORIES ==="
sudo du -sh /var/lib/docker/* 2>/dev/null | sort -rh | head -10 || true
sudo du -sh ~/* 2>/dev/null | sort -rh | head -10 || true
