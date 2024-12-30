#!/bin/bash

# Load the optimization configuration
source ./config/optimization_policies.conf

echo "Optimizing Docker resources..."

# Iterate over each running container
for container in $(docker ps -q); do
  # Get container resource usage (CPU, memory)
  cpu_usage=$(docker stats --no-stream --format "{{.CPUPerc}}" $container | sed 's/%//')
  mem_usage=$(docker stats --no-stream --format "{{.MemPerc}}" $container | sed 's/%//')

  # Restart containers if CPU usage exceeds the threshold
  if (( $(echo "$cpu_usage > $CPU_OPT_THRESHOLD" | bc -l) )); then
    echo "Optimizing: Restarting container $container due to high CPU usage ($cpu_usage%)" >> logs/optimization.log
    docker restart $container
  fi

  # Restart containers if memory usage exceeds the threshold
  if (( $(echo "$mem_usage > $MEMORY_OPT_THRESHOLD" | bc -l) )); then
    echo "Optimizing: Restarting container $container due to high Memory usage ($mem_usage%)" >> logs/optimization.log
    docker restart $container
  fi
done
