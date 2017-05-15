# Go-For-OSCP

# Tips
Enable service on every reboot:
update-rc.d <[service]> enable

Extract link from html page:

cat index.html | grep "href=" | cut -d "/" -f3| grep "debian.org" | cut -d '"' -f1 | sort -u





# Nmap
nmap -sS -sV -A -O --script="*-vuln-*" --script-args=unsafe=1 <[IP]>
