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
SCRIPT_DIR=/var/run/script
CRON_FILE=/var/run/crontab



#crontab file set
if [[ ! -e "$CRON_FILE" ]];then
  touch "$CRON_FILE"
fi
echo "load cron and restart cron $(cat $CRON_FILE)"
crontab $CRON_FILE && service cron restart

echo "run other script to $SCRIPT_DIR $(ls -alh $SCRIPT_DIR)"

if [[ -d  "$SCRIPT_DIR" ]]; then
  find $SCRIPT_DIR -name "*.sh" -type f   -exec {} \; 
fi

# Output logs for monitoring script execution
echo "cron configuration completed. Monitoring logs..."
touch "$LOG_FILE"
tail -f  "$LOG_FILE" & wait
