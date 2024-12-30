#!/bin/bash

# Load the threshold configuration
source ./config/thresholds.conf

echo "Monitoring Docker resources..."

# Iterate over each running container
for container in $(docker ps -q); do
  # Get container name and other details
  container_name=$(docker inspect --format '{{.Name}}' $container | sed 's/\///g')
  container_id=$(docker inspect --format '{{.Id}}' $container)
  container_image=$(docker inspect --format '{{.Config.Image}}' $container)
  container_status=$(docker inspect --format '{{.State.Status}}' $container)
  container_uptime=$(docker inspect --format '{{.State.StartedAt}}' $container)

  # Get container resource usage (CPU, memory, disk)
  cpu_usage=$(docker stats --no-stream --format "{{.CPUPerc}}" $container | sed 's/%//')
  mem_usage=$(docker stats --no-stream --format "{{.MemPerc}}" $container | sed 's/%//')
  disk_usage=$(docker system df -v | grep $container | awk '{print $4}' | sed 's/%//')

  # Log container details
  echo "Logging details for container $container_name ($container_id):" >> logs/container_details.log
  echo "Container Name: $container_name" >> logs/container_details.log
  echo "Container ID: $container_id" >> logs/container_details.log
  echo "Image: $container_image" >> logs/container_details.log
  echo "Status: $container_status" >> logs/container_details.log
  echo "Uptime: $container_uptime" >> logs/container_details.log
  echo "CPU Usage: $cpu_usage%" >> logs/container_details.log
  echo "Memory Usage: $mem_usage%" >> logs/container_details.log
  echo "Disk Usage: $disk_usage%" >> logs/container_details.log
  echo "---------------------------" >> logs/container_details.log

  # Check if CPU usage exceeds the threshold
  if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
    echo "ALERT: CPU usage of container $container_name ($container_id) is above threshold: $cpu_usage%" >> logs/alerts.log
  fi

  # Check if memory usage exceeds the threshold
  if (( $(echo "$mem_usage > $MEMORY_THRESHOLD" | bc -l) )); then
    echo "ALERT: Memory usage of container $container_name ($container_id) is above threshold: $mem_usage%" >> logs/alerts.log
  fi

  # Check if disk usage exceeds the threshold
  if (( $(echo "$disk_usage > $DISK_THRESHOLD" | bc -l) )); then
    echo "ALERT: Disk usage of container $container_name ($container_id) is above threshold: $disk_usage%" >> logs/alerts.log
  fi
done
