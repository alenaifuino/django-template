FROM registry.access.redhat.com/ubi8/python-39:latest

LABEL Author=Alejandro\ Naifuino\
    e-mail="alenaifuino@gmail.com" \
    version="0.9.2"

# Keep Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turn off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

# Define the non-root user that will run the container
ARG NONROOT_USER=default

# Switch to the root user
USER root

# Set the working directory
WORKDIR /app

# Copy the application content
COPY . /app

# Upgrade pip and install required Python modules
COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir wheel && \
    python3 -m pip install --no-cache-dir -r requirements.txt

# Remove not required packages, install security updates and NGINX, clean the cache, and fix file permissions
RUN dnf --disableplugin=subscription-manager -y remove gcc httpd git vim-minimal && \
    dnf --disableplugin=subscription-manager -y update-minimal --security && \
    dnf --disableplugin=subscription-manager -y module install nginx:1.18 && \
    dnf --disableplugin=subscription-manager clean all && \
    rm -rf /var/cache/yum && \
    chown -R $NONROOT_USER:0 /app && \
    fix-permissions /app -P && \
    chmod +x start-server.sh && \
    rpm-file-permissions

# Copy NGINX configuration
COPY nginx.conf /etc/nginx/

# Downgrade to $NONROOT_USER user
USER $NONROOT_USER

# Expose NGINX Web Server port
EXPOSE 8020
STOPSIGNAL SIGTERM

# Migrate Django DB, create superuser, and start the web server
CMD ./start-server.sh
