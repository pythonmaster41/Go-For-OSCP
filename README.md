# Go-For-OSCP

# Tips
<b>Enable service on every reboot:</b>

update-rc.d <[service]> enable

<b>Extract link from html page:</b>

cat index.html | grep "href=" | cut -d "/" -f3| grep "debian.org" | cut -d '"' -f1 | sort -u





# Nmap
nmap -sS -sV -A -O --script="*-vuln-*" --script-args=unsafe=1 <[IP]>
