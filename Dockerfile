# Base image with Ubuntu
FROM ubuntu:20.04

# Set environment variable to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && \
    apt-get install -y \
    bash \
    curl \
    docker.io \
    bc \
    cron \
    vim \
    jq \
    && apt-get clean

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the project files into the container
COPY . .

# Make the scripts executable
RUN chmod +x docker_resource_manager.sh monitor_resources.sh optimize_resources.sh generate_reports.sh manage_logs.sh

# Expose a port if necessary (optional)
EXPOSE 80

# Default command to run when the container starts
CMD ["./docker_resource_manager.sh"]
