#!/bin/bash

#

# delete_old_backups.sh

# Deletes .bak files older than 45 days and logs actions.

# Define paths

TARGET_PATH="path_to_file"

LOG_DIR="path_to_file"

# Ensure the log directory exists

mkdir -p "$LOG_DIR"

# Define log file with timestamp

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

LOG_FILE="$LOG_DIR/DeletedBackups_${TIMESTAMP}.log"

DELETED_COUNT=0

# Start the log

echo "Backup Cleanup Log - $(date)" > "$LOG_FILE"

# Process files

while IFS= read -r -d '' FILE

do

    if rm -f "$FILE"; then

        echo "Deleted: $FILE" >> "$LOG_FILE"

        ((DELETED_COUNT++))

    else

        echo "ERROR deleting $FILE" >> "$LOG_FILE"

    fi

done < <(find "$TARGET_PATH" -type f -name "*.bak" -mtime +45 -print0)

# Final summary

echo "Total files deleted: $DELETED_COUNT" >> "$LOG_FILE"

