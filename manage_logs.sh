#!/bin/bash

# Manage log rotation and archive old logs

LOG_DIR="logs"
LOG_FILE="$LOG_DIR/alerts.log"
MAX_SIZE=1000000  # 1 MB

echo "Managing logs..."

# Check if log file exceeds max size
if [ -f $LOG_FILE ] && [ $(stat -c %s "$LOG_FILE") -gt $MAX_SIZE ]; then
  echo "Log file size exceeds threshold. Rotating logs..."
  mv $LOG_FILE "$LOG_DIR/alerts_$(date +%F_%T).log"
  touch $LOG_FILE
fi

# Archive old logs older than 30 days
find $LOG_DIR -name "*.log" -type f -mtime +30 -exec mv {} $LOG_DIR/archive/ \;
