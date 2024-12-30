#!/bin/bash

message=$1
# Send an email or system notification (You can replace this with any notification system like Slack, Email, etc.)
echo "ALERT: $message" | mail -s "Docker Resource Alert" sharanrhiremani@gmail.com
