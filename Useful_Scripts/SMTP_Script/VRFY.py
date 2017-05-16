#!/usr/bin/python

import socket
import sys

if len(sys.argv)!=2:
	print "Usage: VRFY.py <username>"
	sys.exit(0)

s=socket.socket(socket.AF_INET, socket.SOCK_STREAM)
connect=s.connect(('10.11.1.72',25))
banner=s.recv(1024)
print banner
s.send('VRFY '+ sys.argv[1]+'\r\n')
result=s.recv(1024)
print result
s.close()
