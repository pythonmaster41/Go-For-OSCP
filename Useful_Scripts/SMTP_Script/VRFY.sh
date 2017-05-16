#!/bin/bash

for user in $(cat users.txt);do
	echo VRFY $user | nc -nv -w 1 10.11.1.22 25 2>/dev/null | grep ^"250";
done
