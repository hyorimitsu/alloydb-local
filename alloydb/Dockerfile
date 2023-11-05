FROM debian:12.1

# asia | europe | us
ENV REGION=asia
ENV DATA_DIR=/data

# Install sudo
RUN apt-get update && apt-get install sudo

# Install dependencies
RUN sudo apt-get update && \
    sudo apt-get -y install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Install docker
RUN sudo mkdir -m 0755 -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    sudo apt-get update && \
    sudo apt-get -y install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# Install alloydb-cli
RUN curl https://${REGION}-apt.pkg.dev/doc/repo-signing-key.gpg | sudo apt-key add - && \
    sudo apt-get update && \
    echo "deb https://${REGION}-apt.pkg.dev/projects/alloydb-omni alloydb-omni-apt main" | sudo tee -a /etc/apt/sources.list.d/artifact-registry.list && \
    sudo apt-get update && \
    sudo apt-get -y install alloydb-cli

WORKDIR $DATA_DIR

# Install AlloyDB Omni server software
RUN sudo alloydb database-server install --data-dir=${DATA_DIR}

# Launch AlloyDB Omni
CMD ["sudo", "alloydb", "database-server", "start"]
