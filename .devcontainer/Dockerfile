# Use Ubuntu 24.04 base image
FROM ubuntu:24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV CONTAINER_USER=vscode

# Install essential dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    ca-certificates \
    gnupg \
    software-properties-common \
    zip \
    unzip \
    lsb-release \
    python3 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip safely
RUN pip3 install --break-system-packages --upgrade pip

# Install AWS CLI using pip
RUN pip3 install --break-system-packages awscli

# Install Terraform using HashiCorp APT repo
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && apt-get install -y terraform && \
    terraform -install-autocomplete

# Create the non-root user
RUN groupadd --gid 1000 $CONTAINER_USER && \
    useradd --uid 1000 --gid 1000 -ms /bin/bash $CONTAINER_USER

# Use non-root user going forward
USER $CONTAINER_USER

# Set working directory
WORKDIR /home/$CONTAINER_USER/app

# Default CMD (keep container alive)
CMD ["sleep", "infinity"]
