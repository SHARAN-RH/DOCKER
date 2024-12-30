#!/bin/bash

# Display the menu
function show_menu() {
    clear
    echo "===================================="
    echo " Docker Resource Management System "
    echo "===================================="
    echo "1. Monitor Resource Usage"
    echo "2. Send Alerts for Exceeded Thresholds"
    echo "3. Optimize Resource Usage"
    echo "4. Generate Resource Usage Report"
    echo "5. Manage Log Rotation"
    echo "6. Exit"
    echo "===================================="
    read -p "Choose an option (1-6): " choice
    case $choice in
        1) monitor_resources ;;
        2) send_alerts ;;
        3) optimize_resources ;;
        4) generate_report ;;
        5) manage_logs ;;
        6) exit_system ;;
        *) echo "Invalid choice. Please select a valid option." && sleep 2 && show_menu ;;
    esac
}

# Function to monitor resource usage
function monitor_resources() {
    echo "Monitoring resource usage..."
    ./bin/monitor.sh
    read -p "Press any key to return to the menu..." -n 1 -s
    show_menu
}

# Function to send alerts when thresholds are exceeded
function send_alerts() {
    echo "Sending alerts for exceeded thresholds..."
    ./bin/alert.sh
    read -p "Press any key to return to the menu..." -n 1 -s
    show_menu
}

# Function to optimize resource usage of containers
function optimize_resources() {
    echo "Optimizing resource usage..."
    ./bin/optimize.sh
    read -p "Press any key to return to the menu..." -n 1 -s
    show_menu
}

# Function to generate a resource usage report
function generate_report() {
    echo "Generating resource usage report..."
    ./bin/generate_report.sh
    echo "Report generated: reports/usage_report.csv"
    read -p "Press any key to return to the menu..." -n 1 -s
    show_menu
}

# Function to manage log rotation
function manage_logs() {
    echo "Managing log rotation..."
    ./bin/log_rotate.sh
    echo "Logs rotated successfully."
    read -p "Press any key to return to the menu..." -n 1 -s
    show_menu
}

# Function to exit the system
function exit_system() {
    echo "Exiting Docker Resource Management System..."
    exit 0
}

# Call the show_menu function to display the menu
show_menu
