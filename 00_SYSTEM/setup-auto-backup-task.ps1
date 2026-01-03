# Setup Task Scheduler for Projects Auto-Backup
# Runs every 5 hours to backup Projects folder to GitHub

$taskName = "ProjectsAutoBackup"
$scriptPath = "C:\Claude Code Projects\Projects\00_SYSTEM\auto-backup-projects.ps1"

Write-Host "Setting up Auto-Backup Task Scheduler..." -ForegroundColor Cyan

# Remove existing task if it exists
try {
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue
    Write-Host "Removed existing task" -ForegroundColor Yellow
} catch {
    # Task doesn't exist, that's fine
}

# Create action
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" `
    -Argument "-ExecutionPolicy Bypass -File `"$scriptPath`""

# Create trigger - every 5 hours
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Hours 5)

# Create principal (run whether user is logged on or not)
$principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -RunLevel Highest

# Create settings
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

# Register task
try {
    Register-ScheduledTask -TaskName $taskName `
        -Action $action `
        -Trigger $trigger `
        -Principal $principal `
        -Settings $settings `
        -Description "Auto-backup Projects folder to GitHub (Koding repo) every 5 hours"

    Write-Host "`n✅ Task Scheduler configured successfully!" -ForegroundColor Green
    Write-Host "Task Name: $taskName" -ForegroundColor Cyan
    Write-Host "Frequency: Every 5 hours" -ForegroundColor Cyan
    Write-Host "Script: $scriptPath" -ForegroundColor Cyan
    Write-Host "Log: C:\Claude Code Projects\Projects\00_SYSTEM\backup.log`n" -ForegroundColor Cyan

    Write-Host "NOTE: The task will run in the background even when you're not logged in." -ForegroundColor Yellow

} catch {
    Write-Host "`n❌ ERROR: Failed to register task" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host "`nPlease run this script as Administrator.`n" -ForegroundColor Yellow
}
