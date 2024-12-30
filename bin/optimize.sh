#!/bin/bash

# Load config
CONFIG_FILE="config/config.json"
OPTIMIZE_POLICY=$(jq -r '.optimize_policy' $CONFIG_FILE)

docker ps --format "{{.ID}}" | while read container_id; do
    # Example of optimizing container CPU and Memory allocation
    if [ "$OPTIMIZE_POLICY" == "cpu" ]; then
        # Set resource limits for CPU
        docker update --cpu-shares 512 $container_id
    elif [ "$OPTIMIZE_POLICY" == "memory" ]; then
        # Set memory limit for the container
        docker update --memory 512m $container_id
    fi
done
