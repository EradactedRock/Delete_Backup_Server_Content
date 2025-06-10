# Delete_Backup_Server_Content
Available as a powershell script, and a bash script

This PowerShell script automates the cleanup of old .bak backup files in a specified directory. It performs the following tasks:

Defines Paths: Sets the target directory containing backup files and the directory for storing logs.

Ensures Log Directory Exists: Checks if the log directory exists, and creates it if it doesn’t.

Generates a Timestamped Log File: Logs all actions taken by the script.

Identifies and Deletes Old Backups:

Scans the target directory for .bak files that are older than 45 days.

Deletes each qualifying file.

Logs the deletion of each file.

Error Handling: Captures and logs any errors encountered during file deletion.

Summary: Outputs the total number of files deleted at the end of the process.

This script is useful for maintaining disk space by removing outdated backups, while maintaining a log of actions for auditing and troubleshooting.
