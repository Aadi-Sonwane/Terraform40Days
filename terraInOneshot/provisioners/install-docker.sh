#!/bin/bash
set -e
set -x

# Update and install Docker
sudo apt-get update -y
sudo apt-get install -y docker.io
sudo apt-get update -y

# Add user to docker group (if $USER is unset)
sudo usermod -aG docker "$USER" || sudo usermod -aG docker ubuntu

# Do NOT use newgrp here — it won't affect Terraform sessions
