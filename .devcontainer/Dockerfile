FROM registry.access.redhat.com/ubi8/python-39:latest

LABEL Author=Alejandro\ Naifuino\
    e-mail="alenaifuino@gmail.com" \
    version="1.0.1"

# Keep Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turn off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Define the non-root user that will run the container
ARG NONROOT_USER=default

# Set Docker GID
ARG DOCKER_GID=1001

# Switch to the root user
USER root

# Create docker group with same GID as in the host OS, then set bash shell, and
# add the $NONROOT_USER to the 'docker' group
RUN groupadd -r --gid $DOCKER_GID docker && \
    usermod --shell /bin/bash --append --group docker $NONROOT_USER

# Set the working directory
WORKDIR /app

# Upgrade pip and install required Python modules
COPY requirements.dev.txt .
RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir wheel && \
    python3 -m pip install --no-cache-dir -r requirements.dev.txt

# Remove not required packages, update and upgrade packages, install Docker CE CLI, and clean yum cache
RUN yum --disableplugin=subscription-manager -y remove gcc httpd vim-minimal && \
    yum --disableplugin=subscription-manager -y update-minimal --security && \
    yum --disableplugin=subscription-manager -y install yum-utils && \
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && \
    yum --disableplugin=subscription-manager -y install docker-ce-cli && \
    yum --disableplugin=subscription-manager clean all && \
    rm -rf /var/cache/yum && \
    fix-permissions /app -P && \
    rpm-file-permissions

# Install latest Docker Compose version
RUN export LCV=$(curl -sSL "https://api.github.com/repos/docker/compose/releases/latest" | grep -o -P '(?<="tag_name": ").+(?=")') && \
    curl -sSL "https://github.com/docker/compose/releases/download/${LCV}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Downgrade to {NONROOT_USER} user
USER $NONROOT_USER

# Expose Django and Livereload server ports
EXPOSE 8000
EXPOSE 35729
