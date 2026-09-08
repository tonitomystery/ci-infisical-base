FROM registry.gitlab.com/gitlab-org/cloud-deploy/aws-base:latest

# Install curl, zip, and Infisical CLI, then clean up APT caches
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        zip && \
    curl -1sLf 'https://artifacts-cli.infisical.com/setup.deb.sh' | bash && \
    apt-get update && \
    apt-get install -y --no-install-recommends infisical && \
    apt-get purge -y --auto-remove && \
    rm -rf /var/lib/apt/lists/*
