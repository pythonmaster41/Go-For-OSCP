
#!/bin/bash

if [ $1 ];then
	echo "[*] Start Recon on $1..."
	Ip=$1
else
	echo ""
	echo "The tool perform a complete recon on target."
	echo "The output will be an nmap TCP,UDP & enum4linux service scan."
	echo ""
	echo "Use: ./ip_recon.sh <Ip>"
	exit 0
fi

# TCP Scan Services, OS Detection and vuln
nmap -sS -sV -O -A --script="*-vuln-*" $Ip > TCP_$Ip.txt
echo "[*] TCP Recon On $Ip Done!"

# UDP Soft Scan
nmap -sU --top-ports 15 $Ip --open > UDP_$Ip.txt
echo "[*] UDP Recon On $Ip Done!"

# enum4linux Scan
enum4linux $Ip > enum4linux_$Ip.txt
echo "[*] enum4linux Recon On $Ip Done!"
