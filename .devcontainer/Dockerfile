# Use the latest Ubuntu LTS version (Ubuntu 22.04 Jammy)
FROM ubuntu:22.04

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    unzip \
    gnupg \
    software-properties-common \
    bash \
    lsb-release \
    ca-certificates && \
    
    # Install AWS CLI
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && ./aws/install && \
    
    # Install Terraform
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt update && apt install terraform -y && \
    
    # Install GitHub CLI
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg && \
    chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
    apt update && apt install gh -y && \
    
    # Clean up
    rm -rf /var/lib/apt/lists/* awscliv2.zip aws

# Set default working directory
WORKDIR /workspaces/${REPO_NAME}

# Set the default shell to bash
SHELL ["/bin/bash", "-c"]
