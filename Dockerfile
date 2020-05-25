FROM runatlantis/atlantis:latest

ARG terragrunt_version=v0.23.20

COPY config/repos.yaml /usr/local/etc/repos.yaml

RUN curl -L -s --output /usr/local/bin/terragrunt "https://github.com/gruntwork-io/terragrunt/releases/download/${terragrunt_version}/terragrunt_linux_amd64"
RUN chmod +x /usr/local/bin/terragrunt
