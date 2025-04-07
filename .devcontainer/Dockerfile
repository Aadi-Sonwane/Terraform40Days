# Use a base image. Choose one that suits your needs.
FROM ubuntu:latest

# Set environment variables (optional)
ENV DEBIAN_FRONTEND=noninteractive
ENV CONTAINER_USER=vscode 
# Install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Common tools
    curl \
    wget \
    zip \
    unzip \
    git \
    gnupg \
    software-properties-common \
    # Python and pip (if needed)
    python3 \
    python3-pip \
    # Other tools you might need

# Install Terraform
RUN apt-get update && apt-get install -y --no-install-recommends
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt-get update && apt-get install -y terraform

# Install AWS CLI
RUN apt-get update && apt-get install -y --no-install-recommends awscli

# Install other custom tools or dependencies here
# Example: Install Node.js
# RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
# RUN apt-get install -y nodejs

# Create a non-root user (default for Codespaces)
RUN groupadd --gid 1000 $CONTAINER_USER
RUN useradd --uid 1000 --gid 1000 -ms /bin/bash $CONTAINER_USER

# Set the user for subsequent commands
USER $CONTAINER_USER

# Set the working directory (optional)
WORKDIR /home/$CONTAINER_USER/app

# You can copy files into the image if needed
# COPY . /home/$CONTAINER_USER/app

# Define any entrypoint or command if required
# ENTRYPOINT ["/bin/bash"]
# CMD ["echo", "Custom Codespace Container"]