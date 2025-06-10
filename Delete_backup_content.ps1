# Define paths

$targetPath = "Path_to_file"

$logDir = "Path_to_file"

# Ensure the log directory exists

if (-not (Test-Path -Path $logDir)) {

    New-Item -ItemType Directory -Path $logDir -Force | Out-Null

}

# Define log file with timestamp

$logFile = Join-Path $logDir ("DeletedBackups_{0}.log" -f (Get-Date -Format "yyyyMMdd_HHmmss"))

$deletedCount = 0

# Start the log

"Backup Cleanup Log - $(Get-Date)" | Out-File -FilePath $logFile

# Process files

Get-ChildItem -Path $targetPath -File |

    Where-Object {

        ($_.LastWriteTime -lt (Get-Date).AddDays(-45)) -and

        ($_.Extension -eq ".bak")

    } | ForEach-Object {

        try {

            Remove-Item -Path $_.FullName -Force -ErrorAction Stop

            "Deleted: $($_.FullName)" | Out-File -FilePath $logFile -Append

            $deletedCount++

        }

        catch {

            "ERROR deleting $($_.FullName): $_" | Out-File -FilePath $logFile -Append

        }

    }

# Final summary

"Total files deleted: $deletedCount" | Out-File -FilePath $logFile -Append
