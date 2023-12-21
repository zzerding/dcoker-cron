#!/bin/bash

set -e  # Set error exit

# Run the "exit" command when receiving SIGNAL
cleanup(){
    echo "Received stop signal. Stopping services..."
    echo "Services stopped. Exiting..."
    exit 0
}

trap 'cleanup' SIGINT SIGTERM

# Define the log file path
LOG_FILE=/var/log/cron.log


#crontab
touch "$LOG_FILE"
touch /crontab

#crontab file set
crontab /crontab && service cron restart

# Output logs for monitoring script execution
echo "cron configuration completed. Monitoring logs..."
tail -f  "$LOG_FILE" & wait
