#!/bin/bash

# Create a report from logs
echo "Date,Container ID,CPU Usage (%),Memory Usage (%),Disk Usage (MB)" > reports/usage_report.csv
cat logs/resource_usage.log | while read line; do
    date=$(echo $line | awk '{print $1 " " $2}')
    container_id=$(echo $line | awk '{print $4}')
    cpu_usage=$(echo $line | awk '{print $6}')
    memory_usage=$(echo $line | awk '{print $8}')
    disk_usage=$(echo $line | awk '{print $10}')

    echo "$date,$container_id,$cpu_usage,$memory_usage,$disk_usage" >> reports/usage_report.csv
done
