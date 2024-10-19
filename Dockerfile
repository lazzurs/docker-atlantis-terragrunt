FROM ghcr.io/runatlantis/atlantis:v0.30.0

ARG terragrunt_version=v0.68.4
ARG terragrunt_atlantis_config=1.19.0

# Set bash settings
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root
# Update all the things
RUN apk upgrade

# Terragrunt related configuration
COPY config/repos.yaml /usr/local/etc/repos.yaml

# Install Terragrunt
RUN curl -L -s --output /usr/local/bin/terragrunt "https://github.com/gruntwork-io/terragrunt/releases/download/${terragrunt_version}/terragrunt_linux_amd64" &&\
    chmod +x /usr/local/bin/terragrunt

# Install jq, useful for Terraform external datasource
RUN apk add jq --no-cache

# Terragrunt Atlantis Config install
RUN \
  curl -s -L --output /usr/local/bin/terragrunt-atlantis-config "https://github.com/transcend-io/terragrunt-atlantis-config/releases/download/v${terragrunt_atlantis_config}/terragrunt-atlantis-config_${terragrunt_atlantis_config}_linux_amd64"  &&\
  chmod +x /usr/local/bin/terragrunt-atlantis-config

# Clean up package cache
RUN rm -rf /var/cache/apk/*

# Switch back to atlantis user
USER atlantis
CMD ["server"]
