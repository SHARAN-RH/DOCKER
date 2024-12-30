#!/bin/bash

LOG_FILE="logs/resource_usage.log"
MAX_SIZE=10485760  # 10MB

log_size=$(stat -c %s $LOG_FILE)

if [ $log_size -gt $MAX_SIZE ]; then
    mv $LOG_FILE "${LOG_FILE}.$(date +%F)"
    touch $LOG_FILE
fi
