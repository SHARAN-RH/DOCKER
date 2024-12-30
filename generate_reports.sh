#!/bin/bash

# Generate a report for Docker container resource usage

echo "Generating resource usage report..."
echo "Report generated on $(date)" > logs/resource_report.txt
echo "--------------------------------------------" >> logs/resource_report.txt

# Iterate over each running container
for container in $(docker ps -q); do
  cpu_usage=$(docker stats --no-stream --format "{{.CPUPerc}}" $container)
  mem_usage=$(docker stats --no-stream --format "{{.MemPerc}}" $container)
  disk_usage=$(docker system df -v | grep $container | awk '{print $4}')

  echo "Container: $container" >> logs/resource_report.txt
  echo "CPU Usage: $cpu_usage" >> logs/resource_report.txt
  echo "Memory Usage: $mem_usage" >> logs/resource_report.txt
  echo "Disk Usage: $disk_usage" >> logs/resource_report.txt
  echo "--------------------------------------------" >> logs/resource_report.txt
done

echo "Report saved to logs/resource_report.txt"
