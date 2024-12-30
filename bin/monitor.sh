#!/bin/bash

# Load configuration from config.json
CONFIG_FILE="config/config.json"
CPU_THRESHOLD=$(jq -r '.cpu_threshold' $CONFIG_FILE)
MEMORY_THRESHOLD=$(jq -r '.memory_threshold' $CONFIG_FILE)
DISK_THRESHOLD=$(jq -r '.disk_threshold' $CONFIG_FILE)

# Monitor resources for each running container
docker ps --format "{{.ID}}" | while read container_id; do
    cpu_usage=$(docker stats --no-stream --format "{{.CPUPerc}}" $container_id | sed 's/%//')
    memory_usage=$(docker stats --no-stream --format "{{.MemPerc}}" $container_id | sed 's/%//')
    disk_usage=$(docker inspect --format '{{.GraphDriver.Data.Mounts}}' $container_id | jq '.[] | select(.Type=="volume") | .Size' | awk '{sum+=$1} END {print sum}')

    # Check if usage exceeds thresholds
    if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
        ./alert.sh "CPU usage for container $container_id exceeded threshold"
    fi
    if (( $(echo "$memory_usage > $MEMORY_THRESHOLD" | bc -l) )); then
        ./alert.sh "Memory usage for container $container_id exceeded threshold"
    fi
    if (( $(echo "$disk_usage > $DISK_THRESHOLD" | bc -l) )); then
        ./alert.sh "Disk usage for container $container_id exceeded threshold"
    fi

    # Log the resource usage
    echo "$(date) - $container_id - CPU: $cpu_usage%, Memory: $memory_usage%, Disk: $disk_usage MB" >> logs/resource_usage.log
done
