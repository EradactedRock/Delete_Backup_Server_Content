#7/10 updated the file to look for .BAK (uppercase) file extensions, since previous versions of script was looking for lowercase .bak files to delete. 

#!/bin/bash
#
# delete_old_backups.sh
# Deletes both .bak and .BAK files older than 45 days

# Define paths
TARGET_PATH="/volume1/Box/Backup_SQL03/Backup"
LOG_DIR="/volume1/Box/Backup_SQL03/Logs"

# Ensure the log directory exists
mkdir -p "$LOG_DIR"

# Define log file with timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_FILE="$LOG_DIR/DeletedBackups_${TIMESTAMP}.log"
DELETED_COUNT=0

# Start the log
echo "=== Backup Cleanup Log - $(date) ===" > "$LOG_FILE"
echo "Target Path: $TARGET_PATH" >> "$LOG_FILE"
echo "Looking for both .bak and .BAK files" >> "$LOG_FILE"

# Check directory exists
if [ ! -d "$TARGET_PATH" ]; then
    echo "ERROR: Target directory does not exist: $TARGET_PATH" >> "$LOG_FILE"
    exit 1
fi

# Process both .bak and .BAK files
for EXTENSION in "*.bak" "*.BAK"; do
    echo "Processing $EXTENSION files..." >> "$LOG_FILE"
    
    # Count files
    FOUND_COUNT=$(find "$TARGET_PATH" -type f -name "$EXTENSION" -mtime +45 | wc -l)
    echo "Found $FOUND_COUNT $EXTENSION files older than 45 days" >> "$LOG_FILE"
    
    # Delete files
    while IFS= read -r -d '' FILE
    do
        if [ -f "$FILE" ]; then
            if rm -f "$FILE"; then
                echo "SUCCESS: Deleted $FILE" >> "$LOG_FILE"
                ((DELETED_COUNT++))
            else
                echo "ERROR: Failed to delete $FILE" >> "$LOG_FILE"
            fi
        fi
    done < <(find "$TARGET_PATH" -type f -name "$EXTENSION" -mtime +45 -print0)
done

# Final summary
echo "=== SUMMARY ===" >> "$LOG_FILE"
echo "Total backup files deleted: $DELETED_COUNT" >> "$LOG_FILE"
echo "Script completed at: $(date)" >> "$LOG_FILE"
