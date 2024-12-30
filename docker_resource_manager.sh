#!/bin/bash

# Main menu for Docker Resource Management System

PS3="Choose an option: "

select option in "Monitor Resources" "Optimize Resources" "Generate Usage Reports" "Manage Logs" "Exit"
do
  case $option in
    "Monitor Resources")
      ./monitor_resources.sh
      ;;
    "Optimize Resources")
      ./optimize_resources.sh
      ;;
    "Generate Usage Reports")
      ./generate_reports.sh
      ;;
    "Manage Logs")
      ./manage_logs.sh
      ;;
    "Exit")
      echo "Exiting the Docker Resource Management System..."
      break
      ;;
    *)
      echo "Invalid option, please try again."
      ;;
  esac
done
