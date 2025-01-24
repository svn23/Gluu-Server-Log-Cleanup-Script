#!/bin/bash

# Log Cleanup Script for Gluu Server
# This script deletes old log files from specified directories, excluding critical logs, to manage storage efficiently.

# Define directories to check for old files
# Replace these with actual log directory paths
dir1="/var/log/oxauth"       # Directory for oxauth logs
dir2="/var/log/idp"          # Directory for identity provider logs
dir3="/var/log/scim"         # Directory for SCIM logs
dir4="/var/log/passport"     # Directory for passport logs

# Combine the directories into an array
DIRS=("$dir1" "$dir2" "$dir3" "$dir4")

# Time threshold in seconds (15 days = 1,296,000 seconds)
THRESHOLD=$((15 * 24 * 60 * 60))

# Current time in seconds since epoch
CURRENT_TIME=$(date +%s)

# Define critical logs that should not be deleted
STATIC_LOGS=(
    "oxauth.log"
    "oxauth_audit.log"
    "scim.log"
    "passport.log"
    "oxtrust.log"
    "oxtrust_audit.log"
    "http_request_response.log"
)

# Convert static logs to a regex pattern for matching
STATIC_LOGS_PATTERN=$(printf "|%s" "${STATIC_LOGS[@]}")
STATIC_LOGS_PATTERN="(${STATIC_LOGS_PATTERN:1})"

# Loop through each directory and process files
for DIR in "${DIRS[@]}"; do
    echo "Checking directory: $DIR"
    if [ ! -d "$DIR" ]; then
        echo "Directory '$DIR' does not exist. Skipping..."
        continue
    fi

    # Process each file in the directory
    for FILE in "$DIR"/* "$DIR"/.*; do
        if [ -f "$FILE" ]; then
            FILE_NAME=$(basename "$FILE")

            # Skip critical logs
            if [[ "$FILE_NAME" =~ $STATIC_LOGS_PATTERN ]]; then
                echo "Skipping critical log: $FILE_NAME"
                continue
            fi

            # Get the creation time of the file
            FILE_CREATION_TIME=$(stat -c %W "$FILE")
            
            # Fallback to modification time if creation time is unavailable
            if [ "$FILE_CREATION_TIME" -eq 0 ]; then
                FILE_CREATION_TIME=$(stat -c %Y "$FILE")
            fi

            # Calculate the file's age
            FILE_AGE=$((CURRENT_TIME - FILE_CREATION_TIME))

            # Delete files older than the threshold
            if [ "$FILE_AGE" -gt "$THRESHOLD" ]; then
                echo "Deleting old file: $FILE_NAME (Age: $((FILE_AGE / 86400)) days)"
                rm "$FILE"
            else
                echo "Keeping recent file: $FILE_NAME (Age: $((FILE_AGE / 86400)) days)"
            fi
        fi
    done
done

echo "Log cleanup completed."
exit 0
