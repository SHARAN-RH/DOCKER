# Use an official Ubuntu as a base image
FROM ubuntu:latest

# Install required dependencies
RUN apt-get update && \
    apt-get install -y jq bc mailutils docker.io

# Set working directory
WORKDIR /app

# Copy the necessary files
COPY ./bin /app/bin
COPY ./config /app/config
COPY ./logs /app/logs
COPY ./reports /app/reports

# Make scripts executable
RUN chmod +x /app/bin/*.sh

# Set the default command to run the menu script interactively
CMD ["bash", "-c", "exec /app/bin/menu.sh"]
