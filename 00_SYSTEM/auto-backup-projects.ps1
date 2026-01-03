# Auto-Backup Script for Projects Folder
# Runs every 5 hours to backup Projects folder to GitHub (Koding repo)

$projectPath = "C:\Claude Code Projects\Projects\Koding"
$logFile = "C:\Claude Code Projects\Projects\00_SYSTEM\backup.log"

function Write-Log {
    param($message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $message" | Out-File -Append -FilePath $logFile
}

try {
    Write-Log "=== Auto-backup started ==="

    # Change to Koding project directory
    Set-Location $projectPath

    # Check if there are changes
    $status = git status --porcelain

    if ($status) {
        Write-Log "Changes detected, committing..."

        # Add all changes
        git add -A

        # Commit with timestamp
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
        git commit -m "Auto-backup: $timestamp - Projects folder updates"

        # Push to GitHub
        git push origin master

        Write-Log "Backup completed successfully"
    } else {
        Write-Log "No changes to backup"
    }

} catch {
    Write-Log "ERROR: $($_.Exception.Message)"
}

Write-Log "=== Auto-backup finished ==="
