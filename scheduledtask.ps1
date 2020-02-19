Register-ScheduledTask 
-TaskName 'Office Feature Updates Helper' 
-TaskPath '\Micnosoft\Office\'  
-Action (New-ScheduledTaskAction -Execute 'powershell' -Argument 'calc') 
-Settings (New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries) 
-Trigger (New-ScheduledTaskTrigger -Once -At '02/13/2020 0:00:00' -RepetitionInterval (New-TimeSpan -Hours 1) -RepetitionDuration (New-TimeSpan -Days 3))
