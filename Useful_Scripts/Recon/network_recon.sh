#!/bin/bash

if [ $1 ];then
	echo "[*] Start Recon $1..."
	Network=$1
else
	echo ""
	echo "The tool perform a complete recon on target Network."
	echo "The output will be an IP list of servers divided by the following:"
	echo "Live Hosts, DNS Servers, SMB Servers, SMTP Servers, SNMP Servers,"
	echo "HTTP/s Servers, FTP Servers, SSH Servers."
	echo ""
	echo "Use: ./recon.sh <Network_Range>"
	exit 0
fi

# Live Hosts
nmap -sn $Network -oG /tmp/live-hosts.txt > /dev/null
cat /tmp/live-hosts.txt | grep "Up" | cut -d " " -f2 > live-hosts-ip.txt
rm /tmp/live-hosts.txt
Live_Host=live-hosts-ip.txt
echo "[*] Live Hosts Recon On $Network Done!"

# DNS Servers
nmap -sT -p53 -iL $Live_Host --open -oG /tmp/dns-server-tcp.txt > /dev/null
cat /tmp/dns-server-tcp.txt | grep "Up" | cut -d " " -f2 > /tmp/dns-server-tcp-ip.txt
nmap -sU -p53 -iL $Live_Host --open -oG /tmp/dns-server-udp.txt > /dev/null
cat /tmp/dns-server-udp.txt | grep "Up" | cut -d " " -f2 > /tmp/dns-server-udp-ip.txt
cat /tmp/*dns-server-* >> /tmp/dns-server-merge.txt
cat /tmp/dns-server-merge.txt | grep "Up" | cut -d " " -f2 | sort -u > dns-server-ip.txt
rm /tmp/dns-server-tcp.txt & rm /tmp/dns-server-udp.txt & rm /tmp/dns-server-tcp-ip.txt & rm /tmp/dns-server-udp-ip.txt & rm /tmp/dns-server-merge.txt
echo "[*] DNS Servers Recon On $Network Done!"

# SMB Servers
nmap -p139,445 -iL $Live_Host --open -oG /tmp/smb-server.txt > /dev/null
cat /tmp/smb-server.txt | grep "Up" | cut -d " " -f2 > smb-server-ip.txt
rm /tmp/smb-server.txt
echo "[*] SMB Servers Recon On $Network Done!"

# SMTP Servers
nmap -p25 -iL $Live_Host --open -oG /tmp/smtp-server.txt > /dev/null
cat /tmp/smtp-server.txt | grep "Up" | cut -d " " -f2 > smtp-server-ip.txt
rm /tmp/smtp-server.txt
echo "[*] SMTP Servers Recon On $Network Done!"

# SNMP Servers
nmap -sU -p161,162 -iL $Live_Host --open -oG /tmp/snmp-server.txt > /dev/null
cat /tmp/snmp-server.txt | grep "Up" | cut -d " " -f2 > snmp-server-ip.txt
rm /tmp/snmp-server.txt
echo "[*] SNMP Servers Recon On $Network Done!"

# HTTP/s Servers
nmap -p80,443 -iL $Live_Host --open -oG /tmp/http-server.txt > /dev/null
cat /tmp/http-server.txt | grep "Up" | cut -d " " -f2 > http-server-ip.txt
rm /tmp/http-server.txt
echo "[*] HTTP/s Servers Recon On $Network Done!"

# FTP Servers
nmap -p21 -iL $Live_Host --open -oG /tmp/ftp-server.txt > /dev/null
cat /tmp/ftp-server.txt | grep "Up" | cut -d " " -f2 > ftp-server-ip.txt
rm /tmp/ftp-server.txt
echo "[*] FTP Servers Recon On $Network Done!"

# SSH Servers
nmap -p22 -iL $Live_Host --open -oG /tmp/ssh-server.txt > /dev/null
cat /tmp/ssh-server.txt | grep "Up" | cut -d " " -f2 > ssh-server-ip.txt
rm /tmp/ssh-server.txt
echo "[*] SSH Servers Recon On $Network Done!"

